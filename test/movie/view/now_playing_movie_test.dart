import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
import 'package:tmdb_app/src/features/movies/views/component/now_playing_movie_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tmdb_app/src/utils/dio/dio_provider.dart';

class MockDio extends AutoDisposeNotifier<Dio> with Mock implements Dio {}

// class MockPagingController with Mock implements PagingController<int, Movie> {}

class MockMovieController extends AutoDisposeNotifier<AsyncValue<dynamic>>
    with Mock
    implements MovieController {
  @override
  AsyncValue build() {
    return AsyncData([MovieResponse.fromJson(mockResponse)]);
  }
}

class MockMovieRepository extends AutoDisposeNotifier<Dio>
    with Mock
    implements MovieRepository {}

void main() {
  late MockDio _dio;
  late ProviderContainer container;
  late MockMovieController _movieController;
  late MockMovieRepository _movieRepository;
  // late MockPagingController _pagingController;

  setUp(() {
    HttpOverrides.global = null;
    _dio = MockDio();
    // _pagingController = MockPagingController();
    _movieController = MockMovieController();
    _movieRepository = MockMovieRepository();
    container = ProviderContainer(
      overrides: [
        dioProvider.overrideWith((ref) => _dio),
        movieControllerProvider.overrideWith(() => _movieController)
      ],
    );
  });
  group('ddd', () {
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

    testWidgets('1st page load', (widgetTester) async {
      when(() => _dio.get(nowPlayingUrl)).thenAnswer(
        (_) async {
          return Response(
            statusCode: 200,
            data: mockResponse10,
            requestOptions: RequestOptions(baseUrl: nowPlayingUrl),
          );
        },
      );
      when(() => container
          .read(movieControllerProvider.notifier)
          .getNowPlayingMovies(page: 1)).thenAnswer(
        (_) async {
          return MovieResponse.fromJson(mockResponse10);
        },
      );

      await widgetTester.runAsync(() async {
        await widgetTester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: Locale('ja'),
              home: Material(
                child: NowPlayingMovieList(),
              ),
            ),
          ),
        );
        expect(find.byType(MovieCardShimmer), findsWidgets);
        expect(find.text("Barbie"), findsWidgets);
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
      "backdrop_path": "/55Rb9qt3yzyF4KQpC1c3T3Fbcao.jpg",
      "genre_ids": [27, 53],
      "id": 1008042,
      "original_language": "en",
      "original_title": "Talk to Me",
      "overview": "",
      "popularity": 1370.306,
      "poster_path": "/kdPMUMJzyYAc4roD52qavX0nLIC.jpg",
      "release_date": "2023-07-26",
      "title": "Talk to Me",
      "video": false,
      "vote_average": 7.2,
      "vote_count": 386
    },
    {
      "adult": false,
      "backdrop_path": "/4fLZUr1e65hKPPVw0R3PmKFKxj1.jpg",
      "genre_ids": [16, 35, 10751, 14, 10749],
      "id": 976573,
      "original_language": "en",
      "original_title": "Elemental",
      "overview": "",
      "popularity": 1153.497,
      "poster_path": "/6oH378KUfCEitzJkm07r97L0RsZ.jpg",
      "release_date": "2023-06-14",
      "title": "Elemental",
      "video": false,
      "vote_average": 7.8,
      "vote_count": 1921
    },
    {
      "adult": false,
      "backdrop_path": "/2ii07lSwHarg0gWnJoCYL3Gyd1j.jpg",
      "genre_ids": [35, 12],
      "id": 912908,
      "original_language": "en",
      "original_title": "Strays",
      "overview": "",
      "popularity": 849.081,
      "poster_path": "/n1hqbSCtyBAxaXEl1Dj3ipXJAJG.jpg",
      "release_date": "2023-08-17",
      "title": "Strays",
      "video": false,
      "vote_average": 7.4,
      "vote_count": 230
    },
    {
      "adult": false,
      "backdrop_path": "/waBWlJlMpyFb7STkFHfFvJKgwww.jpg",
      "genre_ids": [28, 18],
      "id": 678512,
      "original_language": "en",
      "original_title": "Sound of Freedom",
      "overview": "",
      "popularity": 806.113,
      "poster_path": "/kSf9svfL2WrKeuK8W08xeR5lTn8.jpg",
      "release_date": "2023-07-03",
      "title": "Sound of Freedom",
      "video": false,
      "vote_average": 8,
      "vote_count": 442
    },
    {
      "adult": false,
      "backdrop_path": "/w2nFc2Rsm93PDkvjY4LTn17ePO0.jpg",
      "genre_ids": [16, 35, 28],
      "id": 614930,
      "original_language": "en",
      "original_title": "Teenage Mutant Ninja Turtles: Mutant Mayhem",
      "overview": "",
      "popularity": 792.214,
      "poster_path": "/ueO9MYIOHO7M1PiMUeX74uf8fB9.jpg",
      "release_date": "2023-07-31",
      "title": "Teenage Mutant Ninja Turtles: Mutant Mayhem",
      "video": false,
      "vote_average": 7.2,
      "vote_count": 426
    },
    {
      "adult": false,
      "backdrop_path": "/2vFuG6bWGyQUzYS9d69E5l85nIz.jpg",
      "genre_ids": [28, 12, 878],
      "id": 667538,
      "original_language": "en",
      "original_title": "Transformers: Rise of the Beasts",
      "overview": "",
      "popularity": 745.922,
      "poster_path": "/gPbM0MK8CP8A174rmUwGsADNYKD.jpg",
      "release_date": "2023-06-06",
      "title": "Transformers: Rise of the Beasts",
      "video": false,
      "vote_average": 7.5,
      "vote_count": 3136
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

final Map<String, dynamic> mockResponse = {
  "dates": {"maximum": "2023-09-11", "minimum": "2023-07-25"},
  "page": 1,
  "results": [
    {
      "adult": false,
      "backdrop_path": "/65rFnxzirxQDM0rYWmtAUYnjc.jpg",
      "genre_ids": [27, 53],
      "id": 1094713,
      "original_language": "en",
      "original_title": "The Mistress",
      "overview": "Newlyweds...",
      "popularity": 382.497,
      "poster_path": "/1kdmre0wlUAUk9BvySv4Xoveieg.jpg",
      "release_date": "2023-07-28",
      "title": "The Mistress",
      "video": false,
      "vote_average": 4.8,
      "vote_count": 8
    }
  ],
  "total_pages": 96,
  "total_results": 1908
};
