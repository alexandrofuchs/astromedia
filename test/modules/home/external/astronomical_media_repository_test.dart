import 'dart:convert';
import 'package:astromedia/core/external/api/domain/i_interceptor/i_request_interceptor.dart';
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

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  IRequestInterceptor api = MockIRequestInterceptor();
  IAstronomicalMediaRepository repo = AstronomicalMediaRepository(api);

  test('astronomical media repository valid data', () async {
    when(api.get('/planetary/apod?api_key')).thenAnswer(
      (_) async =>
          jsonDecode(await rootBundle.loadString('mocks/api_media_data.json')),
    );
    final response = await repo.getMedia('a');
    expect(response, isA<AstronomicalMediaModel>());
  });

  test('astronomical media repository invalid data', () async {
    when(api.get('/planetary/apod?api_key')).thenAnswer(
      (_) async =>
          jsonDecode(await rootBundle.loadString('mocks/api_media_error.json')),
    );

    try {
      await repo.getMedia('b');
      fail('test passed with invalid data');
    } catch (e) {
      debugPrint('ok');
    }
  });
}
