import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie_response.dart';
import 'package:tmdb_app/src/features/movies/repository/movie_repository.dart';
import 'package:tmdb_app/src/utils/dio/dio_provider.dart';
import 'package:http/http.dart' as http;
import 'movie_repository_test.mocks.dart';

class MockMovieRepository extends AutoDisposeNotifier<Dio>
    with Mock
    implements MovieRepository {}

void main() {
  late MockMovieRepository _repository;
  late MockDio _dio;
  late ProviderContainer container;

  setUp(() {
    _repository = MockMovieRepository();
    _dio = MockDio();
    container = ProviderContainer(
      overrides: [
        dioProvider.overrideWith((ref) => _dio),
        movieRepositoryProvider.overrideWith(() => _repository),
      ],
    );
  });

  group('getNowPlayingMovies', () {
    test('MovieResponse型のデータを返す.', () async {
      when(() => _repository.getNowPlayingMovies(page: 1))
          .thenAnswer((_) async => MovieResponse.fromJson(mockResponse));
      // print(movieResponse);
      final movieResponse = await container
          .read(movieRepositoryProvider.notifier)
          .getNowPlayingMovies(page: 1);
      expect(movieResponse, isA<MovieResponse>());
    });

    test('API呼び出しの際にエラーが出たら例外を返す', () async {
      when(() => _repository.getNowPlayingMovies(page: 1))
          .thenThrow(Exception('Failed to load movie'));

      expect(
          () => container
              .read(movieRepositoryProvider.notifier)
              .getNowPlayingMovies(page: 1),
          throwsA(isA<Exception>()));
    });
  });

  tearDownAll(() {
    container.dispose();
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
