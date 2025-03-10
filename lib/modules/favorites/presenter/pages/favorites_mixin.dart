import 'package:astromedia/core/helpers/extensions/datetime_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

mixin FavoritesMixin {
  final Future<SharedPreferencesWithCache> _sharedPreferences =
      SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions(
          allowList: <String>{'dates'},
        ),
      );

  final ValueNotifier<List<String>> storedDates = ValueNotifier([]);

  Future<void> saveFavorite(DateTime? date) async {
    try {
      if(date == null) return;

      final SharedPreferencesWithCache prefs = await _sharedPreferences;
      final List<String> dates = [
        ...(prefs.getStringList('dates') ?? []),
        date.toYearMonthDayString(),
      ];
      await prefs.setStringList('dates', dates);
      storedDates.value = dates;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getFavorites() async {
    try {
      final SharedPreferencesWithCache prefs = await _sharedPreferences;
      final List<String> dates = prefs.getStringList('dates') ?? [];
      storedDates.value = dates;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
