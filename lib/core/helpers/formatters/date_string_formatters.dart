import 'package:flutter/material.dart';

extension DateStringFormatters on String {
  DateTime? fromYMDDateString([String separator = '/']) {
    try {
      final parts = split(separator);
      if (parts.length != 3) throw '';
      return DateTime(
        int.parse(parts[0]),
        int.parse(parts[1]),
        int.parse(parts[2]),
      );
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  DateTime? fromDMYDateString([String separator = '/']) {
    try {
      final parts = split(separator);
      if (parts.length != 3) throw '';
      return DateTime(
        int.parse(parts[2]),
        int.parse(parts[1]),
        int.parse(parts[0]),
      );
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
