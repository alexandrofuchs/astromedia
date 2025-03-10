import 'package:astromedia/core/common/exceptions/app_exception.dart';
import 'package:astromedia/core/common/responses/results/i_response/i_response_result.dart';
import 'package:astromedia/modules/home/domain/i_usecases/i_astronomical_media_usecase.dart';
import 'package:astromedia/modules/home/domain/models/astronomical_media_model.dart';
import 'package:astromedia/modules/home/presenter/bloc/astronomical_media_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<IAstronomicalMediaUsecase>(),
  MockSpec<AstronomicalMediaModel>(),
])
import 'astronomical_media_bloc_test.mocks.dart';

AstronomicalMediaBlocState _createState(AstronomicalMediaBlocStatus status) =>
    AstronomicalMediaBlocState(status);

void main() {
  IAstronomicalMediaUsecase usecase = MockIAstronomicalMediaUsecase();

  group('AstronomicalMediaBloc', () {
    test('initial bloc state', () {
      final bloc = AstronomicalMediaBloc(usecase);
      expect(bloc.state.status == AstronomicalMediaBlocStatus.initial, isTrue);
    });

    test(
      'emits [AstronomicalMediaBlocState(loaded)] when GetMedia is added',
      () {
        final now = DateTime.now();

        when(
          usecase.getMedia(now),
        ).thenAnswer((_) async => Success(MockAstronomicalMediaModel()));
        final bloc = AstronomicalMediaBloc(usecase);
        bloc.add(GetMediaEvent(now));
        expectLater(
          bloc.stream,
          emitsInOrder([
            _createState(AstronomicalMediaBlocStatus.loading),
            _createState(AstronomicalMediaBlocStatus.loaded),
          ]),
        );
      },
    );

    test(
      'emits [AstronomicalMediaBlocState(failed)] when GetMedia is added',
      () {

        final now  = DateTime.now().add(Duration(days: 1));

        when(usecase.getMedia(now)).thenAnswer(
          (_) async => Fail(
            AppException(
              id: 'error',
              method: 'getMedia',
              namespace: 'astronomical_media_bloc_test',
            ),
          ),
        );
        final bloc = AstronomicalMediaBloc(usecase);
        bloc.add(GetMediaEvent(now));
        expectLater(
          bloc.stream,
          emitsInOrder([
            _createState(AstronomicalMediaBlocStatus.loading),
            _createState(AstronomicalMediaBlocStatus.failed),
          ]),
        );
      },
    );
  });
}
