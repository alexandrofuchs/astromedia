part of '../youtube_player_widget.dart';

mixin YoutubePlayerOverlays on YoutubePlayerBaseWidgets {
  Widget _loadingOverlay() => Container(
        color: Colors.black,
        child: const Center(
            child: CircularProgressIndicator(
          color: Colors.white,
        )),
      );

  Widget _instantBarBuild(Function setState) => Container(
        color: Colors.transparent,
        child: Column(
          children: [
            _topOverlay(),
            const Expanded(child: SizedBox()),
            _bottomOverlay(setState)
          ],
        ),
      );

  Widget _visibleActionsOverlay(BuildContext context, Function setState) =>
      Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _topOverlay(),
            _midOverlay(setState),
            _bottomOverlay(setState),
          ],
        ),
      );

  Widget _invisibleOverlay(Function setState) => Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              setState(() {
                showInteractiveBuild = true;
              });

              timer?.cancel();

              timer = Timer(
                const Duration(milliseconds: 3000),
                () {
                  setState(() {
                    showInteractiveBuild = false;
                  });
                },
              );
            },
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
            ),
          ),
          Center(
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    isPlaying = false;
                    showInteractiveBuild = true;
                  });

                  timer?.cancel();

                  timer = Timer(
                    const Duration(milliseconds: 500),
                    () {
                      _controller.pause();
                    },
                  );
                },
                child: Container(
                  height: 100,
                  width: 100,
                  color: Colors.transparent,
                )),
          ),
        ],
      );

  Widget _interactableBuild(BuildContext context, Function setState) =>
      AnimatedCrossFade(
        layoutBuilder: _animatedLayoutWidgetsDisposition,
        duration: const Duration(milliseconds: 500),
        reverseDuration: const Duration(milliseconds: 500),
        excludeBottomFocus: true,
        firstChild: _visibleActionsOverlay(context, setState),
        firstCurve: Curves.bounceInOut,
        secondChild: _invisibleOverlay(setState),
        sizeCurve: Curves.linearToEaseOut,
        alignment: Alignment.center,
        crossFadeState: showInteractiveBuild
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
      );

  Widget _loadedOverlay(BuildContext context, setState) => AnimatedCrossFade(
        layoutBuilder: _animatedLayoutWidgetsDisposition,
        duration: const Duration(milliseconds: 100),
        reverseDuration: const Duration(milliseconds: 100),
        excludeBottomFocus: true,
        firstChild: _instantBarBuild(setState),
        firstCurve: Curves.bounceInOut,
        secondChild: _interactableBuild(context, setState),
        sizeCurve: Curves.linearToEaseOut,
        alignment: Alignment.center,
        crossFadeState: showBottomBar
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
      );

  Widget _loadPlayerBuild(BuildContext context, setState) => AnimatedCrossFade(
        layoutBuilder: _animatedLayoutWidgetsDisposition,
        duration: const Duration(milliseconds: 100),
        reverseDuration: const Duration(milliseconds: 100),
        excludeBottomFocus: true,
        firstChild: _loadingOverlay(),
        firstCurve: Curves.bounceInOut,
        secondChild: _loadedOverlay(context, setState),
        sizeCurve: Curves.linearToEaseOut,
        alignment: Alignment.center,
        crossFadeState: !videoStarted
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
      );

  Widget _videoEndedCover(String videoId, Function resetPlayer) => Container(
        color: Colors.black,
        child: IconButton(
            onPressed: () {
              resetPlayer();
            },
            icon: const Icon(
              Icons.refresh,
              size: 60,
              color: Colors.white,
            )),
      );
}
