import 'package:dio/dio.dart';
import 'package:oasis/common/common.dart';
import 'package:oasis/common/logger.dart';
import 'package:oasis/core/database/database.dart';
import 'package:oasis/environment.dart';

class ApiClient {
  ApiClient(
    this.dio,
    this.secureStorage,
    this.sharedPrefs, {
    required this.onLogout,
  }) {
    dio.options
      ..baseUrl = appConfig.baseUrl
      ..connectTimeout = const Duration(milliseconds: 15000)
      ..headers.addAll({
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });

    dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await secureStorage.read(DbKeys.ACCESS_TOKEN);
          options.headers['auth_token'] = token;

          AppLogger.info({
            'type': 'request',
            'url': options.uri,
            'method': options.method,
            'data': options.data,
          }, 'on-request');

          return handler.next(options);
        },
        onResponse: (response, handler) {
          AppLogger.info({
            'type': 'response',
            'url': response.requestOptions.uri,
            'data': response.data,
          }, 'on-response');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          AppLogger.info({
            'type': 'error',
            'url': e.requestOptions.uri,
            'data': e.response?.data,
          }, 'on-error');
          return handler.next(e);
        },
      ),
      TokenInterceptor(client: this, onLogout: onLogout),
    ]);
  }

  final Dio dio;
  final SecureStorage secureStorage;
  final SharedPrefs sharedPrefs;
  final VoidCallback onLogout; // injected, not hardcoded

  Future<Response> get(
    String url, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await dio.get(
        url,
        queryParameters: params,
        options: Options(headers: headers),
      );
    } on FormatException {
      throw const FormatException('Bad response format 👎');
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post<T>(
    String url, {
    T? data,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    ProgressCallback? onProgress,
  }) async {
    try {
      return await dio.post(
        url,
        data: data,
        queryParameters: params,
        options: Options(headers: headers),
        onSendProgress: onProgress,
      );
    } on FormatException {
      throw const FormatException('Bad response format 👎');
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> patch<T>(
    String url, {
    T? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await dio.patch(
        url,
        data: data,
        options: Options(headers: headers),
      );
    } on FormatException {
      throw const FormatException('Bad response format 👎');
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> put<T>(
    String url, {
    T? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await dio.put(
        url,
        data: data,
        options: Options(headers: headers),
      );
    } on FormatException {
      throw const FormatException('Bad response format 👎');
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> delete<T>(
    String url, {
    T? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await dio.delete(
        url,
        data: data,
        options: Options(headers: headers),
      );
    } on FormatException {
      throw const FormatException('Bad response format 👎');
    } catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(dynamic e) {
    if (e is DioException) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          return Exception('Request timed out.');
        case DioExceptionType.badResponse:
          final status = e.response?.statusCode;
          final msg = e.response?.data?['message'] ?? 'Server error';
          return Exception('[$status] $msg');
        case DioExceptionType.connectionError:
          return Exception('No internet connection.');
        default:
          return Exception('Unexpected error: ${e.message}');
      }
    }
    return Exception(e.toString());
  }
}
