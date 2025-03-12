import 'package:astromedia/core/helpers/extensions/datetime_extension.dart';
import 'package:astromedia/core/themes/app_colors.dart';
import 'package:astromedia/core/widgets/bottom_navigator/bottom_navigator_scaffold.dart';
import 'package:astromedia/core/widgets/set_theme/set_theme_widget.dart';
import 'package:astromedia/modules/home/presenter/widgets/favorites_widget.dart';
import 'package:astromedia/modules/home/domain/models/astronomical_media_model.dart';
import 'package:astromedia/modules/home/presenter/bloc/astronomical_media_bloc.dart';
import 'package:astromedia/modules/home/presenter/widgets/media_widgets.dart';
import 'package:astromedia/modules/home/presenter/widgets/screen_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final AstronomicalMediaBloc bloc;
  final Future<SharedPreferences> sharedPreferences;
  const HomePage({super.key, required this.bloc, required this.sharedPreferences});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with FavoritesWidget, SetThemeWidget, ScreenMode, MediaWidgets {

  @override
  void initState() {
    bloc = widget.bloc;
    sharedPreferences = widget.sharedPreferences;

    getFavorites();

    bloc.add(GetMediaEvent(DateTime.now()));

    selectedDate.addListener(onSelectDate);

    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    selectedDate.removeListener(onSelectDate);
    selectedDate.dispose();
    storedDates.dispose();
    super.dispose();
  }

  void onSelectDate() {
    if (selectedDate.value == null) return;
    bloc.add(GetMediaEvent(selectedDate.value!));
  }

  final selectedDate = ValueNotifier<DateTime?>(DateTime.now());

  Future<void> selectDate() async {
    final now = DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1995, 06, 16),
      lastDate: now,
    );
    if (pickedDate == null) return;
    selectedDate.value = pickedDate;
  }

  Widget dateActions() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          if (selectedDate.value == null) return;
          selectedDate.value = selectedDate.value!.subtract(Duration(days: 1));
        },
      ),

      ValueListenableBuilder(
        valueListenable: selectedDate,
        builder:
            (context, value, child) => TextButton(
              onPressed: selectDate,
              style: ButtonStyle(
                textStyle: WidgetStatePropertyAll(
                  TextStyle(color: AppColors.secundaryColor),
                ),
              ),
              child: Text(value.toDayMonthYearString()),
            ),
      ),
      IconButton(
        icon: Icon(Icons.arrow_forward_ios),
        onPressed: () {
          if (selectedDate.value.isFutureDate()) return;
          selectedDate.value = selectedDate.value!.add(Duration(days: 1));
        },
      ),
    ],
  );
  Widget loaded(AstronomicalMediaModel model) =>
      fullscreen
          ? mediaWidget(
            model,
            onToggleFullscreen: () => setState(toggleFullscreen),
            onRestartPlayer: () {
              if (selectedDate.value == null) return;
              bloc.add(GetMediaEvent(selectedDate.value!));
            },
          )
          : ListView(
            children: [
              mediaWidget(
                model,
                onToggleFullscreen: () => setState(toggleFullscreen),
                onRestartPlayer: () {
                  if (selectedDate.value == null) return;
                  bloc.add(GetMediaEvent(selectedDate.value!));
                },
              ),
              infosWidget(context, model),
            ],
          );

  Widget failed(String error ) => Center(key: Key('failedWidget'), child: Text(error));

  Widget loading() => Center(child: CircularProgressIndicator());

  @override
  Widget build(BuildContext context) {
    return BottomNavigatorScaffold(
      fullscreenMode: fullscreen,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('Mídia Astronômica do Dia'), setThemeModeAction()],
        ),
      ),
      body: Column(
        children: [
          fullscreen ? SizedBox() : dateActions(),
          Expanded(
            child:
                BlocBuilder<AstronomicalMediaBloc, AstronomicalMediaBlocState>(
                  bloc: bloc,
                  builder: (context, state) => switch (state.status) {
                        AstronomicalMediaBlocStatus.initial => SizedBox(),
                        AstronomicalMediaBlocStatus.loading => loading(),
                        AstronomicalMediaBlocStatus.loaded => loaded(state.data!),
                        AstronomicalMediaBlocStatus.failed => failed(state.error!.publicMessage ?? 'Falha ao carregar a mídia'),
                      },
                ),
          ),
        ],
      ),
    );
  }
}
