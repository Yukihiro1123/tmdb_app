import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tmdb_app/src/common_widgets/RateBar.dart';
import 'package:tmdb_app/src/common_widgets/cached_image.dart';
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
      child: ref
          .watch(watchMovieDetailControllerProvider(int.parse(movieId)))
          .when(
            skipLoadingOnReload: true,
            error: (error, stackTrace) {
              print(error);
              return const Center(
                child: Text('映画詳細情報取得時にエラーが発生しました'),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (Movie movie) {
              print(movie);
              return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: 200,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(
                          movie.title,
                          style: const TextStyle(fontSize: 12.0),
                        ),
                        centerTitle: true,
                        background: CachedImage(
                          imageURL: movie.backdropPath != null
                              ? "https://image.tmdb.org/t/p/w500/${movie.backdropPath!}"
                              : "",
                          width: double.infinity,
                          height: 200,
                          isCircle: false,
                        ),
                      ),
                    ),
                  ];
                },
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("概要:\n${movie.overview}"),
                      const SizedBox(height: 10),
                      Text("公開日:${movie.releaseDate.toString()}"),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text("評価:${movie.voteAverage.toString()}/10"),
                          const SizedBox(width: 10),
                          Text("(${movie.voteCount}人による評価)"),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}
