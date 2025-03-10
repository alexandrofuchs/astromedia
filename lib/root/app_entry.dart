import 'package:astromedia/core/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppEntry extends StatelessWidget {
  const AppEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Astromidia',
      theme: AppTheme.theme(isDarkMode: true),
      routerConfig: Modular.routerConfig,
    );
  }
}
