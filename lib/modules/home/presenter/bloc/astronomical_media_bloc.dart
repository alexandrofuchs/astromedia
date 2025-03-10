import 'package:astromedia/core/common/exceptions/app_exception.dart';
import 'package:astromedia/modules/home/domain/i_usecases/i_astronomical_media_usecase.dart';
import 'package:astromedia/modules/home/domain/models/astronomical_media_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'astronomical_media_bloc_part.dart';

class AstronomicalMediaBloc extends Bloc<AstronomicalMediaBlocEvent, AstronomicalMediaBlocState> {
  final IAstronomicalMediaUsecase _usecase;

  AstronomicalMediaBloc(this._usecase) : super(const AstronomicalMediaBlocState(AstronomicalMediaBlocStatus.initial)) {
    on<GetMediaEvent>((event, emit) async {
      emit(AstronomicalMediaBlocState(AstronomicalMediaBlocStatus.loading));

      final res = await _usecase.getMedia(event.date);

      res.resolve(
        onFail: (err) => emit(AstronomicalMediaBlocState(AstronomicalMediaBlocStatus.failed, error: err)),
        onSuccess: (data) => emit(AstronomicalMediaBlocState(AstronomicalMediaBlocStatus.loaded, data: data)),
      );
    });
  }
}
