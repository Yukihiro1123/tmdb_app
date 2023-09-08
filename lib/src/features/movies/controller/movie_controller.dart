import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie/movie.dart';
import 'package:tmdb_app/src/features/movies/repository/movie_repository.dart';

part 'movie_controller.g.dart';

@riverpod
class MovieController extends _$MovieController {
  @override
  AsyncValue build() {
    return const AsyncData(null);
  }
}

@riverpod
Future<List<Movie>> watchNowPlayingMoviesController(
  WatchNowPlayingMoviesControllerRef ref,
  page,
) async {
  return await ref
      .read(movieRepositoryProvider.notifier)
      .getNowPlayingMovies(page: page);
}
