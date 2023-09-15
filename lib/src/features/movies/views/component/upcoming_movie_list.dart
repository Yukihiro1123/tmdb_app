import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tmdb_app/src/common_widgets/movie_card_shimmer.dart';
import 'package:tmdb_app/src/features/movies/controller/movie_controller.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie_response.dart';
import 'package:tmdb_app/src/features/movies/views/component/custom_carousel_slider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpcomingMovieList extends ConsumerWidget {
  const UpcomingMovieList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(watchUpcomingMoviesControllerProvider).when(
      error: (error, stackTrace) {
        return Center(
          //TODO
          child: Text(AppLocalizations.of(context).upcomingMovieError),
        );
      },
      loading: () {
        return const MovieCardShimmer();
      },
      data: (MovieResponse movieResponse) {
        return CustomCarouselSlider(movieResponse: movieResponse);
      },
    );
  }
}
