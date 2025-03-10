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

  @override
  void initState() {
    bloc.add(GetMedia());

    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  Widget mediaWidget(MediaType media, String uri) =>
    switch (media) {
    MediaType.image => AstronomicalImageWidget(uri: uri),
    MediaType.video => AstronomicalVideoWidget(uri: uri),
    MediaType.none => SizedBox(),
    };

  Widget loaded(AstronomicalMediaModel model) =>
    Column(children: [
      mediaWidget(model.mediaType, model.url),
      Text(model.title),
      Text(model.date)
    ],);

  Widget failed() => Center(child: Text('failed'));

  Widget loading() => Center(child: CircularProgressIndicator());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
