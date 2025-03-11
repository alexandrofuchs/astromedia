import 'package:astromedia/core/themes/app_colors.dart';
import 'package:astromedia/core/themes/app_fonts.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {


  static ThemeData theme() =>
    ThemeData.light().copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightPrimaryColor,
      ),
      primaryColor: AppColors.primaryColor,
       scaffoldBackgroundColor: AppColors.lightSecundaryColor,
       colorScheme: ColorScheme.dark().copyWith(
        secondary: AppColors.lightSecundaryColor,
        primary: AppColors.primaryColor,
       ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          iconColor: WidgetStatePropertyAll(AppColors.primaryColor),
        )
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: AppColors.darkSecundaryColor,
      ),
      dividerColor: AppColors.primaryColor,
      dividerTheme: DividerThemeData(
        color: AppColors.primaryColor,
        thickness: 1,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightSecundaryColor,
        selectedItemColor: AppColors.primaryColor,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.lightPrimaryColor,
        indicatorColor: AppColors.primaryColor,
        labelTextStyle: WidgetStatePropertyAll(AppTextStyles.whiteMedium),
      ),
      textTheme: TextTheme(
        bodyLarge: AppTextStyles.blackLarge,
        bodyMedium: AppTextStyles.blackMedium,
        bodySmall: AppTextStyles.blackSmall,
        titleLarge: AppTextStyles.titleLarge,
        titleMedium: AppTextStyles.titleMedium,
        titleSmall: AppTextStyles.titleSmall,
      ),
      menuButtonTheme: MenuButtonThemeData(style: ButtonStyle(textStyle: WidgetStatePropertyAll(AppTextStyles.blackSmall))),
      popupMenuTheme: PopupMenuThemeData(textStyle: AppTextStyles.blackSmall),
      dropdownMenuTheme: DropdownMenuThemeData(textStyle: AppTextStyles.blackSmall),
    );

  static ThemeData darkTheme() =>
    ThemeData.dark().copyWith(
       primaryColor: AppColors.primaryColor,
       scaffoldBackgroundColor: AppColors.darkSecundaryColor,
       colorScheme: ColorScheme.dark().copyWith(
        secondary: AppColors.darkSecundaryColor,
        primary: AppColors.primaryColor,
       ),
      dividerColor: AppColors.primaryColor,
      dividerTheme: DividerThemeData(
        color: AppColors.primaryColor,
        thickness: 1,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          iconColor: WidgetStatePropertyAll(AppColors.primaryColor),
        )
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: AppColors.darkSecundaryColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkPrimaryColor,
        selectedItemColor: AppColors.primaryColor,
      ),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: AppColors.primaryColor,
        labelTextStyle: WidgetStatePropertyAll(AppTextStyles.whiteSmall),
      ),
      textTheme: TextTheme(
        bodyLarge: AppTextStyles.whiteLarge,
        bodyMedium: AppTextStyles.whiteMedium,
        bodySmall: AppTextStyles.whiteSmall,
        titleLarge: AppTextStyles.titleLarge,
        titleMedium: AppTextStyles.titleMedium,
        titleSmall: AppTextStyles.titleSmall,
      ),
      menuButtonTheme: MenuButtonThemeData(style: ButtonStyle(textStyle: WidgetStatePropertyAll(AppTextStyles.whiteSmall))),
      popupMenuTheme: PopupMenuThemeData(textStyle: AppTextStyles.whiteSmall),
      dropdownMenuTheme: DropdownMenuThemeData(textStyle: AppTextStyles.whiteSmall),

    );
}
