import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

mixin ScreenMode {
  bool fullscreen = false;

  double get defaultAspectRatio => 1.51;

  bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;

  double getAspectRatio(BuildContext context) {
    if (fullscreen || isLandscape(context)) {

      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

      return MediaQuery.of(context).size.width /
          (MediaQuery.of(context).size.height);
    }

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);

    return defaultAspectRatio;
  }

  toggleFullscreen() {
    if (!fullscreen) {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [],
      );

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values,
      );

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
    fullscreen = !fullscreen;
  }
}