import 'package:astromedia/core/external/api/domain/i_interceptor/i_request_interceptor.dart';
import 'package:astromedia/modules/home/domain/i_repositories/i_astronomical_media_repository.dart';
import 'package:astromedia/modules/home/domain/models/astronomical_media_model.dart';

part 'astronomical_media_adapter.dart';

class AstronomicalMediaRepository implements IAstronomicalMediaRepository {
  final IRequestInterceptor _request;

  AstronomicalMediaRepository(this._request);

  @override
  Future<AstronomicalMediaModel> getMedia(day) async {
    // final res = _request.get('/planetary/apod?api_key=$apiKey');

    return AstronomicalMediaAdapter.fromMap({
      "copyright": "\nToni Fabiani Mendez\n",
      "date": "2025-03-10",
      "explanation":
          "Could Queen Calafia's mythical island exist in space? Perhaps not, but by chance the outline of this molecular space cloud echoes the outline of the state of California, USA. Our Sun has its home within the Milky Way's Orion Arm, only about 1,000 light-years from the California Nebula. Also known as NGC 1499, the classic emission nebula is around 100 light-years long. On the featured image, the most prominent glow of the California Nebula is the red light characteristic of hydrogen atoms recombining with long lost electrons, stripped away (ionized) by energetic starlight. The star most likely providing the energetic starlight that ionizes much of the nebular gas is the bright, hot, bluish Xi Persei just to the right of the nebula.  A regular target for astrophotographers, the California Nebula can be spotted with a wide-field telescope under a dark sky toward the constellation of Perseus, not far from the Pleiades.   Explore Your Universe: Random APOD Generator",
      "hdurl":
          "https://apod.nasa.gov/apod/image/2503/California_Mendez_2604.jpg",
      "media_type": "image",
      "service_version": "v1",
      "title": "NGC 1499: The California Nebula",
      "url": "https://apod.nasa.gov/apod/image/2503/California_Mendez_960.jpg",
    });
  }
}
