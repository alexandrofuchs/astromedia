part of '../youtube_player_widget.dart';

mixin YoutubePlayerBuilders on YoutubePlayerOverlays {
  Widget videoEndedBuild(String videoId, Function resetPlayer) =>
      AnimatedCrossFade(
        layoutBuilder: _animatedLayoutWidgetsDisposition,
        duration: const Duration(milliseconds: 100),
        reverseDuration: const Duration(milliseconds: 100),
        excludeBottomFocus: true,
        firstChild: _videoEndedCover(videoId, resetPlayer),
        secondChild: const SizedBox(),
        alignment: Alignment.center,
        crossFadeState:
            videoEnded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      );

  Widget initialBuild() => Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
      );

  Widget mainOverlayBuild(BuildContext context, Function setState) =>
      AnimatedCrossFade(
        layoutBuilder: _animatedLayoutWidgetsDisposition,
        duration: const Duration(milliseconds: 100),
        reverseDuration: const Duration(milliseconds: 100),
        excludeBottomFocus: true,
        firstChild: _initialPlayAction(setState),
        firstCurve: Curves.bounceIn,
        secondChild: _loadPlayerBuild(context, setState),
        sizeCurve: Curves.bounceIn,
        alignment: Alignment.center,
        crossFadeState: firstLoading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      );
}
