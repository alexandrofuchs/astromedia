import 'package:astromedia/core/common/responses/results/i_response/i_response_result.dart';
import 'package:astromedia/modules/home/domain/astronomical_media_usecase.dart';
import 'package:astromedia/modules/home/domain/i_repositories/i_astronomical_media_repository.dart';
import 'package:astromedia/modules/home/domain/i_usecases/i_astronomical_media_usecase.dart';
import 'package:astromedia/modules/home/domain/models/astronomical_media_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<IAstronomicalMediaRepository>(), MockSpec<AstronomicalMediaModel>()])
import 'astronomical_media_usecase_test.mocks.dart';

void main() {
  IAstronomicalMediaRepository repository = MockIAstronomicalMediaRepository();
  IAstronomicalMediaUsecase usecase = AstronomicalMediaUsecase(repository);

  test('motels usecase succeed', () async {
    final now = DateTime.now();

    when(repository.getMedia(now)).thenAnswer((_) async => MockAstronomicalMediaModel());
    final response = await usecase.getMedia(now);
    expect(response, isA<Success<AstronomicalMediaModel>>());
  });

  test('motels usecase failed', () async {
    final now = DateTime.now().add(Duration(days: 1));
    when(repository.getMedia(now)).thenThrow('cannot load the media');
    final response = await usecase.getMedia(now);
    expect(response, isA<Fail>());
  });
}