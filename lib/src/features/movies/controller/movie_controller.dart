import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie/movie.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie_response.dart';
import 'package:tmdb_app/src/features/movies/repository/movie_repository.dart';

part 'movie_controller.g.dart';

@riverpod
class MovieController extends _$MovieController {
  @override
  AsyncValue build() {
    return const AsyncData(null);
  }

  Future<MovieResponse> getNowPlayingMovies({
    required int page,
  }) async {
    try {
      return await ref
          .read(movieRepositoryProvider.notifier)
          .getNowPlayingMovies(page: page);
    } catch (e) {
      rethrow;
    }
  }
}

@riverpod
Future<MovieResponse> watchNowPlayingMoviesController(
  WatchNowPlayingMoviesControllerRef ref,
  page,
) async {
  return await ref
      .read(movieRepositoryProvider.notifier)
      .getNowPlayingMovies(page: page);
}

@riverpod
Future<Movie> watchMovieDetailController(
  WatchMovieDetailControllerRef ref,
  int movieId,
) async {
  return await ref
      .read(movieRepositoryProvider.notifier)
      .getMovieDetail(movieId: movieId);
}
