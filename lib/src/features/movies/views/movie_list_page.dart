import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tmdb_app/src/common_widgets/movie_card_shimmer.dart';
import 'package:tmdb_app/src/features/movies/controller/movie_controller.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie/movie.dart';
import 'package:tmdb_app/src/features/movies/views/component/upcoming_movie_list.dart';
import 'package:tmdb_app/src/features/movies/views/component/movie_card.dart';
import 'package:tmdb_app/src/routing/router_utils.dart';
import 'package:tmdb_app/src/common_widgets/shimmer_widget.dart';
import 'package:tmdb_app/src/utils/breakpoints.dart';

class MovieListPage extends StatefulHookConsumerWidget {
  const MovieListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MovieListPageState();
}

class _MovieListPageState extends ConsumerState<MovieListPage> {
  final PagingController<int, Movie> _pagingController =
      PagingController(firstPageKey: 1);
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await ref
          .read(movieControllerProvider.notifier)
          .getNowPlayingMovies(page: pageKey);
      final isLastPage = newItems.page == newItems.totalPages;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems.results);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems.results, nextPageKey);
      }
    } catch (error) {
      print(error);
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    //TODO sliverappbarにする
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TMDB'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '公開予定の映画',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                const UpcomingMovieList(),
                const SizedBox(height: 10),
                Text(
                  '公開中の映画',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                PagedGridView<int, Movie>(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.25,
                    crossAxisSpacing: 5,
                    //TODO ここどうするか考える
                    crossAxisCount: screenWidth <= BreakPoints.mobileSize
                        ? 1
                        : screenWidth <= BreakPoints.tabletSize
                            ? 2
                            : 3,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Movie>(
                    firstPageProgressIndicatorBuilder: (_) {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 5, //ボックス左右間のスペース
                          crossAxisCount: screenWidth <= BreakPoints.mobileSize
                              ? 1
                              : screenWidth <= BreakPoints.tabletSize
                                  ? 2
                                  : 3,
                        ),
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return const MovieCardShimmer();
                        },
                      );
                    },
                    itemBuilder: (context, item, index) {
                      return MovieCard(
                        item: item,
                        onTap: () {
                          context.goNamed(
                            AppRoute.movie.name,
                            queryParameters: {
                              "movieId": item.id.toString(),
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
