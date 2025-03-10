import 'package:astromedia/core/external/api/domain/i_interceptor/i_request_interceptor.dart';
import 'package:astromedia/core/logs/api_logger.dart';
import 'package:dio/dio.dart';

part 'interceptors_part.dart';

late String baseUrl;
// late String accessToken;
late String apiKey;

class ApiRequestInterceptor with InterceptorsPart
    implements IRequestInterceptor {

  ApiRequestInterceptor() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      validateStatus: (status) => true,
      headers: {
        'Accept': 'Application/json',
      },
      connectTimeout: const Duration(seconds: 30),
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: _onRequest,
      onResponse: _onResponse,
      onError: _onError,
    ));
  }

  late final Dio _dio;

  @override
  Future get(String path, {Object? data}) async {
    final response = await _dio.get(
      path,
      data: data,
    );
    response.requestOptions.uri;
    return response.data;
  }

  @override
  Future post(String path, {Object? data}) async {
    final response = await _dio.post(path, data: data);
    return response.data;
  }

  @override
  Future put(String path, {Object? data}) async {
    final response = await _dio.put(path, data: data);
    return response.data;
  }
  
  @override
  void dispose() {
    _dio.close();
  }
}
