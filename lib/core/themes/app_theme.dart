import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData theme({bool isDarkMode = false}) =>
      isDarkMode ? ThemeData.dark().copyWith() : ThemeData.light().copyWith() ;
}
