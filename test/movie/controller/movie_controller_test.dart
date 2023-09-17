import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tmdb_app/src/features/movies/controller/movie_controller.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie_response.dart';
import 'package:tmdb_app/src/features/movies/repository/movie_repository.dart';

class MockMovieRepository extends AutoDisposeNotifier<Dio>
    with Mock
    implements MovieRepository {}

void main() {
  group('getNowPlayingMovies', () {
    late MockMovieRepository mockMovieRepository;
    late ProviderContainer container;

    setUp(() {
      mockMovieRepository = MockMovieRepository();
      container = ProviderContainer(
        overrides: [
          movieRepositoryProvider.overrideWith(() => mockMovieRepository),
        ],
      );
    });
    tearDownAll(() {
      reset(mockMovieRepository);
      container.dispose();
    });

    test('MovieResponse型のデータを返す', () async {
      // Arrange: Prepare the test scenario
      final mockResponse = MovieResponse(
          page: 1,
          results: [],
          totalPages: 3,
          totalResults: 20); // Replace with a sample response
      when(() => container
          .read(movieRepositoryProvider.notifier)
          .getNowPlayingMovies(page: 1)).thenAnswer(
        (_) async => mockResponse,
      );
      // Act: Call the function you want to test
      MovieResponse? result;
      await container
          .read(movieControllerProvider.notifier)
          .getNowPlayingMovies(
            page: 1,
            onSuccess: (response) {
              result = response;
            },
            onError: (error) {},
          );
      expect(result, equals(mockResponse));
    });

    test('API呼び出しの際にエラーが出たら例外を返す', () async {
      // Arrange: Prepare the test scenario to simulate an exception

      when(() => container
          .read(movieRepositoryProvider.notifier)
          .getNowPlayingMovies(page: 1)).thenThrow(
        (_) async => Exception(),
      );
      // Act: Call the function you want to test
      String? result;
      await container
          .read(movieControllerProvider.notifier)
          .getNowPlayingMovies(
            page: 1,
            onSuccess: (response) {},
            onError: (error) {
              result = error;
            },
          );
      // Assert: Verify the expected behavior
      expect(result, equals('error'));
    });
  });
}
