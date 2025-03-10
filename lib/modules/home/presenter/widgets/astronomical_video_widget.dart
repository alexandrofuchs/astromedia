import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AstronomicalVideoWidget extends StatelessWidget{
  final String uri;

  const AstronomicalVideoWidget({super.key, required this.uri});
  
  @override
  Widget build(BuildContext context) {
    return VideoPlayer(VideoPlayerController.networkUrl(Uri.https(uri)));
  }

}