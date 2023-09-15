import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tmdb_app/src/common_widgets/movie_card_shimmer.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie/movie.dart';
import 'package:tmdb_app/src/features/movies/views/component/movie_card.dart';
import 'package:tmdb_app/src/routing/router_utils.dart';
import 'package:tmdb_app/src/utils/breakpoints.dart';

class MovieList extends StatelessWidget {
  final PagingController<int, Movie> pagingController;
  final Widget noItemsFoundWidget;
  const MovieList({
    super.key,
    required this.pagingController,
    required this.noItemsFoundWidget,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    return RefreshIndicator(
      onRefresh: () => Future.sync(
        () => pagingController.refresh(),
      ),
      child: PagedGridView<int, Movie>(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: screenWidth <= BreakPoints.mobileSize
              ? 1.4
              : screenWidth <= BreakPoints.tabletSize
                  ? 1.25
                  : 1.4,
          crossAxisSpacing: 5,
          //TODO ここどうするか考える
          crossAxisCount: screenWidth <= BreakPoints.mobileSize
              ? 1
              : screenWidth <= BreakPoints.tabletSize
                  ? 2
                  : 4,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate<Movie>(
          itemBuilder: (context, item, index) {
            return MovieCard(item: item);
          },
        ),
      ),
    );
  }
}
