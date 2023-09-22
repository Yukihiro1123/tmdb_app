import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tmdb_app/src/common_widgets/cached_image.dart';
import 'package:tmdb_app/src/common_widgets/movie_detail_shimmer.dart';
import 'package:tmdb_app/src/features/movies/views/component/category_chips.dart';
import 'package:tmdb_app/src/features/movies/controller/movie_controller.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie/movie.dart';
import 'package:tmdb_app/src/features/movies/views/component/review_list.dart';
import 'package:url_launcher/url_launcher.dart';
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
                child: Text(AppLocalizations.of(context)!.error.toString()),
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
                              : "https://picsum.photos/250?image=9",
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
                body: SingleChildScrollView(
                  key: const Key("singleChildScrollView"),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimationLimiter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 375),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
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
                            Text(
                                "${AppLocalizations.of(context)!.releaseDate.toString()}:${movie.releaseDate.toString()}"),
                            const SizedBox(height: 10),
                            movie.productionCompanies == null
                                ? const SizedBox.shrink()
                                : Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .productionCompanies
                                                .toString()),
                                      ),
                                      Column(
                                        children: [
                                          CachedImage(
                                            boxFit: BoxFit.contain,
                                            imageURL:
                                                "https://image.tmdb.org/t/p/w500${movie.productionCompanies![0]["logo_path"]}",
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
                              label: Text(AppLocalizations.of(context)!
                                  .homePage
                                  .toString()),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                    "${AppLocalizations.of(context)!.review.toString()}:${movie.voteAverage.toString()}/10"),
                                const SizedBox(width: 10),
                                Text(
                                    "(${movie.voteCount}${AppLocalizations.of(context)!.reviewedBy.toString()})"),
                              ],
                            ),
                            Text(AppLocalizations.of(context)!
                                .review
                                .toString()),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.3,
                              child: ReviewList(movieId: movieId),
                            ),
                          ],
                        ),
                      ),
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
