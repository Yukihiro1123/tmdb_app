import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../common_widgets/cached_image.dart';
import '../../../common_widgets/movie_detail_shimmer.dart';
import '../controller/movie_controller.dart';
import '../data_model/movie_response/movie/movie.dart';
import 'part/movie_detail_page_body.dart';

class MovieDetailPage extends HookConsumerWidget {
  const MovieDetailPage({
    super.key,
    required this.movieId,
  });
  final String movieId;
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
                          style: const TextStyle(fontSize: 12),
                        ),
                        centerTitle: true,
                        background: CachedImage(
                          imageURL: movie.backdropPath,
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
