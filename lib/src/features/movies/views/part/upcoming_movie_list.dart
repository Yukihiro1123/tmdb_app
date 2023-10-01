import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../common_widgets/movie_card_shimmer.dart';
import '../../controller/movie_controller.dart';
import '../../data_model/movie_response/movie_response.dart';
import '../component/custom_carousel_slider.dart';

class UpcomingMovieList extends ConsumerWidget {
  const UpcomingMovieList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverToBoxAdapter(
      child: ref.watch(watchUpcomingMoviesControllerProvider).when(
        error: (error, stackTrace) {
          return Center(
            child: Text(AppLocalizations.of(context)!.error),
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
    );
  }
}
