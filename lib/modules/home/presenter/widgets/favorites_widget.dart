import 'package:astromedia/core/helpers/extensions/datetime_extension.dart';
import 'package:astromedia/core/themes/app_colors.dart';
import 'package:astromedia/core/widgets/snackbars/app_snackbars.dart';
import 'package:astromedia/modules/home/domain/models/astronomical_media_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

mixin FavoritesWidget {
  final Future<SharedPreferencesWithCache> _sharedPreferences =
      SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions(
          allowList: <String>{'dates'},
        ),
      );

  final ValueNotifier<List<String>> storedDates = ValueNotifier([]);

  Future<bool> saveFavorite(DateTime? date) async {
    try {
      if (date == null) return false;

      final SharedPreferencesWithCache prefs = await _sharedPreferences;
      
      var dates = prefs.getStringList('dates') ?? [];

      final contains = dates.contains(date.toYearMonthDayString());
      if(contains){
        dates.remove(date.toYearMonthDayString());
      }else{
        dates = [
          ...dates,
          date.toYearMonthDayString(),
        ];
      }

      await prefs.setStringList('dates', dates..sort((a, b) => a.compareTo(b),));
      storedDates.value = dates;
      return contains;
    } catch (e) {
      debugPrint(e.toString());
      return false;
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

  Widget favoriteAction(BuildContext context, AstronomicalMediaModel model) =>
      Container(
        padding: const EdgeInsets.all(15),
        child: GestureDetector(
          onTap: () async {
            final contains = await saveFavorite(model.date);
            if (!context.mounted) return;
            AppSnackbars.showSuccessSnackbar(context, contains ? 'removido dos favoritos' : 'salvo nos favoritos');
          },
          child: ValueListenableBuilder(
            valueListenable: storedDates,
            builder:
                (context, value, child) => 
                  Icon(value.contains(model.date.toYearMonthDayString()) ? Icons.favorite : Icons.favorite_border, size: 35, color: AppColors.primaryColor,),
          ),
        ),
      );
}
