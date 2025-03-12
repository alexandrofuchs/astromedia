import 'package:astromedia/core/common/exceptions/app_exception.dart';
import 'package:astromedia/load_environment.dart';
import 'package:astromedia/modules/home/domain/enums/media_type.dart';
import 'package:astromedia/modules/home/domain/models/astronomical_media_model.dart';
import 'package:astromedia/modules/home/home_module.dart';
import 'package:astromedia/modules/home/presenter/bloc/astronomical_media_bloc.dart';
import 'package:astromedia/modules/home/presenter/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockAstronomicalMediaBloc extends MockBloc<AstronomicalMediaBlocEvent, AstronomicalMediaBlocState> implements AstronomicalMediaBloc {}

class MockSharedPreferences extends Mock  implements SharedPreferences {}


void main() async {

  await loadAppEnvironment(AppEnvironment.test);

  late AstronomicalMediaBloc mockBloc;
  late SharedPreferences mockSharedPreferences;
  late AstronomicalMediaModel mockModel;
  
  setUp(() {
    mockBloc = MockAstronomicalMediaBloc();
    mockSharedPreferences = MockSharedPreferences();
    mockModel = AstronomicalMediaModel(
      copyright: 'Toni Fabiani Mendez', 
      date: DateTime.now(), 
      explanation: "Could Queen Calafia's mythical island exist in space?", 
      hdUrl: 'https://apod.nasa.gov/apod/image/2503/California_Mendez_2604.jpg', 
      mediaType: MediaType.fromValue("image"), 
      title: "NGC 1499: The California Nebula", 
      url: 'https://apod.nasa.gov/apod/image/2503/California_Mendez_960.jpg');
  });

  testWidgets('Load the home page', (WidgetTester tester) async {
    
    Modular.bindModule(HomeModule());

    when(() => mockBloc.state).thenReturn(AstronomicalMediaBlocState(AstronomicalMediaBlocStatus.initial));

    when(() => mockSharedPreferences.getStringList('dates')).thenReturn([]);
    when(() => mockSharedPreferences.getBool('dark_theme_mode')).thenReturn(false);

    
    await tester.pumpWidget(
      MaterialApp(home: BlocProvider<AstronomicalMediaBloc>.value(
        value: mockBloc,
        child: HomePage(bloc: mockBloc, sharedPreferences: Future.value(MockSharedPreferences()),),
      )),
    );

    await tester.pumpAndSettle(Duration(milliseconds: 1000));

    expect(find.byType(BlocBuilder<AstronomicalMediaBloc, AstronomicalMediaBlocState>), findsOneWidget);
  });

  testWidgets('Load the correct widget when state loaded', (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(AstronomicalMediaBlocState(AstronomicalMediaBlocStatus.loaded, data: mockModel ));
    

    await tester.pumpWidget(
      MaterialApp(home: BlocProvider<AstronomicalMediaBloc>.value(
        value: mockBloc,
        child: HomePage(bloc: mockBloc, sharedPreferences: Future.value(mockSharedPreferences)),
      ),
    ));

    await tester.pumpAndSettle(Duration(milliseconds: 1000));

    /// verify if loaded the correct widget by passing the respectively loaded state
    expect(find.byKey(Key('mediaWidget')), findsOneWidget);
  });

   testWidgets('Load the correct widget when state failed', (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(AstronomicalMediaBlocState(AstronomicalMediaBlocStatus.failed, error: AppException(id: 'error', method: 'test', namespace: 'home_page_test')));

    await tester.pumpWidget(
      MaterialApp(home: BlocProvider<AstronomicalMediaBloc>.value(
        value: mockBloc,
        child: HomePage(bloc: mockBloc, sharedPreferences: Future.value(mockSharedPreferences)),
      )),
    );

    await tester.pumpAndSettle(Duration(milliseconds: 1000));

    /// verify if loaded the correct widget by passing the respectively failed state
    expect(find.byKey(Key('failedWidget')), findsOneWidget);
  });
}