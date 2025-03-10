import 'package:astromedia/load_environment.dart';
import 'package:astromedia/root/app_entry.dart';
import 'package:astromedia/root/app_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    loadAppEnvironment(AppEnvironment.dev),
  ]);

  return runApp(ModularApp(module: AppModule(), child: AppEntry()));
}
