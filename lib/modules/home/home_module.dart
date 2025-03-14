import 'package:astromedia/modules/home/domain/astronomical_media_usecase.dart';
import 'package:astromedia/modules/home/domain/i_repositories/i_astronomical_media_repository.dart';
import 'package:astromedia/modules/home/domain/i_usecases/i_astronomical_media_usecase.dart';
import 'package:astromedia/modules/home/external/astronomical_media_repository.dart';
import 'package:astromedia/modules/home/presenter/bloc/astronomical_media_bloc.dart';
import 'package:astromedia/modules/home/presenter/pages/favorites/favorites_page.dart';
import 'package:astromedia/modules/home/presenter/pages/home/home_page.dart';
import 'package:astromedia/root/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeModule extends Module {
  
  @override
  List<Module> get imports => [
    AppModule(),
  ];
  
  @override
  void binds(Injector i) {

    i.addLazySingleton<IAstronomicalMediaRepository>(() => AstronomicalMediaRepository(i()));
    i.addLazySingleton<IAstronomicalMediaUsecase>(() => AstronomicalMediaUsecase(i()));

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => 
      HomePage(bloc: AstronomicalMediaBloc(Modular.get()), sharedPreferences: SharedPreferences.getInstance(),), transition: TransitionType.noTransition);
    r.child('/favorites', child: (context) => 
      FavoritesPage(bloc: AstronomicalMediaBloc(Modular.get()), sharedPreferences: SharedPreferences.getInstance() ,), transition: TransitionType.noTransition);
    super.routes(r);
  }
}