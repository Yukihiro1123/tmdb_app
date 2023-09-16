import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie/movie.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie_response.dart';
import 'package:tmdb_app/src/features/movies/data_model/review_response/review_response.dart';
import 'package:tmdb_app/src/features/movies/repository/movie_repository.dart';

part 'movie_controller.g.dart';

@riverpod
class MovieController extends _$MovieController {
  @override
  AsyncValue build() {
    return const AsyncData(null);
  }

  Future<void> getNowPlayingMovies({
    required int page,
    required void Function(MovieResponse) onSuccess,
    required void Function(String) onError,
  }) async {
    try {
      final response = await ref
          .read(movieRepositoryProvider.notifier)
          .getNowPlayingMovies(page: page);
      onSuccess(response);
    } catch (e) {
      onError('error');
    }
  }

  Future<void> getMovieReview({
    required int movieId,
    required int page,
    required void Function(ReviewResponse) onSuccess,
    required void Function(String) onError,
  }) async {
    try {
      final response = await ref
          .read(movieRepositoryProvider.notifier)
          .getMovieReview(movieId: movieId, page: page);
      onSuccess(response);
    } catch (e) {
      onError('error');
    }
  }

  Future<void> searchMovie({
    required String query,
    required int page,
    required void Function(MovieResponse) onSuccess,
    required void Function(String) onError,
  }) async {
    try {
      final response = await ref
          .read(movieRepositoryProvider.notifier)
          .searchMovie(query: query, page: page);
      onSuccess(response);
    } catch (e) {
      onError('error');
    }
  }
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

@riverpod
Future<MovieResponse> watchUpcomingMoviesController(
    WatchUpcomingMoviesControllerRef ref) async {
  return await ref.read(movieRepositoryProvider.notifier).getUpcomingMovies();
}

@riverpod
Future<MovieResponse> watchPopularMoviesController(
    WatchPopularMoviesControllerRef ref) async {
  return await ref.read(movieRepositoryProvider.notifier).getPopularMovies();
}

@riverpod
Future<MovieResponse> watchTopRatedMoviesController(
    WatchTopRatedMoviesControllerRef ref) async {
  return await ref.read(movieRepositoryProvider.notifier).getTopRatedMovies();
}
