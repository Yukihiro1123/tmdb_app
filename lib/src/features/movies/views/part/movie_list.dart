import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../common_widgets/movie_card_shimmer.dart';
import '../../../../utils/breakpoints.dart';
import '../../data_model/movie_response/movie/movie.dart';
import '../component/movie_card.dart';

class MovieList extends ConsumerWidget {
  const MovieList({
    super.key,
    required this.pagingController,
    required this.noItemsFoundWidget,
  });
  final PagingController<int, Movie> pagingController;
  final Widget noItemsFoundWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return PagedSliverGrid<int, Movie>(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 500,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 1.5,
      ),
      pagingController: pagingController,
      builderDelegate: PagedChildBuilderDelegate<Movie>(
        noItemsFoundIndicatorBuilder: (context) {
          return noItemsFoundWidget;
        },
        firstPageProgressIndicatorBuilder: (context) {
          return SizedBox(
            height: 300,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: getColumnCount(screenWidth),
              ),
              shrinkWrap: true,
              itemCount: 8,
              itemBuilder: (context, index) {
                return const MovieCardShimmer();
              },
            ),
          );
        },
        newPageProgressIndicatorBuilder: (context) {
          return const MovieCardShimmer();
        },
        itemBuilder: (context, item, index) {
          return AnimationConfiguration.staggeredGrid(
            duration: const Duration(milliseconds: 30),
            columnCount: getColumnCount(screenWidth),
            position: index,
            child: SlideAnimation(
              verticalOffset: 50,
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
