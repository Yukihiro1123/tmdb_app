import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sembast/sembast.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie_response.dart';
import 'package:tmdb_app/src/features/movies/repository/movie_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tmdb_app/src/features/movies/views/search_movie_page.dart';

import '../integration_test/helper/mock_response.dart';

class MockDio extends AutoDisposeNotifier<Dio> with Mock implements Dio {}

class MockMovieRepository extends AutoDisposeNotifier<StoreRef>
    with Mock
    implements MovieRepository {}

void main() {
  late MockDio dio;
  late MockMovieRepository movieRepository;

  setUp(() {
    HttpOverrides.global = null;
    dio = MockDio();
    movieRepository = MockMovieRepository();
  });

  tearDownAll(() {
    reset(dio);
    reset(movieRepository);
  });
  group('NowPlayingMovieList', () {
    testWidgets('検索結果がヒットして、映画リストが出てくる', (widgetTester) async {
      when(() => movieRepository.searchMovie(query: "犬", page: 1)).thenAnswer(
        (_) async {
          return MovieResponse.fromJson(mockSearchPage1Response);
        },
      );
      await widgetTester.runAsync(() async {
        await widgetTester.pumpWidget(
          ProviderScope(
            overrides: [
              movieRepositoryProvider.overrideWith(() => movieRepository)
            ],
            child: const MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: Locale('ja'),
              home: Material(
                child: SearchMoviePage(),
              ),
            ),
          ),
        );
        await widgetTester.pump();
        //検索フォーム
        expect(find.byIcon(Icons.search), findsOneWidget);
        expect(find.text('キーワードで映画を検索'), findsOneWidget);
        final queryForm = find.byType(SearchBar);
        await widgetTester.enterText(queryForm, '犬');
        await widgetTester.tap(find.byIcon(Icons.search));
        await widgetTester.pump();
        expect(find.text('キーワードで映画を検索'), findsNothing);
        await widgetTester.pump();
        expect(find.text('Dog'), findsOneWidget);
        await widgetTester.drag(
          find.byType(CustomScrollView),
          const Offset(0.0, -2000),
        );
        await widgetTester.pump();
        expect(find.text("トッド・ソロンズの子犬物語"), findsOneWidget);
      });
    });

    testWidgets('検索結果がヒットしなければ映画リストが出てこず、映画が見つかりませんと出る', (widgetTester) async {
      when(() => movieRepository.searchMovie(query: "dddd", page: 1))
          .thenAnswer(
        (_) async {
          return MovieResponse.fromJson(mockNoResultResponse);
        },
      );
      await widgetTester.runAsync(() async {
        await widgetTester.pumpWidget(
          ProviderScope(
            overrides: [
              movieRepositoryProvider.overrideWith(() => movieRepository)
            ],
            child: const MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: Locale('ja'),
              home: Material(
                child: SearchMoviePage(),
              ),
            ),
          ),
        );
        await widgetTester.pump();
        //検索フォーム
        expect(find.byIcon(Icons.search), findsOneWidget);
        expect(find.text('キーワードで映画を検索'), findsOneWidget);
        final queryForm = find.byType(SearchBar);
        await widgetTester.enterText(queryForm, 'dddd');
        await widgetTester.tap(find.byIcon(Icons.search));
        await widgetTester.pump();
        expect(find.text('キーワードで映画を検索'), findsNothing);
        await widgetTester.pump();
        expect(find.text('映画が見つかりません'), findsOneWidget);
      });
    });
  });
}
