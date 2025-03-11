import 'package:astromedia/core/themes/app_theme.dart';
import 'package:astromedia/core/widgets/set_theme/theme_mode_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppEntry extends StatefulWidget {
  const AppEntry({super.key});

  @override
  State<StatefulWidget> createState() => _AppEntryState();
}

class _AppEntryState extends State<AppEntry> {

  @override
  void initState() {
    Modular.get<ThemeModeController>().loadTheme(setState);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/home/');

    return  MaterialApp.router(
      title: 'Astromidia',
      theme: AppTheme.theme(),
      themeMode: Modular.get<ThemeModeController>().themeMode,
      darkTheme: AppTheme.darkTheme(),
      routerConfig: Modular.routerConfig,
    );
  }
}
