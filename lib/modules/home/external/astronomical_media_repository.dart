import 'package:astromedia/core/external/api/api_request_interceptor.dart';
import 'package:astromedia/core/external/api/domain/i_interceptor/i_request_interceptor.dart';
import 'package:astromedia/core/helpers/extensions/datetime_extension.dart';
import 'package:astromedia/core/helpers/formatters/date_string_formatters.dart';
import 'package:astromedia/modules/home/domain/enums/media_type.dart';
import 'package:astromedia/modules/home/domain/i_repositories/i_astronomical_media_repository.dart';
import 'package:astromedia/modules/home/domain/models/astronomical_media_model.dart';

part 'astronomical_media_adapter.dart';

class AstronomicalMediaRepository implements IAstronomicalMediaRepository {
  final IRequestInterceptor _request;

  AstronomicalMediaRepository(this._request);

  @override
  Future<AstronomicalMediaModel> getMedia(DateTime date) async {
    final res = await _request.get('/planetary/apod?api_key=$apiKey&date=${date.toYearMonthDayString('-')}');
    return AstronomicalMediaAdapter.fromMap(res);
  }
}
