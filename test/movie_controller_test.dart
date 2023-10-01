import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sembast/sembast.dart';
import 'package:tmdb_app/src/features/movies/controller/movie_controller.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie_response.dart';
import 'package:tmdb_app/src/features/movies/repository/movie_repository.dart';

import '../integration_test/helper/mock_response.dart';

class MockMovieRepository extends AutoDisposeNotifier<StoreRef>
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
      when(
        () => container
            .read(movieRepositoryProvider.notifier)
            .getNowPlayingMovies(page: 1),
      ).thenAnswer(
        (_) async => MovieResponse.fromJson(mockNowPlayingResponsePage1),
      );
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
      expect(result, MovieResponse.fromJson(mockNowPlayingResponsePage1));
    });

    test('API呼び出しの際にエラーが出たら例外を返す', () async {
      when(
        () => container
            .read(movieRepositoryProvider.notifier)
            .getNowPlayingMovies(page: 1),
      ).thenThrow(
        (_) async => Exception(),
      );
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
      expect(result, 'error');
    });
  });
}
