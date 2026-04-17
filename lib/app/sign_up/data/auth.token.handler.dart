import 'dart:async';

import 'package:dio/dio.dart';
import 'package:oasis/common/common.dart';
import 'package:oasis/common/models/abstract.api.model.dart';
import 'package:oasis/common/models/token.model.dart';
import 'package:oasis/components/widgets/top_snackbar.dart';
import 'package:oasis/core/integrations/integrations.dart';

// class TokenInterceptor extends Interceptor {
//   TokenInterceptor({required this.client, required this.onLogout});
//
//   final ApiClient client;
//   final Future<void> Function() onLogout;
//
//   bool hasLogout = false;
//   bool _isRefreshing = false;
//   Completer<TokenModel?>? _refreshCompleter;
//
//   @override
//   Future<void> onError(
//     DioException err,
//     ErrorInterceptorHandler handler,
//   ) async {
//     // Check if error is due to expired token
//     // ignore: avoid_dynamic_calls
//     if ((err.response?.data?['message'] ?? "").toString().contains(
//               'User session has expired',
//             ) ==
//             true &&
//         err.response?.statusCode == 401) {
//       final options = err.requestOptions;
//
//       try {
//         final refreshToken = await client.secureStorage.read(
//           DbKeys.REFRESH_TOKEN,
//         );
//
//         if (refreshToken == null || refreshToken.isEmpty) {
//           // No refresh tokena available, proceed with logout
//           logMeOut();
//           return handler.next(err);
//         }
//
//         final token = await _refreshToken(refreshToken);
//
//         // Check if refresh was successful
//         if (token != null) {
//           // Retry the original request with new token
//           final clonedRequest = await _retry(options, token.value ?? "");
//           return handler.resolve(clonedRequest);
//         }
//
//         // If refresh failed, logout the user
//         logMeOut();
//         return handler.next(err);
//       } catch (e) {
//         // Error during refresh, logout user
//         AppLogger.error(e, 'Token refresh error');
//         logMeOut();
//         return handler.next(err);
//       }
//     }
//
//     // For other errors, just continue
//     return handler.next(err);
//   }
//
//   void logMeOut() {
//     if (!hasLogout) onLogout();
//     hasLogout = true;
//
//     Future.delayed(const Duration(seconds: 5), () {
//       hasLogout = false;
//     });
//   }
//
//   Future<Response<dynamic>> _retry(
//     RequestOptions requestOptions,
//     String newToken,
//   ) async {
//     final options = Options(
//       method: requestOptions.method,
//       headers: {...requestOptions.headers, 'Authorization': 'Bearer $newToken'},
//     );
//
//     return client.dio.request<dynamic>(
//       requestOptions.path,
//       data: requestOptions.data,
//       queryParameters: requestOptions.queryParameters,
//       options: options,
//     );
//   }
//
//   Future<TokenModel?> _refreshToken(String refreshCat) async {
//     // If already refreshing, wait for that operation to complete
//     if (_isRefreshing) {
//       return _refreshCompleter!.future;
//     }
//
//     // Start a new refresh operation
//     _isRefreshing = true;
//     _refreshCompleter = Completer<TokenModel?>();
//
//     try {
//       final raw = await client.post(Endpoints.REFRESH);
//
//       final res = handleResponse(raw);
//
//       if (res.status) {
//         final token = TokenModel.fromJson(res.data);
//
//         await Future.wait([
//           client.secureStorage.write(DbKeys.ACCESS_TOKEN, token.value),
//         ]);
//
//         _refreshCompleter!.complete(token);
//
//         return token;
//       } else {
//         _refreshCompleter!.complete(null);
//         return null;
//       }
//     } catch (e) {
//       _refreshCompleter!.complete(null);
//       return null;
//     } finally {
//       _isRefreshing = false;
//       _refreshCompleter = null;
//     }
//   }
// }

class TokenInterceptor extends Interceptor {
  TokenInterceptor({required this.client, required this.onLogout});

  final ApiClient client;
  final Future<void> Function() onLogout;

  bool hasLogout = false;
  Timer? _refreshTimer;
  Timer? _countdownTimer;

  /// Call this immediately after login AND after every successful refresh
  void scheduleRefreshFromExpiry(int expiryInSeconds) {
    _refreshTimer?.cancel();
    _countdownTimer?.cancel();

    final expiryTime = DateTime.fromMillisecondsSinceEpoch(
      expiryInSeconds * 1000,
    );

    // Fire 7 minutes before expiry
    final refreshAt = expiryTime.subtract(const Duration(minutes: 5));
    final delay = refreshAt.difference(DateTime.now());

    if (delay.isNegative) {
      _doRefresh();
      return;
    }
    AppLogger.info(
      'Next token refresh in ${delay.inMinutes}m ${delay.inSeconds % 60}s',
    );

    _refreshTimer = Timer(delay, _doRefresh);

    _countdownTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      final remaining = refreshAt.difference(DateTime.now());

      if (remaining.isNegative) {
        timer.cancel();
        return;
      }

      AppLogger.info(
        '⏳ Token refresh in ${remaining.inMinutes}m ${remaining.inSeconds % 60}s',
      );
    });
  }

  Future<void> _doRefresh() async {
    try {
      final raw = await client.post(Endpoints.REFRESH);
      AppLogger.info(raw.data, 'RAW dio response');
      AppLogger.info(raw.statusCode, 'RAW status code');

      final res = handleResponse(raw);
      AppLogger.info(res.data, 'handleResponse → res.data');
      AppLogger.info(res.status, 'handleResponse → res.status');

      if (res.status) {
        final data = res.data;

        if (data == null) {
          AppLogger.error(
            'Refresh response data is null',
            'Token refresh failed',
          );
          logMeOut();
          return;
        }

        final tokenMap = data['token'] as Map<String, dynamic>?;

        if (tokenMap == null) {
          AppLogger.error(
            'Token key missing from refresh response: $data',
            'Token refresh failed',
          );
          logMeOut();
          return;
        }

        final token = TokenModel.fromJson(tokenMap);

        if (token.value == null || token.expiry == null) {
          AppLogger.error(
            'Token value or expiry is null: $tokenMap',
            'Token refresh failed',
          );
          logMeOut();
          return;
        }

        await Future.wait([
          client.secureStorage.write(DbKeys.ACCESS_TOKEN, token.value),
          client.secureStorage.write(
            DbKeys.TOKEN_EXPIRY,
            token.expiry.toString(),
          ),
        ]);

        AppLogger.info('Token refreshed. New expiry: ${token.expiry}');
        scheduleRefreshFromExpiry(token.expiry!);
      } else {
        logMeOut();
      }
    } catch (e) {
      AppLogger.error(e, 'Token refresh failed');
      logMeOut();
    }
  }

  /// Safety net only — should rarely trigger if timer is working
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final isExpiredSession =
        (err.response?.data?['message'] ?? '').toString().contains(
          'Unauthenticated',
        ) &&
        err.response?.statusCode == 401;

    if (isExpiredSession) {
      logMeOut();
    }

    return handler.next(err);
  }

  void logMeOut() {
    if (!hasLogout) onLogout();
    hasLogout = true;
    _refreshTimer?.cancel();
    _countdownTimer?.cancel();
    TopSnackbar.show("Session expired. You've been logged out.");
    Future.delayed(const Duration(seconds: 5), () => hasLogout = false);
  }

  void dispose() {
    _refreshTimer?.cancel();
    _countdownTimer?.cancel();
  }
}
