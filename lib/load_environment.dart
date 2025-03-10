import 'dart:convert';
import 'package:astromedia/core/external/api/api_request_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum AppEnvironment { dev, hml, prod, test }

Future<void> loadAppEnvironment(AppEnvironment env) async => switch (env) {
  AppEnvironment.dev => await _loadInDev(),
  AppEnvironment.test => await _loadInTest(),
  AppEnvironment.hml => () {},
  AppEnvironment.prod => () {},
};

Future<void> _loadInDev() async {
  try {
    final credentials = jsonDecode(
      await rootBundle.loadString('.env/api_credentials.json'),
    );

    baseUrl = credentials['base_url'];
    apiKey = credentials['api_key'];
  } catch (e) {
    baseUrl = '';
    apiKey = '';
    debugPrint(e.toString());
  }
}

Future<void> _loadInTest() async {
  try {
    baseUrl = 'https://api.example.com/';
    apiKey = 'apikeyexample';
  } catch (e) {
    baseUrl = '';
    apiKey = '';
    debugPrint(e.toString());
  }
}

