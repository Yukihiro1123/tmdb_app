import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tmdb_app/env.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie_response.dart';
import 'package:tmdb_app/src/features/movies/repository/movie_repository.dart';
import 'package:tmdb_app/src/utils/dio/dio_provider.dart';

import '../../../integration_test/helper/mock_url.dart';

class MockDio extends AutoDisposeNotifier<Dio> with Mock implements Dio {}

void main() {
  late MockDio dio;
  late ProviderContainer container;

  setUp(() {
    dio = MockDio();
    container = ProviderContainer(
      overrides: [
        dioProvider.overrideWith((ref) => dio),
      ],
    );
  });

  tearDownAll(() {
    reset(dio);
    container.dispose();
  });
  group('getNowPlayingMovies', () {
    //TODO
    test('MovieResponse型のデータを返す.', () async {
      when(() => dio.get(nowPlayingUrlPage1)).thenAnswer(
        (_) async => Response(
          statusCode: 200,
          data: mockResponse,
          requestOptions: RequestOptions(baseUrl: nowPlayingUrlPage1),
        ),
      );
      final movieResponse = await container
          .read(movieRepositoryProvider.notifier)
          .getNowPlayingMovies(page: 1);
      expect(movieResponse, isA<MovieResponse>());
    });

    test('API呼び出しの際にエラーが出たら例外を返す', () async {
      when(() => dio.get(nowPlayingUrlPage1))
          .thenThrow(Exception('Failed to load movie'));

      expect(
          () => container
              .read(movieRepositoryProvider.notifier)
              .getNowPlayingMovies(page: 1),
          throwsA(isA<Exception>()));
    });
  });
}

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
