import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData theme([bool isDark = false]) =>
      isDark ? ThemeData.light().copyWith() : ThemeData.dark().copyWith();
}
