import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tmdb_app/src/common_widgets/movie_card_shimmer.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie/movie.dart';
import 'package:tmdb_app/src/features/movies/views/component/movie_card.dart';
import 'package:tmdb_app/src/utils/breakpoints.dart';

class MovieList extends ConsumerWidget {
  final PagingController<int, Movie> pagingController;
  final Widget noItemsFoundWidget;
  const MovieList({
    super.key,
    required this.pagingController,
    required this.noItemsFoundWidget,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    return PagedSliverGrid<int, Movie>(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 500.0,
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 5.0,
        childAspectRatio: 1.5,
      ),
      pagingController: pagingController,
      builderDelegate: PagedChildBuilderDelegate<Movie>(
        noItemsFoundIndicatorBuilder: (context) {
          return noItemsFoundWidget;
        },
        firstPageProgressIndicatorBuilder: (context) {
          return const MovieCardShimmer();
        },
        newPageProgressIndicatorBuilder: (context) {
          return const MovieCardShimmer();
        },
        itemBuilder: (context, item, index) {
          return AnimationConfiguration.staggeredGrid(
            duration: const Duration(milliseconds: 75),
            columnCount: getColumnCount(screenWidth),
            position: index,
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: MovieCard(item: item),
              ),
            ),
          );
        },
      ),
    );
  }
}
