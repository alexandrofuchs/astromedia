import 'package:flutter/material.dart';

abstract class AppLogger {
  static void log(
      {required String serviceName,
      required Object codeId,
      required Object method,
      required Object namespace,
      String? publicMessage,
      Object? details}) {
    debugPrint(
        '-----------------------------------------------------------------------');
    debugPrint('''
    -- LOG: ${serviceName.toUpperCase()} --
    - CODE|ID: $codeId
    - MESSAGE: $publicMessage
    - METHOD|FUNCTION: ${method.toString()}
    - NAMESPACE: $namespace
    - DETAILS|DATA: $details''');
    debugPrint(
        '-----------------------------------------------------------------------');
  }

  static void info(
      {required String serviceName,
      required String message,
      required Object method,
      required Object namespace}) {
    debugPrint(
        '-----------------------------------------------------------------------');
    debugPrint('''
    -- INFO: ${serviceName.toUpperCase()} --
    - MESSAGE: $message
    - METHOD|FUNCTION: ${method.toString()}
    - NAMESPACE: $namespace''');
    debugPrint(
        '-----------------------------------------------------------------------');
  }
}
