part of '../youtube_player_widget.dart';

mixin YoutubePlayerBaseWidgets on YoutubePlayerPopMenus {
  late String videoTitle;

  late final YoutubePlayerController _controller;

  bool fullscreen = false;

  bool showInteractiveBuild = false;

  bool showBottomBar = true;

  bool videoStarted = false;

  bool firstLoading = true;

  bool videoEnded = false;

  bool isPlaying = false;

  Timer? timer;

  double get defaultAspectRatio => 1.51;

  bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;

  double getAspectRatio(BuildContext context) {
    if (fullscreen || isLandscape(context)) {

      if(!_controller.value.isFullScreen){
        _controller.toggleFullScreenMode();
      }
      

      return MediaQuery.of(context).size.width /
          (MediaQuery.of(context).size.height);
    }

    if(_controller.value.isFullScreen){
        _controller.toggleFullScreenMode();
      }
    return defaultAspectRatio;
  }

  void showBottomBarForSeconds(Function setState, int seconds) {
    timer?.cancel();

    setState(() {
      showBottomBar = true;
    });

    timer = Timer(Duration(seconds: seconds), () {
      setState(() {
        showBottomBar = false;
      });
    });
  }

  Widget _animatedLayoutWidgetsDisposition(
      topChild, topChildKey, bottomChild, bottomChildKey) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          key: bottomChildKey,
          child: bottomChild,
        ),
        Positioned(
          key: topChildKey,
          child: topChild,
        ),
      ],
    );
  }

  Widget _playPauseAction(Function setState) => IconButton(
        icon: Icon(
          isPlaying ? Icons.pause : Icons.play_arrow,
          color: AppColors.primaryColor,
          size: 70,
        ),
        onPressed: () {
          timer?.cancel();

          if (isPlaying) {
            _controller.pause();
          } else {
            _controller.play();

            timer = Timer(
              const Duration(milliseconds: 500),
              () {
                setState(() {
                  showInteractiveBuild = false;
                });
              },
            );
          }

          setState(() {
            isPlaying = !isPlaying;
          });
        },
      );

  Widget _rewindAction(Function setState) => IconButton(
      onPressed: () {
        if (_controller.value.position.inSeconds - 10 < 0) {
          _controller.seekTo(const Duration(seconds: 0));
        } else {
          _controller.seekTo(
              Duration(seconds: _controller.value.position.inSeconds - 10));
        }

        if (!isPlaying) {
          setState(() {
            _controller.pause();
          });
        }
      },
      icon: const Icon(
        Icons.replay_10,
        color: AppColors.primaryColor,
        size: 45,
      ));

  Widget _forwardAction(Function setState) => IconButton(
        onPressed: () {
          
          if (_controller.value.position.inSeconds + 10 > _controller.metadata.duration.inSeconds) {
            _controller.seekTo(Duration(seconds: _controller.metadata.duration.inSeconds));
          } else {
            _controller.seekTo(Duration(seconds: _controller.value.position.inSeconds + 10));
          }

          if (!isPlaying) {
            setState(() {
              _controller.pause();
            });

          }
          
        },
        icon: const Icon(
          Icons.forward_10,
          color: AppColors.primaryColor,
          size: 45,
        ),
      );

  Widget _topOverlay([Color backgroundColor = Colors.black]) =>
      StatefulBuilder(builder: (context, setState) {
        void setSpeed(MediaSpeedOption option) {
          setState(() {
            _controller.setPlaybackRate(option.value);
            videoSpeed = option;
          });
        }

        void setVolume(int volume) {
          videoVolume.value = volume;
          _controller.setVolume(volume);
        }

        return Container(
          color: backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  videoTitle,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  style: AppTextStyles.blackLarge,
                ),
              ),
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 8, right: 15),
                      child: MenuAnchor(
                          builder: (context, controller, child) {
                            return IconButton(
                              onPressed: () {
                                if (controller.isOpen) {
                                  controller.close();
                                } else {
                                  controller.open();
                                }
                              },
                              icon: const Icon(
                                Icons.settings,
                                color: AppColors.primaryColor,
                                size: 24,
                              ),
                              tooltip: 'Mostrar menu',
                            );
                          },
                          menuChildren: [
                            MenuItemButton(
                              style: ButtonStyle(textStyle: WidgetStatePropertyAll(AppTextStyles.primarySmall)),
                              child: speedMenuButton(context, setSpeed),
                            ),
                            MenuItemButton(
                              style: ButtonStyle(textStyle: WidgetStatePropertyAll(AppTextStyles.primarySmall)),
                              child: volumeMenuButton(context, setVolume),
                            ),
                          ])),
                ],
              ),
            ],
          ),
        );
      });

  Widget _midOverlay(Function setState) => Container(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _rewindAction(setState),
            _playPauseAction(setState),
            _forwardAction(setState),
          ],
        ),
      );

  Widget _bottomOverlay(Function setState, [Color backgroundColor = Colors.black]) =>
      Container(
        color: backgroundColor,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ValueListenableBuilder(
                      valueListenable: _controller,
                      builder: (context, value, _) {
                        return Text(
                          Formatters.formatTime(value.position),
                          style:
                              const TextStyle(color: AppColors.primaryColor),
                        );
                      },
                    )),
                Flexible(
                  child: ProgressBar(
                    controller: _controller,
                    isExpanded: false,
                    colors: const ProgressBarColors(
                        handleColor: Colors.white,
                        backgroundColor: AppColors.secundaryColor,
                        bufferedColor: AppColors.secundaryColor,
                        playedColor: AppColors.primaryColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    Formatters.formatTime(_controller.value.metaData.duration),
                    style: const TextStyle(color: AppColors.secundaryColor),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 30))
              ],
            ),
          ],
        ),
      );

  Widget _initialPlayAction(Function setState) => Container(
      color: Colors.black,
      child: IconButton(
        icon: const Icon(
          Icons.play_arrow,
          color: AppColors.primaryColor,
          size: 70,
        ),
        onPressed: () {
          _controller.play();

          setState(() {
            isPlaying = true;
          });

          timer?.cancel();

          timer = Timer(
            const Duration(milliseconds: 1000),
            () {
              setState(() {
                firstLoading = false;
              });
            },
          );
        },
      ));
}
