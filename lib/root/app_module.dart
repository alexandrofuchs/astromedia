import 'package:astromedia/core/external/api/api_request_interceptor.dart';
import 'package:astromedia/core/external/api/domain/i_interceptor/i_request_interceptor.dart';
import 'package:astromedia/core/widgets/bottom_navigator/bloc/bottom_navigator_bloc.dart';
import 'package:astromedia/core/widgets/bottom_navigator/bloc/navigation_routes.dart';
import 'package:astromedia/modules/home/home_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addSingleton<IRequestInterceptor>(() => ApiRequestInterceptor());
    i.addSingleton<BottomNavigatorBloc>(
      () =>
          BottomNavigatorBloc()
            ..loadNavigationRoutes(BottomNavigatorRoutes.getNavigationRoutes()),
    );

    super.exportedBinds(i);
  }

  @override
  void routes(r) {
    r.module('/home', module: HomeModule());
  }
}
