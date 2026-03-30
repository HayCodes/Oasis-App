import 'dart:developer';

import 'package:oasis/environment.dart';

const ENABLE_LOGS = true;

class AppLogger {
  static void error(dynamic message, [String? name, StackTrace? stackTrace]) {
    if (environment.isDebugging && ENABLE_LOGS) {
      log(
        message.toString(),
        name: name ?? 'error',
        level: 1000,
        stackTrace: stackTrace,
      );
    }
  }

  static void info(dynamic message, [String? name]) {
    if (environment.isDebugging && ENABLE_LOGS) {
      log(message.toString(), level: 50, name: name ?? 'info');
    }
  }
}
