import 'package:astromedia/core/helpers/extensions/datetime_extension.dart';
import 'package:astromedia/core/helpers/formatters/date_string_formatters.dart';
import 'package:astromedia/core/themes/app_fonts.dart';
import 'package:astromedia/core/widgets/bottom_navigator/bottom_navigator_scaffold.dart';
import 'package:astromedia/core/widgets/set_theme/set_theme_widget.dart';
import 'package:astromedia/modules/home/presenter/widgets/favorites_widget.dart';
import 'package:astromedia/modules/home/domain/models/astronomical_media_model.dart';
import 'package:astromedia/modules/home/presenter/bloc/astronomical_media_bloc.dart';
import 'package:astromedia/modules/home/presenter/widgets/media_widgets.dart';
import 'package:astromedia/modules/home/presenter/widgets/screen_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesPage extends StatefulWidget {
  final AstronomicalMediaBloc bloc;
  final Future<SharedPreferences> sharedPreferences;

  const FavoritesPage({
    super.key,
    required this.bloc,
    required this.sharedPreferences,
  });

  @override
  State<StatefulWidget> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage>
    with FavoritesWidget, SetThemeWidget, ScreenMode, MediaWidgets {
  final ValueNotifier<int> selectedFavoriteIndex = ValueNotifier(0);

  bool left = false;

  @override
  void initState() {
    bloc = widget.bloc;
    sharedPreferences = widget.sharedPreferences;

    selectedFavoriteIndex.addListener(onChangeIndex);
    storedDates.addListener(onLoadedFavorites);
    selectedFavoriteIndex.value = 0;
    getFavorites();
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    selectedFavoriteIndex.removeListener(onChangeIndex);
    selectedFavoriteIndex.dispose();
    storedDates.removeListener(onLoadedFavorites);
    storedDates.dispose();
    super.dispose();
  }

  void onLoadedFavorites() {
    if (storedDates.value.isEmpty) {
      bloc.add(ResetEvent());
      return;
    }
    selectedFavoriteIndex.value = 0;
    onChangeIndex();
  }

  void onChangeIndex() {
    final date =
        storedDates.value[selectedFavoriteIndex.value].fromYMDDateString();
    if (date == null) return;
    bloc.add(GetMediaEvent(date));
  }

  Widget loaded(AstronomicalMediaModel model) => GestureDetector(
    onHorizontalDragEnd: (details) {
      if (details.velocity.pixelsPerSecond.dx > 0.0) {
        if (selectedFavoriteIndex.value >= storedDates.value.length - 1) return;
        selectedFavoriteIndex.value = selectedFavoriteIndex.value + 1;
        left = true;
      } else if (details.velocity.pixelsPerSecond.dx < 0.0) {
        if (selectedFavoriteIndex.value <= 0) return;
        selectedFavoriteIndex.value = selectedFavoriteIndex.value - 1;
        left = false;
      }
    },

    child:
        fullscreen
            ? mediaWidget(
              model,
              onToggleFullscreen: () => setState(toggleFullscreen),
              onRestartPlayer: onChangeIndex,
            )
            : ListView(
              children: [
                mediaWidget(
                  model,
                  onToggleFullscreen: () => setState(toggleFullscreen),
                  onRestartPlayer: onChangeIndex,
                ),
                infosWidget(context, model),
              ],
            ),
  );

  Widget failed(String error) => Center(child: Text(error));

  Widget loading() => Center(child: CircularProgressIndicator());

  Widget navigationActions() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          if (selectedFavoriteIndex.value <= 0) return;
          selectedFavoriteIndex.value = selectedFavoriteIndex.value - 1;
          left = true;
        },
      ),
      ValueListenableBuilder(
        valueListenable: storedDates,
        builder:
            (context, value, child) =>
                value.isEmpty
                    ? SizedBox()
                    : ValueListenableBuilder(
                      valueListenable: selectedFavoriteIndex,
                      builder:
                          (context, value, child) => Text(
                            storedDates.value[selectedFavoriteIndex.value]
                                .fromYMDDateString()
                                .toDayMonthYearString(),
                            style: AppTextStyles.primaryMedium,
                          ),
                    ),
      ),
      IconButton(
        icon: Icon(Icons.arrow_forward_ios),
        onPressed: () {
          if (selectedFavoriteIndex.value >= storedDates.value.length - 1) return;
          selectedFavoriteIndex.value = selectedFavoriteIndex.value + 1;
          left = false;
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return BottomNavigatorScaffold(
      fullscreenMode: fullscreen,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('Favoritos'), setThemeModeAction()],
        ),
      ),
      body: Column(
        children: [
          fullscreen ? SizedBox() : navigationActions(),
          Expanded(
            child: BlocBuilder<
              AstronomicalMediaBloc,
              AstronomicalMediaBlocState
            >(
              bloc: bloc,
              builder:
                  (context, state) => 
                  SizedBox(child: switch (state.status) {
                    AstronomicalMediaBlocStatus.initial => Center(
                      child: Text('Sem favoritos'),
                    ),
                     AstronomicalMediaBlocStatus.loading => loading().animate(),
                    AstronomicalMediaBlocStatus.loaded => loaded(state.data!).animate().slideX(begin: left ? -1 : 1, end: 0, delay: Duration(milliseconds: 300)),
                    AstronomicalMediaBlocStatus.failed => failed(
                      state.error!.publicMessage ?? 'Falha ao carregar a mídia',
                    ),
                  },
            ))
          ),
        ],
      ),
    );
  }
}
