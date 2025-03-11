import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AstronomicalVideoWidget extends StatelessWidget{
  final String uri;

  const AstronomicalVideoWidget({super.key, required this.uri});
  
  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(controller: YoutubePlayerController(initialVideoId: YoutubePlayer.convertUrlToId(uri) ?? ''));
  }

}