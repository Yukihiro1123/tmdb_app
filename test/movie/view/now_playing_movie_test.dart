import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tmdb_app/env.dart';
import 'package:tmdb_app/src/common_widgets/movie_card_shimmer.dart';
import 'package:tmdb_app/src/features/movies/controller/movie_controller.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie/movie.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie_response.dart';
import 'package:tmdb_app/src/features/movies/repository/movie_repository.dart';
import 'package:tmdb_app/src/features/movies/views/component/movie_card.dart';
import 'package:tmdb_app/src/features/movies/views/component/movie_list.dart';
import 'package:tmdb_app/src/features/movies/views/component/now_playing_movie_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tmdb_app/src/utils/dio/dio_provider.dart';

class MockDio extends AutoDisposeNotifier<Dio> with Mock implements Dio {}

class MockPagingController with Mock implements PagingController<int, Movie> {}

class MockMovieRepository extends AutoDisposeNotifier<Dio>
    with Mock
    implements MovieRepository {}

void main() {
  late MockDio _dio;
  late MockMovieRepository _movieRepository;
  late MockPagingController _pagingController;

  setUp(() {
    HttpOverrides.global = null;
    _dio = MockDio();
    _pagingController = MockPagingController();
    _movieRepository = MockMovieRepository();
  });
  group('NowPlayingMovieList', () {
    testWidgets('1st page load', (widgetTester) async {
      when(() => _movieRepository.getNowPlayingMovies(page: 1)).thenAnswer(
        (_) async {
          return MovieResponse.fromJson(mockResponse10);
        },
      );
      await widgetTester.runAsync(() async {
        await widgetTester.pumpWidget(
          ProviderScope(
            overrides: [
              movieRepositoryProvider.overrideWith(() => _movieRepository)
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
        expect(find.byType(CircularProgressIndicator), findsWidgets);
        await widgetTester.pump();
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.text('Barbie'), findsOneWidget);
        await widgetTester.drag(
          find.byType(PagedGridView<int, Movie>),
          const Offset(0.0, -2000),
        );
        await widgetTester.pump();
        expect(find.text('Mob Land'), findsOneWidget);
      });
    });

    testWidgets('2nd page load', (widgetTester) async {
      final nowPlayingUrl = Uri(
        scheme: 'https',
        host: 'api.themoviedb.org',
        path: '3/movie/now_playing',
        queryParameters: {
          'language': 'ja-JP',
          'with_original_language': 'ja',
          'api_key': Env.apiKey,
          'include_adult': 'false',
          'page': '1',
        },
      ).toString();
      final nowPlayingUrl2 = Uri(
        scheme: 'https',
        host: 'api.themoviedb.org',
        path: '3/movie/now_playing',
        queryParameters: {
          'language': 'ja-JP',
          'with_original_language': 'ja',
          'api_key': Env.apiKey,
          'include_adult': 'false',
          'page': '2',
        },
      ).toString();
      when(() => _dio.get(nowPlayingUrl)).thenAnswer(
        (_) async {
          return Response(
            statusCode: 200,
            data: mockResponse10,
            requestOptions: RequestOptions(baseUrl: nowPlayingUrl),
          );
        },
      );
      when(() => _dio.get(nowPlayingUrl2)).thenAnswer(
        (_) async {
          return Response(
            statusCode: 200,
            data: mockResponse20,
            requestOptions: RequestOptions(baseUrl: nowPlayingUrl2),
          );
        },
      );
      await widgetTester.runAsync(() async {
        await widgetTester.pumpWidget(
          ProviderScope(
            overrides: [
              dioProvider.overrideWith((ref) => _dio),
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
        await widgetTester.pump();
        await widgetTester.drag(
          find.byType(PagedGridView<int, Movie>),
          const Offset(0.0, -1000),
        );
        await widgetTester.pump();
        await widgetTester.drag(
          find.byType(PagedGridView<int, Movie>),
          const Offset(0.0, -2000),
        );
        await widgetTester.pump();
        expect(find.text('The Mistress'), findsOneWidget);
      });
    });
  });
}

final Map<String, dynamic> mockResponse10 = {
  "dates": {"maximum": "2023-09-19", "minimum": "2023-08-02"},
  "page": 1,
  "results": [
    {
      "adult": false,
      "backdrop_path": "/ctMserH8g2SeOAnCw5gFjdQF8mo.jpg",
      "genre_ids": [35, 12, 14],
      "id": 346698,
      "original_language": "en",
      "original_title": "Barbie",
      "overview": "",
      "popularity": 3661.8,
      "poster_path": "/iuFNMS8U5cb6xfzi51Dbkovj7vM.jpg",
      "release_date": "2023-07-19",
      "title": "Barbie",
      "video": false,
      "vote_average": 7.3,
      "vote_count": 4286
    },
    {
      "adult": false,
      "backdrop_path": "/8pjWz2lt29KyVGoq1mXYu6Br7dE.jpg",
      "genre_ids": [28, 878, 27],
      "id": 615656,
      "original_language": "en",
      "original_title": "Meg 2: The Trench",
      "overview": "",
      "popularity": 2543.98,
      "poster_path": "/FQHtuf2zc8suMFE28RyvFt3FJN.jpg",
      "release_date": "2023-08-02",
      "title": "Meg 2: The Trench",
      "video": false,
      "vote_average": 7,
      "vote_count": 1686
    },
    {
      "adult": false,
      "backdrop_path": "/53z2fXEKfnNg2uSOPss2unPBGX1.jpg",
      "genre_ids": [27, 9648, 53],
      "id": 968051,
      "original_language": "en",
      "original_title": "The Nun II",
      "overview": "",
      "popularity": 1782.231,
      "poster_path": "/5gzzkR7y3hnY8AD1wXjCnVlHba5.jpg",
      "release_date": "2023-09-06",
      "title": "The Nun II",
      "video": false,
      "vote_average": 6.6,
      "vote_count": 130
    },
    {
      "adult": false,
      "backdrop_path": "/3mrli3xsGrAieQks7KsBUm2LpCg.jpg",
      "genre_ids": [28, 80, 53],
      "id": 979275,
      "original_language": "en",
      "original_title": "Mob Land",
      "overview": "",
      "popularity": 615.972,
      "poster_path": "/mcz8oi9oCgq1wkA3Wz2kluE94pE.jpg",
      "release_date": "2023-08-04",
      "title": "Mob Land",
      "video": false,
      "vote_average": 5.9,
      "vote_count": 19
    },
  ],
  "total_pages": 91,
  "total_results": 1812
};

final Map<String, dynamic> mockResponse20 = {
  "dates": {"maximum": "2023-09-20", "minimum": "2023-08-03"},
  "page": 2,
  "results": [
    {
      "adult": false,
      "backdrop_path": "/c6Splshb8lb2Q9OvUfhpqXl7uP0.jpg",
      "genre_ids": [28, 53],
      "id": 717930,
      "original_language": "en",
      "original_title": "Kandahar",
      "overview": "",
      "popularity": 597.995,
      "poster_path": "/lCanGgsqF4xD2WA5NF8PWeT3IXd.jpg",
      "release_date": "2023-05-25",
      "title": "Kandahar",
      "video": false,
      "vote_average": 6.7,
      "vote_count": 441
    },
    {
      "adult": false,
      "backdrop_path": "/h0nmmdFAdBjQttN8Y0q825MWzZp.jpg",
      "genre_ids": [28, 53, 80],
      "id": 926393,
      "original_language": "en",
      "original_title": "The Equalizer 3",
      "overview": "",
      "popularity": 405.449,
      "poster_path": "/p0WBnzgyqxMxbF4UGiqTwBLnwht.jpg",
      "release_date": "2023-08-30",
      "title": "The Equalizer 3",
      "video": false,
      "vote_average": 6.9,
      "vote_count": 163
    },
    {
      "adult": false,
      "backdrop_path": "/jv4tiXAgaArMQo57jFMjvBEjmoa.jpg",
      "genre_ids": [28, 18, 12],
      "id": 980489,
      "original_language": "en",
      "original_title": "Gran Turismo",
      "overview": "",
      "popularity": 277.91,
      "poster_path": "/51tqzRtKMMZEYUpSYkrUE7v9ehm.jpg",
      "release_date": "2023-08-09",
      "title": "Gran Turismo",
      "video": false,
      "vote_average": 7.5,
      "vote_count": 266
    },
    {
      "adult": false,
      "backdrop_path": "/jv4tiXAgaArMQo57jFMjvBEjmoa.jpg",
      "genre_ids": [28, 18, 12],
      "id": 980489,
      "original_language": "en",
      "original_title": "The Mistress",
      "overview": "",
      "popularity": 277.91,
      "poster_path": "/51tqzRtKMMZEYUpSYkrUE7v9ehm.jpg",
      "release_date": "2023-08-09",
      "title": "The Mistress",
      "video": false,
      "vote_average": 7.5,
      "vote_count": 266
    }
  ],
  "total_pages": 2,
  "total_results": 1793
};
