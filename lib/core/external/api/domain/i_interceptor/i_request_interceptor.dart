import 'package:flutter_modular/flutter_modular.dart';

abstract class IRequestInterceptor implements Disposable{
  Future<dynamic> get(String path, {Object? data});
  Future<dynamic> put(String path, {Object? data});
  Future<dynamic> post(String path, {Object? data});
}