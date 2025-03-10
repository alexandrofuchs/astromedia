import 'package:astromedia/core/widgets/bottom_navigator/bloc/bottom_navigator_bloc.dart';
import 'package:flutter/material.dart';

abstract class BottomNavigatorRoutes {
  static Map<String, NavigationRoute> getNavigationRoutes() => {
        'home': const NavigationRoute(
          route: '/home/',
          label: 'Início',
          icon: Icon(
            Icons.home,
          ),
        ),
        'favorites': const NavigationRoute(
          route: '/favorites/',
          icon: Icon(
            Icons.favorite,
          ),
          label: 'Favoritos',
        ),
      };
}
