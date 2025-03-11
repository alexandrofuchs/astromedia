import 'package:astromedia/core/helpers/extensions/datetime_extension.dart';
import 'package:astromedia/core/helpers/formatters/date_string_formatters.dart';
import 'package:astromedia/core/themes/app_colors.dart';
import 'package:astromedia/core/themes/app_fonts.dart';
import 'package:astromedia/core/widgets/bottom_navigator/bottom_navigator_scaffold.dart';
import 'package:astromedia/core/widgets/set_theme/set_theme_widget.dart';
import 'package:astromedia/modules/home/presenter/widgets/favorites_widget.dart';
import 'package:astromedia/modules/home/domain/models/astronomical_media_model.dart';
import 'package:astromedia/modules/home/presenter/bloc/astronomical_media_bloc.dart';
import 'package:astromedia/modules/home/presenter/widgets/media_widgets.dart';
import 'package:astromedia/modules/home/presenter/widgets/screen_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<StatefulWidget> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage>
    with FavoritesWidget, SetThemeWidget, ScreenMode, MediaWidgets{
  final bloc = AstronomicalMediaBloc(Modular.get());

  final ValueNotifier<int> selectedFavoriteIndex = ValueNotifier(0);

  @override
  void initState() {
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
    if (storedDates.value.isEmpty) return;
    selectedFavoriteIndex.value = 0;
    onChangeIndex();
  }

  void onChangeIndex() {
    final date = storedDates.value[selectedFavoriteIndex.value].fromYMDDateString();
    if (date == null) return;
    bloc.add(GetMediaEvent(date));
  }

  Widget mediaWidget(AstronomicalMediaModel model) => Stack(
    alignment: Alignment.bottomCenter,
    children: [
      mediaBuilder(model.mediaType, model.url, fullscreen),
      Container(
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomRight,
        child: GestureDetector(
          onTap: () {
            setState(toggleFullscreen);
          },
          child: Container(
            height: 24,
            width: 24,
            alignment: Alignment.center,
            child: const Icon(
              Icons.fullscreen,
              color: AppColors.primaryColor,
              size: 24,
            ),
          ),
        ),
      ),
    ],
  );

  Widget loaded(AstronomicalMediaModel model) =>
      isLandscape(context) || fullscreen
          ? mediaWidget(model)
          : ListView(
            children: [mediaWidget(model), infosWidget(context, model)],
          );

  Widget failed() => Center(child: Text('failed'));

  Widget loading() => Center(child: CircularProgressIndicator());

  Widget navigationActions() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          if (selectedFavoriteIndex.value <= 0) return;
          selectedFavoriteIndex.value = selectedFavoriteIndex.value - 1;
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
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return BottomNavigatorScaffold(
      fullscreenMode: isLandscape(context) || fullscreen,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('Favoritos'), setThemeModeAction()],
        ),
      ),
      body: Column(
        children: [
          isLandscape(context) || fullscreen ?  SizedBox() : navigationActions(),
          Expanded(
            child:
                BlocBuilder<AstronomicalMediaBloc, AstronomicalMediaBlocState>(
                  bloc: bloc,
                  builder:
                      (context, state) => switch (state.status) {
                        AstronomicalMediaBlocStatus.initial => Center(child: Text('Sem favoritos'),),
                        AstronomicalMediaBlocStatus.loading => loading(),
                        AstronomicalMediaBlocStatus.loaded => loaded(state.data!),
                        AstronomicalMediaBlocStatus.failed => failed(),
                      },
                ),
          ),
        ],
      ),
    );
  }
}
