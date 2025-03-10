import 'package:flutter/material.dart';

class AstronomicalImageWidget extends StatelessWidget{
  final String uri;

  const AstronomicalImageWidget({super.key, required this.uri});
  
  @override
  Widget build(BuildContext context) {
    return Image.network(uri);
  }

}