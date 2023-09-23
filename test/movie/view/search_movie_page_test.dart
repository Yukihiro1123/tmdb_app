import 'dart:io';

import 'package:dio/dio.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tmdb_app/src/features/movies/views/search_movie_page.dart';

import '../../../integration_test/helper/mock_response.dart';

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
        await widgetTester.pumpAndSettle();
        //検索フォーム
        expect(find.byIcon(Icons.search), findsOneWidget);
        expect(find.text('キーワードで映画を検索'), findsOneWidget);
        final queryForm = find.byType(SearchBar);
        await widgetTester.enterText(queryForm, '犬');
        await widgetTester.tap(find.byIcon(Icons.search));
        await widgetTester.pumpAndSettle();
        expect(find.text('キーワードで映画を検索'), findsNothing);
        await widgetTester.pumpAndSettle();
        expect(find.text('Dog'), findsOneWidget);
        await widgetTester.drag(
          find.byType(PagedGridView<int, Movie>),
          const Offset(0.0, -2000),
        );
        await widgetTester.pumpAndSettle();
        expect(find.text("トッド・ソロンズの子犬物語"), findsOneWidget);
      });
    });

    testWidgets('検索結果がヒットしなければ映画リストが出てこず、映画が見つかりませんと出る', (widgetTester) async {
      when(() => movieRepository.searchMovie(query: "dddd", page: 1))
          .thenAnswer(
        (_) async {
          return MovieResponse.fromJson(noResultResponse);
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
        await widgetTester.pumpAndSettle();
        //検索フォーム
        expect(find.byIcon(Icons.search), findsOneWidget);
        expect(find.text('キーワードで映画を検索'), findsOneWidget);
        final queryForm = find.byType(SearchBar);
        await widgetTester.enterText(queryForm, 'dddd');
        await widgetTester.tap(find.byIcon(Icons.search));
        await widgetTester.pumpAndSettle();
        expect(find.text('キーワードで映画を検索'), findsNothing);
        await widgetTester.pumpAndSettle();
        expect(find.text('映画が見つかりません'), findsOneWidget);
      });
    });
  });
}

final Map<String, dynamic> noResultResponse = {
  "page": 1,
  "results": [],
  "total_pages": 1,
  "total_results": 0
};

final Map<String, dynamic> mockResponse = {
  "page": 1,
  "results": [
    {
      "adult": false,
      "backdrop_path": "/4tdV5AeojEdbvn6VpeQrbuDlmzs.jpg",
      "genre_ids": [16, 18, 12, 14],
      "id": 916224,
      "original_language": "ja",
      "original_title": "すずめの戸締まり",
      "overview": "",
      "popularity": 183.476,
      "poster_path": "/vIeu8WysZrTSFb2uhPViKjX9EcC.jpg",
      "release_date": "2022-11-11",
      "title": "Suzume",
      "video": false,
      "vote_average": 7.95,
      "vote_count": 666
    },
    {
      "adult": false,
      "backdrop_path": "/4C7wUn40dYLNA78voWCQFXddCjk.jpg",
      "genre_ids": [18],
      "id": 456473,
      "original_language": "ja",
      "original_title": "海すずめ",
      "overview": "",
      "popularity": 1.722,
      "poster_path": "/y6vzQ0BBSh2ks0Y6ZxJPW4p18FE.jpg",
      "release_date": "2016-07-02",
      "title": "The Book Peddler",
      "video": false,
      "vote_average": 0.0,
      "vote_count": 0
    },
    {
      "adult": false,
      "backdrop_path": null,
      "genre_ids": [16, 14],
      "id": 1112608,
      "original_language": "ja",
      "original_title": "したきりすずめ",
      "overview": "",
      "popularity": 0.654,
      "poster_path": "/aGb0hlIXk2HkWJzTjGLBaDy8Ka9.jpg",
      "release_date": "1974-01-01",
      "title": "The Sparrow with the Slit Tongue",
      "video": false,
      "vote_average": 0.0,
      "vote_count": 0
    },
    {
      "adult": false,
      "backdrop_path": null,
      "genre_ids": [16],
      "id": 518557,
      "original_language": "ja",
      "original_title": "ひょうたんすずめ",
      "overview": "",
      "popularity": 0.6,
      "poster_path": "/95LYUcV7fRoLwpgoswdgqa4xHfK.jpg",
      "release_date": "1959-02-10",
      "title": "The Sparrow in the Pumpkin",
      "video": false,
      "vote_average": 0.0,
      "vote_count": 0
    },
    {
      "adult": false,
      "backdrop_path": null,
      "genre_ids": [],
      "id": 943255,
      "original_language": "ja",
      "original_title": "べにすずめたちの週末",
      "overview": "",
      "popularity": 1.46,
      "poster_path": "/bZcQNQoODGzbhoOomNUejRtPRRs.jpg",
      "release_date": "1993-01-15",
      "title": "Benisuzume's Weekend",
      "video": false,
      "vote_average": 0.0,
      "vote_count": 0
    }
  ],
  "total_pages": 1,
  "total_results": 6
};
