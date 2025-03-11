import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeController {
  final Future<SharedPreferencesWithCache> _sharedPreferences =
      SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions(
          allowList: <String>{'dark_theme_mode'},
        ),
      );

  late final Function _setState;
  ThemeMode themeMode = ThemeMode.system;

  Future<void> loadTheme(Function setState) async {
    try {
      _setState = setState;
      final SharedPreferencesWithCache prefs = await _sharedPreferences;
      final bool mode = prefs.getBool('dark_theme_mode') ?? false;
      setState(() {
        themeMode = mode ? ThemeMode.dark : ThemeMode.light;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> setTheme(bool darkMode) async {
    try {
      final SharedPreferencesWithCache prefs = await _sharedPreferences;
      final bool mode = prefs.getBool('dark_theme_mode') ?? false;
      await prefs.setBool('dark_theme_mode', !mode);
      _setState(() {
        themeMode = !mode ? ThemeMode.dark : ThemeMode.light;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
