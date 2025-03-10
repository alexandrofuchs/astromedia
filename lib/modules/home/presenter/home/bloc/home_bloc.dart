import 'package:astromedia/core/common/exceptions/app_exception.dart';
import 'package:astromedia/modules/home/domain/i_usecases/i_astronomical_media_usecase.dart';
import 'package:astromedia/modules/home/domain/models/astronomical_media_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_bloc_part.dart';

class HomeBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  final IAstronomicalMediaUsecase _usecase;

  HomeBloc(this._usecase) : super(const HomeBlocState(HomeBlocStatus.initial)) {
    on<GetMedia>((event, emit) async {
      final res = await _usecase.getMedia('a');

      res.resolve(
        onFail: (err) => emit(HomeBlocState(HomeBlocStatus.failed, error: err)),
        onSuccess:
            (data) => emit(HomeBlocState(HomeBlocStatus.loaded, data: data)),
      );
    });
  }
}
