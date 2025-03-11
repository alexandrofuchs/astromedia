import 'package:astromedia/core/helpers/extensions/datetime_extension.dart';
import 'package:astromedia/core/themes/app_fonts.dart';
import 'package:astromedia/core/widgets/youtube_player/youtube_player_widget.dart';
import 'package:astromedia/modules/home/domain/enums/media_type.dart';
import 'package:astromedia/modules/home/domain/models/astronomical_media_model.dart';
import 'package:astromedia/modules/home/presenter/widgets/astronomical_image_widget.dart';
import 'package:astromedia/modules/home/presenter/widgets/favorites_widget.dart';
import 'package:astromedia/modules/home/presenter/widgets/screen_mode.dart';
import 'package:flutter/material.dart';

mixin MediaWidgets on FavoritesWidget, ScreenMode {
  Widget mediaBuilder(MediaType media, String uri, bool fullscreen, Function onRestart) =>
      switch (media) {
        MediaType.image => AstronomicalImageWidget(uri: uri),
        MediaType.video => YoutubeMediaPlayerWidget(
          mediaLink: uri,
          fullscreen: fullscreen,
          label: '',
          title: '',
          onRestart: onRestart,
        ),
        MediaType.none => SizedBox(),
      };

  Widget infosWidget(BuildContext context, AstronomicalMediaModel model) =>
      Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(model.title, style: AppTextStyles.primaryLarge),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: favoriteAction(context, model),
                ),
              ],
            ),
            Text(model.date.toDayMonthYearString()),
            Divider(height: 25),
            SizedBox(height: 15),
            Text(model.explanation, textAlign: TextAlign.justify),
          ],
        ),
      );
}
