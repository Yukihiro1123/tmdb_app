import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tmdb_app/src/common_widgets/movie_card_shimmer.dart';
import 'package:tmdb_app/src/features/movies/controller/movie_controller.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie_response.dart';
import 'package:tmdb_app/src/features/movies/views/component/custom_carousel_slider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RecommendedMovieList extends HookConsumerWidget {
  const RecommendedMovieList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context).upcoming.toString(),
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 10),
            /* Upcoming */
            ref.watch(watchUpcomingMoviesControllerProvider).when(
              error: (error, stackTrace) {
                return Center(
                  //TODO
                  child: Text(AppLocalizations.of(context).error.toString()),
                );
              },
              loading: () {
                return const MovieCardShimmer();
              },
              data: (MovieResponse movieResponse) {
                return CustomCarouselSlider(
                  movieResponse: movieResponse,
                );
              },
            ),
            Text(AppLocalizations.of(context).popular.toString(),
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 10),
            /* Popular */
            ref.watch(watchPopularMoviesControllerProvider).when(
              error: (error, stackTrace) {
                return Center(
                  //TODO
                  child: Text(AppLocalizations.of(context).error.toString()),
                );
              },
              loading: () {
                return const MovieCardShimmer();
              },
              data: (MovieResponse movieResponse) {
                return CustomCarouselSlider(
                  movieResponse: movieResponse,
                );
              },
            ),
            Text(AppLocalizations.of(context).topRated.toString(),
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 10),
            /* Top Rated */
            ref.watch(watchTopRatedMoviesControllerProvider).when(
              error: (error, stackTrace) {
                return Center(
                  //TODO
                  child: Text(AppLocalizations.of(context).error.toString()),
                );
              },
              loading: () {
                return const MovieCardShimmer();
              },
              data: (MovieResponse movieResponse) {
                return CustomCarouselSlider(
                  movieResponse: movieResponse,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
