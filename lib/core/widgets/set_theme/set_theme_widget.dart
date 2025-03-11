import 'package:astromedia/core/widgets/set_theme/theme_mode_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

mixin SetThemeWidget {
  final controller = Modular.get<ThemeModeController>();

  Widget setThemeModeAction() => IconButton(
    onPressed: () async {
      await controller.setTheme(controller.themeMode == ThemeMode.light);
    },
    icon: Icon(
      controller.themeMode == ThemeMode.dark
          ? Icons.light_mode
          : Icons.dark_mode,
    ),
  );
}
