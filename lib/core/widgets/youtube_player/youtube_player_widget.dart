import 'dart:async';
import 'package:astromedia/core/helpers/formatters/string_formatters.dart';
import 'package:astromedia/core/themes/app_colors.dart';
import 'package:astromedia/core/themes/app_fonts.dart';
import 'package:astromedia/core/widgets/snackbars/app_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

part 'widgets/youtube_player_pop_menus_part.dart';
part 'widgets/youtube_player_base_widgets_part.dart';
part 'widgets/youtube_player_overlays_part.dart';
part 'widgets/youtube_player_builders_part.dart';

class YoutubeMediaPlayerWidget extends StatefulWidget {
  final String mediaLink;
  final String label;
  final String title;
  final bool fullscreen;
  final Function? onRestartPlayer;

  const YoutubeMediaPlayerWidget(
      {super.key,
      required this.mediaLink,
      required this.title,
      required this.label,
      required this.fullscreen,
      required this.onRestartPlayer,
      });

  @override
  State<StatefulWidget> createState() => _YoutubeMediaPlayerState();
}

class _YoutubeMediaPlayerState extends State<YoutubeMediaPlayerWidget>
    with
        TickerProviderStateMixin,
        YoutubePlayerPopMenus,
        YoutubePlayerBaseWidgets,
        YoutubePlayerOverlays,
        YoutubePlayerBuilders {

  bool mediaError = true;

  bool showErrorMessage = false;

  bool isReady = false;

  bool startedDragging = false;

  @override
  void initState() {
    super.initState();

    fullscreen = widget.fullscreen;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    initVideoPlayer();
  }

  @override
  void dispose() {

    SystemChrome.restoreSystemUIOverlays();

    timer?.cancel();

    _controller
      ..removeListener(onMediaError)
      ..removeListener(onDragging)
      ..removeListener(onFirstTimePlayed)
      ..removeListener(onEndTimePlayed)
      ..removeListener(onEndState)
      ..dispose();

    super.dispose();
  }

  Future<void> initVideoPlayer() async {
    
    videoTitle = widget.label;

    final mediaId = YoutubePlayer.convertUrlToId(widget.mediaLink);

    if (mediaId == null) {
      _controller = YoutubePlayerController(initialVideoId: 'invalid');

      setState(() {
        showErrorMessage = true;
      });

      return;
    }

    _controller = YoutubePlayerController(
      initialVideoId: mediaId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        enableCaption: false,
        hideThumbnail: true,
        controlsVisibleAtStart: false,
        useHybridComposition: true,
        disableDragSeek: true,
        showLiveFullscreenButton: false,
        isLive: false,
        loop: false,
        mute: false,
        hideControls: true,
      ),
    );

    setState(() {
      mediaError = false;
    });
  }

  void onDragging() {
    if (startedDragging && !_controller.value.isDragging) {
      startedDragging = false;

      timer?.cancel();

      timer = Timer(const Duration(milliseconds: 3000), () {
        setState(() {
          showInteractiveBuild = false;
        });
      });

      return;
    }

    if (!startedDragging && _controller.value.isDragging) {
      startedDragging = true;

      setState(() {
        timer?.cancel();
        isPlaying = true;
        showBottomBar = false;
        showInteractiveBuild = true;
      });

      return;
    }
  }

  void onMediaError() {
    if (_controller.value.hasError) {
      debugPrint(
          'YoutubeMediaPlayerWidget -> error code : ${_controller.value.errorCode}');
      AppSnackbars.showErrorSnackbar(
          context, "Não foi possível carregar mídia selecionada");
    }

    _controller.removeListener(onMediaError);
  }

  void onFirstTimePlayed() {
    if (_controller.value.position.inMilliseconds > 500) {
      _controller.removeListener(onFirstTimePlayed);

      setState(() {
        videoStarted = true;
      });

      showBottomBarForSeconds(setState, 3);
    }
  }

  void onEndTimePlayed() {
    if (!(_controller.metadata.duration.inMilliseconds > 0.0)) return;

    if (_controller.metadata.duration.inMilliseconds -
            _controller.value.position.inMilliseconds <
        700) {
      _controller.removeListener(onEndTimePlayed);

      setState(() {
        videoEnded = true;
      });
    }
  }

  void onEndState() {
    if (_controller.value.playerState == PlayerState.ended) {
      _controller.removeListener(onEndState);

      setState(() {
        videoEnded = true;
      });
    }
  }

  Widget youtubePlayer() => YoutubePlayer(
        controller: _controller,
        aspectRatio: defaultAspectRatio,
        onReady: () {
          _controller
            ..addListener(onMediaError)
            ..addListener(onFirstTimePlayed)
            ..addListener(onEndTimePlayed)
            ..addListener(onEndState)
            ..addListener(onDragging);

          setState(() {
            isReady = true;
          });
        },
        controlsTimeOut: const Duration(milliseconds: 0),
      );

  @override
  Widget build(BuildContext context) {
    return 
            Center(
                child: !mediaError ?  AspectRatio(
                        aspectRatio: getAspectRatio(context),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            youtubePlayer(),
                            !isReady
                                ? initialBuild()
                                : mainOverlayBuild(context, setState),
                            videoEndedBuild(widget.mediaLink.split('/').last, widget.onRestartPlayer ?? (){}),
                          ],
                        ))
                    : AspectRatio(
                        aspectRatio: getAspectRatio(context), child:  showErrorMessage ?
                        Text('Não foi possível carregar o arquivo de midia!') : const SizedBox())
                    );

  }
}
