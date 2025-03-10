import 'package:astroimg/core/common/exceptions/app_exception.dart';
import 'package:astroimg/core/common/responses/results/i_response/i_response_result.dart';
import 'package:astroimg/modules/home/domain/i_repositories/i_astronomical_media_repository.dart';
import 'package:astroimg/modules/home/domain/i_usecases/i_astronomical_media_usecase.dart';

class AstronomicalMediaUsecase implements IAstronomicalMediaUsecase {
  final IAstronomicalMediaRepository _repository;

  AstronomicalMediaUsecase(this._repository);
  @override
  Future<IResponseResult<Object?>> getMedia(day) async {
    try{
      return Success(_repository.getMedia(day));
    }catch(e){
      return Fail(AppException(id: e, method: getMedia, namespace: this));
    }
  
  }

}