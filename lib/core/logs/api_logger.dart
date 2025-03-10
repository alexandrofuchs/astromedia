import 'package:astroimg/core/logs/app_logger.dart';

abstract class ApiLogger {
  static void onRequest(String method, String path, {dynamic body}) {
    AppLogger.log(
        serviceName: 'API-REQUEST',
        codeId: '$method $path',
        details: body,
        method: 'onRequest',
        namespace: 'ApiLogger');
  }

  static void onResponse(
      String method, String path, int? responseCode, dynamic data,
      {String? source}) {
    AppLogger.log(
      serviceName: 'API-RESPONSE',
      codeId: '$method $path',
      method: 'onResponse',
      namespace: 'ApiLogger',
      details: data,
    );
  }

  static void onError(String method, String type, dynamic data,
      {String? source}) {
    AppLogger.log(
      serviceName: 'API-ERROR',
      codeId: '$method $type',
      method: 'onError',
      namespace: 'ApiLogger',
      details: data,
    );
  }
}
