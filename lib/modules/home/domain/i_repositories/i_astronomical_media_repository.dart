import 'package:astromedia/modules/home/domain/models/astronomical_media_model.dart';

abstract interface class IAstronomicalMediaRepository {
  Future<AstronomicalMediaModel> getMedia(DateTime date);
}