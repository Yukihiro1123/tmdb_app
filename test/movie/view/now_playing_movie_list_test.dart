import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sembast/sembast.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie/movie.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie_response.dart';
import 'package:tmdb_app/src/features/movies/repository/movie_repository.dart';
import 'package:tmdb_app/src/features/movies/views/component/now_playing_movie_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../integration_test/helper/mock_response.dart';

class MockMovieRepository extends AutoDisposeNotifier<StoreRef>
    with Mock
    implements MovieRepository {}

void main() {
  late MockMovieRepository mockMovieRepository;

  setUpAll(() {
    HttpOverrides.global = null;
    mockMovieRepository = MockMovieRepository();
    when(() => mockMovieRepository.getNowPlayingMovies(page: 1)).thenAnswer(
      (_) async {
        return MovieResponse.fromJson(mockNowPlayingResponsePage1);
      },
    );
    when(() => mockMovieRepository.getNowPlayingMovies(page: 2)).thenAnswer(
      (_) async {
        return MovieResponse.fromJson(mockNowPlayingResponsePage2);
      },
    );
  });

  tearDownAll(() {
    reset(mockMovieRepository);
  });
  group('NowPlayingMovieList', () {
    testWidgets('1st page load', (widgetTester) async {
      await widgetTester.runAsync(() async {
        await widgetTester.pumpWidget(
          ProviderScope(
            overrides: [
              movieRepositoryProvider.overrideWith(() => mockMovieRepository)
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
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        await widgetTester.pumpAndSettle();
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.text('バイオハザード：デスアイランド'), findsOneWidget);
        await widgetTester.drag(
          find.byType(PagedGridView<int, Movie>),
          const Offset(0.0, -2000),
        );
        await widgetTester.pumpAndSettle();
        expect(find.text('シン・エヴァンゲリオン劇場版'), findsOneWidget);
      });
    });
    //TODO
    testWidgets('2nd page load', (widgetTester) async {
      await widgetTester.runAsync(() async {
        await widgetTester.pumpWidget(
          ProviderScope(
            overrides: [
              movieRepositoryProvider.overrideWith(() => mockMovieRepository)
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
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        await widgetTester.pumpAndSettle();
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.text('バイオハザード：デスアイランド'), findsOneWidget);
        await widgetTester.drag(
          find.byType(PagedGridView<int, Movie>),
          const Offset(0.0, -2000),
        );
        await widgetTester.pumpAndSettle();
        expect(find.text('シン・エヴァンゲリオン劇場版'), findsOneWidget);
        await widgetTester.drag(
          find.byType(PagedGridView<int, Movie>),
          const Offset(0.0, -2000),
        );
        await widgetTester.pumpAndSettle();
        expect(find.text('シン・エヴァンゲリオン劇場版'), findsOneWidget);
      });
    });
  });
}
