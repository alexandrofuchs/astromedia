import 'package:astroimg/core/external/api/api_request_interceptor.dart';
import 'package:astroimg/core/external/api/domain/i_interceptor/i_request_interceptor.dart';
import 'package:astroimg/modules/home/domain/i_repositories/i_astronomical_media_repository.dart';

class AstronomicalMediaRepository implements IAstronomicalMediaRepository {
  final IRequestInterceptor _request;

  AstronomicalMediaRepository(this._request);
  
  @override
  Future<void> getMedia(day) async {
    final res = _request.get('/planetary/apod?api_key=$apiKey');
    
  }

}