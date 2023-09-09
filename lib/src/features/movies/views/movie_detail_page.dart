import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tmdb_app/src/features/movies/controller/movie_controller.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie/movie.dart';

class MovieDetailPage extends HookConsumerWidget {
  final String movieId;
  const MovieDetailPage({
    super.key,
    required this.movieId,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: ref
            .watch(watchMovieDetailControllerProvider(int.parse(movieId)))
            .when(
              skipLoadingOnReload: true,
              error: (error, stackTrace) {
                print(error);
                return const Center(
                  child: Text('映画詳細情報取得時にエラーが発生しました'),
                );
              },
              loading: () => const CircularProgressIndicator(),
              data: (Movie movie) {
                print(movie);
                return Text(movie.id.toString());
              },
            ),
      ),
    );
  }
}
