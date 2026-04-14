// ignore_for_file: avoid_dynamic_calls, type_annotate_public_apis

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:oasis/common/common.dart';

class NetworkExceptions {
  static String getDioException(dynamic error) {
    if (error is Exception) {
      try {
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              return 'Request cancelled';
            case DioExceptionType.connectionTimeout:
              return 'Connection timed out!';
            case DioExceptionType.receiveTimeout:
              return 'Request timed out';
            case DioExceptionType.badResponse:
              return error.response?.data['message'];
            case DioExceptionType.sendTimeout:
              return 'Request timed out';
            case DioExceptionType.unknown:
              return 'You have no internet connection!';
            case DioExceptionType.badCertificate:
            case DioExceptionType.connectionError:
              return 'You have no internet connection!';
          }
        } else if (error is SocketException) {
          return 'No internet connection!';
        } else {
          return AppTexts.GENERIC_ERROR;
        }
      } on FormatException {
        return 'Bad response format';
      } catch (_) {
        return AppTexts.GENERIC_ERROR;
      }
    } else {
      // FirebaseCrashlytics.instance.recordError(error, StackTrace.current);
      if (error.toString().contains('is not a subtype of')) {
        return AppTexts.GENERIC_ERROR;
      } else {
        return AppTexts.GENERIC_ERROR;
      }
    }
  }
}
