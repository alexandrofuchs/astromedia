import 'package:astroimg/core/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppEntry extends StatelessWidget {
  const AppEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Astronomical',
      theme: AppTheme.theme(),
      routerConfig: Modular.routerConfig,
    );
  }
}
