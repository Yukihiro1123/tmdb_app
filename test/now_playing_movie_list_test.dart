import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie/movie.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie_response.dart';
import 'package:tmdb_app/src/features/movies/repository/movie_repository.dart';
import 'package:tmdb_app/src/features/movies/views/component/movie_card.dart';
import 'package:tmdb_app/src/features/movies/views/component/now_playing_movie_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tmdb_app/src/utils/database/database_provider.dart';

import '../integration_test/helper/mock_response.dart';

class MockMovieRepository extends AutoDisposeNotifier<StoreRef>
    with Mock
    implements MovieRepository {}

class MockDatabase extends AutoDisposeNotifier<Database>
    with Mock
    implements Database {}

void main() async {
  late MockMovieRepository mockMovieRepository;
  late MockDatabase mockDatabase;
  disableSembastCooperator();

  setUpAll(() async {
    HttpOverrides.global = null;
    mockMovieRepository = MockMovieRepository();
    mockDatabase = MockDatabase();
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDownAll(() {
    reset(mockMovieRepository);
  });
  group('NowPlayingMovieList', () {
    testWidgets('上映中の映画一覧が表示されること', (widgetTester) async {
      when(() => mockMovieRepository.getNowPlayingMovies(page: 1)).thenAnswer(
        (_) async {
          return MovieResponse.fromJson(mockNowPlayingResponsePage1);
        },
      );
      Database mockDb = await databaseFactoryMemory.openDatabase('database');
      await widgetTester.runAsync(() async {
        await widgetTester.pumpWidget(
          ProviderScope(
            overrides: [
              databaseProvider.overrideWith((ref) => mockDatabase),
              databaseProvider.overrideWithValue(mockDb),
              movieRepositoryProvider.overrideWith(() => mockMovieRepository),
            ],
            child: const MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: Locale('ja'),
              home: Material(
                child: NowPlayingMovieList(),
              ),
            ),
          ),
        );
        await widgetTester.pumpAndSettle();
        expect(find.byType(MovieCard), findsWidgets);
        expect(find.text('バイオハザード：デスアイランド'), findsOneWidget);
        await widgetTester.drag(
          find.byType(PagedSliverList<int, Movie>),
          const Offset(0.0, -2000),
        );
        await widgetTester.pumpAndSettle();
        expect(find.text('シン・エヴァンゲリオン劇場版'), findsOneWidget);
      });
    });
  });
}
