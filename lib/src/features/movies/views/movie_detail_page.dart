import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tmdb_app/src/common_widgets/cached_image.dart';
import 'package:tmdb_app/src/features/movies/views/component/category_chips.dart';
import 'package:tmdb_app/src/features/movies/controller/movie_controller.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie/movie.dart';
import 'package:tmdb_app/src/features/movies/views/component/review_list.dart';
import 'package:url_launcher/url_launcher.dart';

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
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.tagline ?? '',
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          movie.overview ?? '',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 10),
                        CategoryChips(movie: movie),
                        const SizedBox(height: 10),
                        Text("公開日:${movie.releaseDate.toString()}"),
                        const SizedBox(height: 10),
                        movie.productionCompanies == null
                            ? const SizedBox.shrink()
                            : Column(
                                children: [
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('制作会社'),
                                  ),
                                  Column(
                                    children: [
                                      CachedImage(
                                        boxFit: BoxFit.contain,
                                        imageURL:
                                            "https://image.tmdb.org/t/p/w500/${movie.productionCompanies![0]["logo_path"]}",
                                        width: 80,
                                        height: 80,
                                        isCircle: true,
                                      ),
                                      Text(movie.productionCompanies?[0]
                                          ["name"]),
                                    ],
                                  )
                                ],
                              ),
                        const SizedBox(height: 10),
                        TextButton.icon(
                          onPressed: () {
                            _openExternalSite(movie.homepage);
                          },
                          icon: const Icon(Icons.link),
                          label: const Text('オフィシャルサイト'),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text("評価:${movie.voteAverage.toString()}/10"),
                            const SizedBox(width: 10),
                            Text("(${movie.voteCount}人による評価)"),
                          ],
                        ),
                        const Text("レビュー"),
                        SizedBox(
                          height: 300,
                          child: ReviewList(movieId: movieId),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
    );
  }

  Future<void> _openExternalSite(String? homepage) async {
    if (homepage == null) {
      return;
    }
    final Uri url = Uri.parse(homepage);
    if (await canLaunchUrl(url)) {
      // URLを開く
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
