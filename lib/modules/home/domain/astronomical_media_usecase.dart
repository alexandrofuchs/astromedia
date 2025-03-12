import 'package:astromedia/core/common/exceptions/app_exception.dart';
import 'package:astromedia/core/common/responses/results/i_response/i_response_result.dart';
import 'package:astromedia/modules/home/domain/i_repositories/i_astronomical_media_repository.dart';
import 'package:astromedia/modules/home/domain/i_usecases/i_astronomical_media_usecase.dart';
import 'package:astromedia/modules/home/domain/models/astronomical_media_model.dart';

class AstronomicalMediaUsecase implements IAstronomicalMediaUsecase {
  final IAstronomicalMediaRepository _repository;

  AstronomicalMediaUsecase(this._repository);
  @override
  Future<IResponseResult<AstronomicalMediaModel>> getMedia(DateTime date) async {
    try {
      return Success(await _repository.getMedia(date));
    } catch (e) {
      return Fail(AppException(id: e, method: getMedia, namespace: this, publicMessage: 'Mídia não encontrada'));
    }
  }
}
