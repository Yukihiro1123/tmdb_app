// test/golden_test.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie_response.dart';
import 'package:tmdb_app/src/features/movies/repository/movie_repository.dart';
import 'package:tmdb_app/src/features/movies/views/movie_list_page.dart';
import 'package:tmdb_app/src/utils/cached_manager/cache_manager_provider.dart';
import 'package:tmdb_app/src/utils/database/database_provider.dart';
import '../../../integration_test/helper/mock_response.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MockMovieRepository extends AutoDisposeNotifier<StoreRef>
    with Mock
    implements MovieRepository {}

class MockCacheManager extends AutoDisposeNotifier<CacheManager>
    with Mock
    implements CacheManager {}

class MockDatabase extends AutoDisposeNotifier<Database>
    with Mock
    implements Database {}

void main() {
  late MockMovieRepository mockMovieRepository;
  late MockDatabase mockDatabase;
  late MockCacheManager mockCacheManager;
  disableSembastCooperator();

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    HttpOverrides.global = null;
    mockMovieRepository = MockMovieRepository();
    mockDatabase = MockDatabase();
    mockCacheManager = MockCacheManager();
  });

  tearDownAll(() {
    reset(mockMovieRepository);
  });

  const devices = [
    Device(size: Size(320, 568), name: '4_inch'),
    Device(size: Size(428, 926), name: '6.7_inch'),
    Device(size: Size(1024, 1366), name: '12.9_inch'),
  ];

  testGoldens('golden_test', (WidgetTester tester) async {
    when(() => mockMovieRepository.getNowPlayingMovies(page: 1)).thenAnswer(
      (_) async {
        return MovieResponse.fromJson(mockNowPlayingResponsePage1);
      },
    );

    Database mockDb = await databaseFactoryMemory.openDatabase('database');
    await tester.pumpWidgetBuilder(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWith((ref) => mockDatabase),
          databaseProvider.overrideWithValue(mockDb),
          movieRepositoryProvider.overrideWith(() => mockMovieRepository),
          cachedManagerProvider.overrideWithValue(mockCacheManager)
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('ja'),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: "Noto_Sans_JP",
              useMaterial3: true,
              textTheme: const TextTheme(
                displayLarge: TextStyle(
                  fontSize: 72.0,
                  fontWeight: FontWeight.bold,
                ),
                titleLarge: TextStyle(fontSize: 36.0),
                titleMedium: TextStyle(
                  fontSize: 27.0,
                  fontWeight: FontWeight.w400,
                ),
                bodyMedium: TextStyle(
                  fontSize: 18.0,
                ),
              )),
          home: const MovieListPage(),
        ),
      ),
    );
    await multiScreenGolden(tester, 'now_playing_movie_list', devices: devices);
  });
}
