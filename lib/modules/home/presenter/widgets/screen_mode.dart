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

  void toggleFullscreen() {
    if (!fullscreen) {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [],
      );

    } else {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values,
      );

    }
    fullscreen = !fullscreen;
  }
}