import 'dart:async';

import 'package:dio/dio.dart';
import 'package:oasis/common/common.dart';
import 'package:oasis/common/models/abstract.api.model.dart';
import 'package:oasis/common/models/token.model.dart';
import 'package:oasis/core/database/session.service.dart';
import 'package:oasis/core/integrations/integrations.dart';

class TokenInterceptor extends Interceptor {
  TokenInterceptor({required this.client, required this.sessionService});

  final ApiClient client;
  final SessionService sessionService;

  bool hasLogout = false;
  bool _isRefreshing = false;
  Completer<TokenModel?>? _refreshCompleter;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Check if error is due to expired token
    // ignore: avoid_dynamic_calls
    if ((err.response?.data?['message'] ?? "").toString().contains(
              'User session has expired',
            ) ==
            true &&
        err.response?.statusCode == 401) {
      final options = err.requestOptions;

      try {
        final refreshToken = await client.secureStorage.read(
          DbKeys.REFRESH_TOKEN,
        );

        if (refreshToken == null || refreshToken.isEmpty) {
          // No refresh tokena available, proceed with logout
          logMeOut();
          return handler.next(err);
        }

        final token = await _refreshToken(refreshToken);

        // Check if refresh was successful
        if (token != null) {
          // Retry the original request with new token
          final clonedRequest = await _retry(options, token.auth_token ?? "");
          return handler.resolve(clonedRequest);
        }

        // If refresh failed, logout the user
        logMeOut();
        return handler.next(err);
      } catch (e) {
        // Error during refresh, logout user
        AppLogger.error(e, 'Token refresh error');
        logMeOut();
        return handler.next(err);
      }
    }

    // For other errors, just continue
    return handler.next(err);
  }

  void logMeOut() {
    if (!hasLogout) sessionService.logout();
    hasLogout = true;

    Future.delayed(const Duration(seconds: 5), () {
      hasLogout = false;
    });
  }

  Future<Response<dynamic>> _retry(
    RequestOptions requestOptions,
    String newToken,
  ) async {
    final options = Options(
      method: requestOptions.method,
      headers: {...requestOptions.headers, 'auth_token': newToken},
    );

    return client.dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  Future<TokenModel?> _refreshToken(String refreshCat) async {
    // If already refreshing, wait for that operation to complete
    if (_isRefreshing) {
      return _refreshCompleter!.future;
    }

    // Start a new refresh operation
    _isRefreshing = true;
    _refreshCompleter = Completer<TokenModel?>();

    try {
      final raw = await client.post(
        Endpoints.REFRESH,
        data: {'refresh_cat': refreshCat},
      );

      final res = handleResponse(raw);

      if (res.status) {
        final token = TokenModel.fromJson(res.data);

        await Future.wait([
          client.secureStorage.write(DbKeys.ACCESS_TOKEN, token.auth_token),
          client.secureStorage.write(DbKeys.REFRESH_TOKEN, token.refreshCat),
        ]);

        _refreshCompleter!.complete(token);

        return token;
      } else {
        _refreshCompleter!.complete(null);
        return null;
      }
    } catch (e) {
      _refreshCompleter!.complete(null);
      return null;
    } finally {
      // Reset the refreshing state
      _isRefreshing = false;
      _refreshCompleter = null;
    }
  }
}
