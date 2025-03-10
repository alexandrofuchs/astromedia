import 'dart:convert';
import 'package:astromedia/core/external/api/api_request_interceptor.dart';
import 'package:astromedia/core/external/api/domain/i_interceptor/i_request_interceptor.dart';
import 'package:astromedia/core/helpers/extensions/datetime_extension.dart';
import 'package:astromedia/load_environment.dart';
import 'package:astromedia/modules/home/domain/i_repositories/i_astronomical_media_repository.dart';
import 'package:astromedia/modules/home/domain/models/astronomical_media_model.dart';
import 'package:astromedia/modules/home/external/astronomical_media_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<IRequestInterceptor>()])
import 'astronomical_media_repository_test.mocks.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await loadAppEnvironment(AppEnvironment.test);

  IRequestInterceptor api = MockIRequestInterceptor();
  IAstronomicalMediaRepository repo = AstronomicalMediaRepository(api);

  test('astronomical media repository valid data', () async {
    final date = DateTime.now();
    when(api.get('/planetary/apod?api_key=$apiKey&date=${date.toYearMonthDayString('-')}')).thenAnswer(
      (_) async =>
          jsonDecode(await rootBundle.loadString('mocks/api_media_data.json')),
    );
    final response = await repo.getMedia(DateTime.now());
    expect(response, isA<AstronomicalMediaModel>());
  });

  test('astronomical media repository invalid data', () async {
    when(api.get('/planetary/apod?api_key')).thenAnswer(
      (_) async =>
          jsonDecode(await rootBundle.loadString('mocks/api_media_error.json')),
    );

    try {
      await repo.getMedia(DateTime.now().add(Duration(days: 1)));
      fail('test passed with invalid data');
    } catch (e) {
      debugPrint('ok');
    }
  });
}
