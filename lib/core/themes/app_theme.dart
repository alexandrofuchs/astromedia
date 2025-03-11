import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData theme() =>
    ThemeData.light().copyWith();

  static ThemeData darkTheme() =>
    ThemeData.dark().copyWith();
}
