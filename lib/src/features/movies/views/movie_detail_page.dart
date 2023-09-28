import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tmdb_app/src/common_widgets/cached_image.dart';
import 'package:tmdb_app/src/common_widgets/movie_detail_shimmer.dart';
import 'package:tmdb_app/src/features/movies/controller/movie_controller.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie/movie.dart';
import 'package:tmdb_app/src/features/movies/views/part/movie_detail_page_body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              debugPrint(error.toString());
              return Center(
                child: Text(AppLocalizations.of(context)!.error),
              );
            },
            loading: () => const MovieDetailShimmer(),
            data: (Movie movie) {
              return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: MediaQuery.sizeOf(context).height * 0.3,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(
                          movie.title,
                          style: const TextStyle(fontSize: 12.0),
                        ),
                        centerTitle: true,
                        background: CachedImage(
                          imageURL: movie.backdropPath != null
                              ? "https://image.tmdb.org/t/p/w500${movie.backdropPath!}"
                              : "assets/images/cinema.jpeg",
                          width: double.infinity,
                          height: 200,
                          isCircle: false,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.5),
                            BlendMode.srcATop,
                          ),
                        ),
                      ),
                    ),
                  ];
                },
                body: MovieDetailPageBody(movie: movie),
              );
            },
          ),
    );
  }
}
