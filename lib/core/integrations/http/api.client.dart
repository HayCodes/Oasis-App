import 'dart:async';

import 'package:dio/dio.dart';
import 'package:oasis/app/sign_up/data/auth.token.handler.dart';
import 'package:oasis/common/common.dart';
import 'package:oasis/core/database/database.dart';
import 'package:oasis/environment.dart';

class ApiClient {
  ApiClient(this.dio, this.secureStorage, this.sharedPrefs) {
    dio.options
      ..baseUrl = appConfig.baseUrl
      ..connectTimeout = const Duration(seconds: 300)
      ..receiveTimeout = const Duration(seconds: 300)
      ..headers.addAll({
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });

    dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await secureStorage.read(DbKeys.ACCESS_TOKEN);
          options.headers['Authorization'] = 'Bearer $token';

          AppLogger.info({
            'type': 'request',
            'url': options.uri,
            'method': options.method,
            'data': options.data,
            'auth_token': options.headers['Authorization'],
            'device_id': options.headers['device_id'],
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
            'status': e.response?.statusCode,
            'message': e.message,
            'error_type': e.type.name,
          }, 'on-error');
          return handler.next(e);
        },
      ),
      TokenInterceptor(
        client: this,
        onLogout: () async {
          await secureStorage.deleteAll();
          await sharedPrefs.clear();
        },
      ),
    ]);
  }

  final Dio dio;
  final SecureStorage secureStorage;
  final SharedPrefs sharedPrefs;

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
        case DioExceptionType.sendTimeout:
          return Exception('Request timed out.');
        case DioExceptionType.badResponse:
          final status = e.response?.statusCode;
          final data = e.response?.data as Map<String, dynamic>?;
          final msg = data?['message'] ?? 'Server error';
          return Exception('[$status] $msg');
        case DioExceptionType.connectionError:
          return Exception('No internet connection.');
        case DioExceptionType.cancel:
          return Exception('Request was cancelled.');
        case DioExceptionType.badCertificate:
          return Exception('Bad certificate.');
        case DioExceptionType.unknown:
          return Exception('Unexpected error: ${e.message}');
      }
    }
    return Exception(e.toString());
  }
}
