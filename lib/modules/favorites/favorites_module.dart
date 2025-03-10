import 'package:astromedia/modules/favorites/presenter/pages/favorites_page.dart';
import 'package:astromedia/root/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FavoritesModule extends Module {
  @override
  List<Module> get imports => [AppModule()];

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => FavoritesPage());
    super.routes(r);
  }
}
