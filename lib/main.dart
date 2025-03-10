import 'package:astroimg/root/app_entry.dart';
import 'package:astroimg/root/app_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() async {
  await Future.wait([]);

  return runApp(ModularApp(module: AppModule(), child: AppEntry()));
}
