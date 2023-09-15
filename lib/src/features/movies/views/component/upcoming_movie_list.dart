import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tmdb_app/src/common_widgets/movie_card_shimmer.dart';
import 'package:tmdb_app/src/features/movies/controller/movie_controller.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie/movie.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie_response.dart';
import 'package:tmdb_app/src/features/movies/views/component/movie_card.dart';
import 'package:tmdb_app/src/routing/router_utils.dart';
import 'package:tmdb_app/src/utils/breakpoints.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpcomingMovieList extends ConsumerWidget {
  const UpcomingMovieList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final CarouselController controller = CarouselController();
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
        return CarouselSlider(
          carouselController: controller,
          options: CarouselOptions(
            aspectRatio: screenWidth <= BreakPoints.mobileSize
                ? 1.4
                : screenWidth <= BreakPoints.tabletSize
                    ? 2.5
                    : 6,
            viewportFraction: screenWidth <= BreakPoints.mobileSize
                ? 1
                : screenWidth <= BreakPoints.tabletSize
                    ? 0.5
                    : 0.2,
            autoPlay: true,
            enlargeCenterPage: false,
          ),
          items: movieResponse.results.map(
            (Movie movie) {
              return SizedBox(
                width: double.infinity,
                child: MovieCard(item: movie),
              );
            },
          ).toList(),
        );
      },
    );
  }
}
