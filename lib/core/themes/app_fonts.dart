import 'package:astromedia/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppTextStyles {
  static const TextStyle titleSmall = TextStyle(
      fontSize: 12, color: AppColors.primaryColorDark, fontWeight: FontWeight.w500);
  static const TextStyle titleMedium = TextStyle(
      fontSize: 14, color: AppColors.primaryColorDark, fontWeight: FontWeight.w500);
  static const TextStyle titleLarge = TextStyle(
      fontSize: 16, color: AppColors.primaryColorDark, fontWeight: FontWeight.w500);

  static const TextStyle bodySmall =
      TextStyle(fontSize: 10, color: Colors.black);
  static const TextStyle bodyMedium =
      TextStyle(fontSize: 12, color: Colors.black);
  static const TextStyle bodyLarge =
      TextStyle(fontSize: 14, color: Colors.black);

  static const TextStyle labelSmall = TextStyle(
            fontSize: 12,
      color: Colors.white,
      fontWeight: FontWeight.w400);
  static const TextStyle labelMedium = TextStyle(
            fontSize: 14,
      color: Colors.white,
      fontWeight: FontWeight.w400);
  static const TextStyle labelLarge = TextStyle(
            fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.w400);
}
