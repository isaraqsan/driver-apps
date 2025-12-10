import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/widgets.dart' show debugPrint;
import 'package:gibas/core/service/env_service.dart';

class Log {

  static void print(String value) {
    if (kDebugMode && EnvService().debug) debugPrint(value);
  }

  static void e(dynamic value, {String? tag = 'ERROR'}) {
    print('\x1B[31m[ $tag ] $value\x1B[0m');
  }

  static void s(dynamic value, {String? tag = 'SUCCESS'}) {
    print('\x1B[32m[ $tag ] $value\x1B[0m');
  }

  static void w(dynamic value, {String? tag = 'WARNING'}) {
    print('\x1B[33m[ $tag ] $value\x1B[0m');
  }

  static void t(dynamic value, {String? tag = 'TRACE'}) {
    print('\x1B[34m[ $tag ] $value\x1B[0m');
  }

  static void v(dynamic value, {String? tag = 'VERBOSE'}) {
    print('\x1B[35m[ $tag ] $value\x1B[0m');
  }

  static void i(dynamic value, {String? tag = 'INFO'}) {
    print('\x1B[36m[ $tag ] $value\x1B[0m');
  }

  static void d(dynamic value, {String? tag = 'DEBUG'}) {
    print('\x1B[37m[ $tag ] $value\x1B[0m');
  }
}
