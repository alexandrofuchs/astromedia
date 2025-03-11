import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AstronomicalImageWidget extends StatelessWidget {
  final String uri;

  const AstronomicalImageWidget({super.key, required this.uri});

  Widget imageWidget(
    ImageProvider<Object> image, {
    double height = 250,
    double width = 250,
    BorderRadius borderRadius = BorderRadius.zero,
  }) => ClipRRect(
    borderRadius: borderRadius,
    child: Image(
      loadingBuilder: (
        BuildContext context,
        Widget child,
        ImageChunkEvent? loadingProgress,
      ) {
        if (loadingProgress == null) {
          return child;
        }

        return Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5),
          ),
          height: height,
          width: width,
        );
      },
      image: image,
      fit: BoxFit.cover,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      child: imageWidget(CachedNetworkImageProvider(uri)),
    );
  }
}
