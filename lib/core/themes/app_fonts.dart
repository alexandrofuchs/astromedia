import 'package:astromedia/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppTextStyles {
  static const TextStyle titleSmall = TextStyle(fontSize: 14, color: AppColors.darkPrimaryColor, fontWeight: FontWeight.w500);
  static const TextStyle titleMedium = TextStyle(fontSize: 16, color: AppColors.darkPrimaryColor, fontWeight: FontWeight.w500);
  static const TextStyle titleLarge = TextStyle(fontSize: 18, color: AppColors.darkPrimaryColor, fontWeight: FontWeight.w500);

  static const TextStyle blackSmall = TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w400);
  static const TextStyle blackMedium = TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400);
  static const TextStyle blackLarge = TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700);

  static const TextStyle whiteSmall = TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w400);
  static const TextStyle whiteMedium = TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400);
  static const TextStyle whiteLarge = TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700);

  static const TextStyle primarySmall = TextStyle(fontSize: 12, color: AppColors.primaryColor, fontWeight: FontWeight.w400);
  static const TextStyle primaryMedium = TextStyle(fontSize: 14, color: AppColors.primaryColor, fontWeight: FontWeight.w400);
  static const TextStyle primaryLarge = TextStyle(fontSize: 20, color: AppColors.primaryColor, fontWeight: FontWeight.w700);
}
