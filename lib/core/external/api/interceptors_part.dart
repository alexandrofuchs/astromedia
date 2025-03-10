part of 'api_request_interceptor.dart';

mixin InterceptorsPart {
  void _onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    ApiLogger.onRequest(options.method, options.path, body: options.data);
    handler.next(options);
  }

  void _onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) async {
    ApiLogger.onResponse(response.requestOptions.method,
        response.requestOptions.path, response.statusCode, response.data);
    handler.next(response);
  }

  void _onError(DioException error, ErrorInterceptorHandler handler) {
    ApiLogger.onError(
        error.requestOptions.method, error.type.name, error.error);

    late Map<String, dynamic> data;
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        data = {
          "codigo": 503,
          "mensagem": "tempo de conexão expirado!",
          "details": error.type.name
        };
        break;
      case DioExceptionType.sendTimeout:
        data = {
          "codigo": 503,
          "mensagem": "tempo de envio expirado!",
          "details": error.type.name
        };
        break;
      case DioExceptionType.receiveTimeout:
        data = {
          "codigo": 503,
          "mensagem": "tempo de resposta expirado!",
          "details": error.type.name
        };
        break;
      case DioExceptionType.badCertificate:
        data = {
          "codigo": 503,
          "mensagem": "Não foi possível completar a requisição!",
          "details": error.type.name
        };
        break;
      case DioExceptionType.badResponse:
        data = {
          "codigo": 503,
          "mensagem": "Não foi possível completar a requisição!",
          "details": error.type.name
        };
        break;
      case DioExceptionType.cancel:
        data = {
          "codigo": 503,
          "mensagem": "A requisição foi cancelada!",
          "details": error.type.name
        };
        break;
      case DioExceptionType.connectionError:
        data = {
          "codigo": 503,
          "mensagem": "Sem conexão!",
          "details": error.type.name
        };
        break;
      case DioExceptionType.unknown:
        data = {
          "codigo": 503,
          "mensagem": "Não foi possivel completar a requisição!",
          "details": error.type.name
        };
        break;
    }

    handler.resolve(Response(
        requestOptions: error.requestOptions,
        data: data,
        statusCode: 503,
        statusMessage: "Serviço indisponível."));
  }
}
