import 'package:astromedia/core/common/responses/results/i_response/i_response_result.dart';
import 'package:astromedia/modules/home/domain/models/astronomical_media_model.dart';

abstract interface class IAstronomicalMediaUsecase {
  Future<IResponseResult<AstronomicalMediaModel>> getMedia(DateTime date);
}