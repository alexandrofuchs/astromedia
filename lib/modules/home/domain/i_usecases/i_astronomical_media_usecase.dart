import 'package:astroimg/core/common/responses/results/i_response/i_response_result.dart';

abstract interface class IAstronomicalMediaUsecase {
  Future<IResponseResult> getMedia(dynamic day);
}