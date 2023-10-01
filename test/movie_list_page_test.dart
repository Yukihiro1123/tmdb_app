import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:tmdb_app/src/features/movies/views/component/movie_card.dart';
import 'package:tmdb_app/src/features/movies/views/movie_list_page.dart';
import 'package:tmdb_app/src/utils/database/database_provider.dart';
import 'package:tmdb_app/src/utils/dio/dio_provider.dart';

import '../integration_test/helper/mock_response.dart';
import '../integration_test/helper/mock_url.dart';

class MockDio extends AutoDisposeNotifier<Dio> with Mock implements Dio {}

class MockDatabase extends AutoDisposeNotifier<Database>
    with Mock
    implements Database {}

void main() {
  late MockDio mockDio;
  late MockDatabase mockDatabase;
  late Database mockDb;

  disableSembastCooperator();

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    HttpOverrides.global = null;
    mockDb = await databaseFactoryMemory.openDatabase('database');
    mockDio = MockDio();
    mockDatabase = MockDatabase();
  });

  tearDownAll(() {
    reset(mockDio);
  });

  const devices = [
    Device(size: Size(320, 568), name: '4_inch'),
    Device(size: Size(428, 926), name: '6.7_inch'),
    Device(size: Size(1024, 1366), name: '12.9_inch'),
  ];

  testWidgets('上映中の映画一覧が表示されること', (widgetTester) async {
    when(() => mockDio.get(nowPlayingUrlPage1)).thenAnswer(
      (_) async {
        return Response(
          statusCode: 200,
          data: mockNowPlayingResponsePage1,
          requestOptions: RequestOptions(baseUrl: nowPlayingUrlPage1),
        );
      },
    );
    await widgetTester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWith((ref) => mockDatabase),
          databaseProvider.overrideWithValue(mockDb),
          dioProvider.overrideWith((ref) => mockDio),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('ja'),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Noto_Sans_JP',
            useMaterial3: true,
            textTheme: const TextTheme(
              displayLarge: TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.bold,
              ),
              titleLarge: TextStyle(fontSize: 36),
              titleMedium: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w400,
              ),
              bodyMedium: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          home: const MovieListPage(),
        ),
      ),
    );
    await widgetTester.pumpAndSettle();
    expect(find.byType(MovieCard), findsWidgets);
    expect(find.text('バイオハザード：デスアイランド'), findsOneWidget);
    await widgetTester.drag(
      find.byType(CustomScrollView),
      const Offset(0, -2000),
    );
    await widgetTester.pumpAndSettle();
    expect(find.text('シン・エヴァンゲリオン劇場版'), findsOneWidget);
  });

  testGoldens('golden_test', (WidgetTester tester) async {
    when(() => mockDio.get(nowPlayingUrlPage1)).thenAnswer(
      (_) async {
        return Response(
          statusCode: 200,
          data: mockNowPlayingResponsePage1,
          requestOptions: RequestOptions(baseUrl: nowPlayingUrlPage1),
        );
      },
    );
    when(() => mockDio.get(upcomingUrl)).thenAnswer(
      (_) async {
        return Response(
          statusCode: 200,
          data: mockUpcomingResponse,
          requestOptions: RequestOptions(baseUrl: upcomingUrl),
        );
      },
    );
    await tester.pumpWidgetBuilder(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWith((ref) => mockDatabase),
          databaseProvider.overrideWithValue(mockDb),
          dioProvider.overrideWith((ref) => mockDio),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('ja'),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Noto_Sans_JP',
            useMaterial3: true,
            textTheme: const TextTheme(
              displayLarge: TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.bold,
              ),
              titleLarge: TextStyle(fontSize: 36),
              titleMedium: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w400,
              ),
              bodyMedium: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          home: const MovieListPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await multiScreenGolden(tester, 'movie_list_page', devices: devices);
  });
}
