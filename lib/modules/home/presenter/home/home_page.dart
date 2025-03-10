import 'package:astromedia/core/helpers/extensions/datetime_extesion.dart';
import 'package:astromedia/core/themes/app_colors.dart';
import 'package:astromedia/core/widgets/bottom_navigator/bottom_navigator_scaffold.dart';
import 'package:astromedia/modules/home/domain/enums/media_type.dart';
import 'package:astromedia/modules/home/domain/models/astronomical_media_model.dart';
import 'package:astromedia/modules/home/presenter/home/bloc/astronomical_media_bloc.dart';
import 'package:astromedia/modules/home/presenter/home/widgets/astronomical_image_widget.dart';
import 'package:astromedia/modules/home/presenter/home/widgets/astronomical_video_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bloc = AstronomicalMediaBloc(Modular.get());

  final selectedDate = ValueNotifier<DateTime?>(DateTime.now());

  @override
  void initState() {
    bloc.add(GetMediaEvent(DateTime.now()));

    selectedDate.addListener(onSelectDate);

    super.initState();
  }

  void onSelectDate(){
    if(selectedDate.value == null) return;
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

  Widget loaded(AstronomicalMediaModel model) => ListView(
    children: [
      ValueListenableBuilder(valueListenable: selectedDate, builder:(context, value, child) => 
        TextButton(onPressed: _selectDate,
        style: ButtonStyle(textStyle: WidgetStatePropertyAll(TextStyle(color: AppColors.orangeColor))), child: Text(value.toDayMonthYearString()),
        )
      ),
      mediaWidget(model.mediaType, model.url),
      Text(model.title),
      Text(model.date),
      SizedBox(height: 15),
      Text(model.explanation),
    ],
  );

  Widget failed() => Center(child: Text('failed'));

  Widget loading() => Center(child: CircularProgressIndicator());

  @override
  Widget build(BuildContext context) {
    return BottomNavigatorScaffold(
      appBar: AppBar(title: Text('Wow!')),
      body: BlocBuilder<AstronomicalMediaBloc, AstronomicalMediaBlocState>(
        bloc: bloc,
        builder:
            (context, state) => switch (state.status) {
              AstronomicalMediaBlocStatus.initial => SizedBox(),
              AstronomicalMediaBlocStatus.loading => loading(),
              AstronomicalMediaBlocStatus.loaded => loaded(state.data!),
              AstronomicalMediaBlocStatus.failed => failed(),
            },
      ),
    );
  }
}
