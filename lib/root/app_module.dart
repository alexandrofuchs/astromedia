import 'package:astromedia/core/external/api/api_request_interceptor.dart';
import 'package:astromedia/core/external/api/domain/i_interceptor/i_request_interceptor.dart';
import 'package:astromedia/modules/home/home_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addSingleton<IRequestInterceptor>(() => ApiRequestInterceptor());

    super.exportedBinds(i);
  }

  @override
  void routes(r) {
    r.module('/', module: HomeModule());
  }
}
