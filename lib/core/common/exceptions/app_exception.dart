
import 'package:astromedia/core/logs/app_logger.dart';

class AppException implements Exception {
  final Object id;
  final Object method;
  final Object namespace;
  final String? publicMessage;
  final Object? details;

  AppException({
    required this.id,
    required this.method,
    this.publicMessage,
    this.details,
    required this.namespace,
  }){
    AppLogger.log(serviceName: '-- APP EXCEPTION--', codeId: id.toString(), method: method, namespace: namespace, publicMessage: publicMessage, details: details);
  }
}