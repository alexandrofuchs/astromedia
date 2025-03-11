import 'package:astromedia/core/helpers/extensions/datetime_extension.dart';
import 'package:astromedia/core/themes/app_colors.dart';
import 'package:astromedia/core/widgets/bottom_navigator/bottom_navigator_scaffold.dart';
import 'package:astromedia/core/widgets/set_theme/set_theme_widget.dart';
import 'package:astromedia/core/widgets/snackbars/app_snackbars.dart';
import 'package:astromedia/modules/favorites/presenter/pages/favorites_mixin.dart';
import 'package:astromedia/modules/home/domain/enums/media_type.dart';
import 'package:astromedia/modules/home/domain/models/astronomical_media_model.dart';
import 'package:astromedia/modules/home/presenter/bloc/astronomical_media_bloc.dart';
import 'package:astromedia/modules/home/presenter/widgets/astronomical_image_widget.dart';
import 'package:astromedia/modules/home/presenter/widgets/astronomical_video_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with FavoritesMixin, SetThemeWidget {
  final bloc = AstronomicalMediaBloc(Modular.get());

  final selectedDate = ValueNotifier<DateTime?>(DateTime.now());

  @override
  void initState() {
    getFavorites();

    bloc.add(GetMediaEvent(DateTime.now()));

    selectedDate.addListener(onSelectDate);

    super.initState();
  }

  void onSelectDate() {
    if (selectedDate.value == null) return;
    bloc.add(GetMediaEvent(selectedDate.value!));
  }

  @override
  void dispose() {
    bloc.close();
    selectedDate.removeListener(onSelectDate);
    selectedDate.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2020),
      lastDate: now,
    );

    selectedDate.value = pickedDate;
  }

  Widget mediaWidget(MediaType media, String uri) => switch (media) {
    MediaType.image => AstronomicalImageWidget(uri: uri),
    MediaType.video => AstronomicalVideoWidget(uri: uri),
    MediaType.none => SizedBox(),
  };

  Widget dateActions() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          if(selectedDate.value == null) return;
          selectedDate.value = selectedDate.value!.subtract(Duration(days: 1));
        },
        ),

      ValueListenableBuilder(
        valueListenable: selectedDate,
        builder:
            (context, value, child) => TextButton(
              onPressed: _selectDate,
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
          if(selectedDate.value == null) return;
          selectedDate.value = selectedDate.value!.add(Duration(days: 1));
        }),
    ],
  );

  Widget favoriteAction(AstronomicalMediaModel model) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Text('Adicionar aos favoritos'),
      IconButton(
        onPressed: () async {
          await saveFavorite(model.date);
          if (!mounted) return;
          AppSnackbars.showSuccessSnackbar(context, 'salvo nos favoritos');
        },
        icon: ValueListenableBuilder(
          valueListenable: storedDates,
          builder:
              (context, value, child) =>
                  value.contains(model.date.toYearMonthDayString('-'))
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
        ),
      ),
    ],
  );

  Widget infosWidget(AstronomicalMediaModel model) => Padding(
    padding: const EdgeInsets.all(15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(model.title),
        Text(model.date.toDayMonthYearString()),
        SizedBox(height: 15),
        Text(model.explanation),
      ],
    ),
  );

  Widget loaded(AstronomicalMediaModel model) => ListView(
    children: [
      favoriteAction(model),
      mediaWidget(model.mediaType, model.url),
      infosWidget(model),
    ],
  );

  Widget failed() => Center(child: Text('failed'));

  Widget loading() => Center(child: CircularProgressIndicator());

  @override
  Widget build(BuildContext context) {
    return BottomNavigatorScaffold(
      appBar: AppBar(title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(''),
          setThemeModeAction(),
        ],
      )),
      body: Column(
        children: [
          dateActions(),
          Expanded(
            child: BlocBuilder<AstronomicalMediaBloc, AstronomicalMediaBlocState>(
              bloc: bloc,
              builder:
                  (context, state) => switch (state.status) {
                    AstronomicalMediaBlocStatus.initial => SizedBox(),
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
