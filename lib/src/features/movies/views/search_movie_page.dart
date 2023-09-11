import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tmdb_app/src/common_widgets/movie_card_shimmer.dart';
import 'package:tmdb_app/src/features/movies/controller/movie_controller.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie/movie.dart';
import 'package:tmdb_app/src/features/movies/views/component/movie_card.dart';
import 'package:tmdb_app/src/routing/router_utils.dart';
import 'package:tmdb_app/src/utils/breakpoints.dart';

class SearchMoviePage extends StatefulHookConsumerWidget {
  const SearchMoviePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchMoviePageState();
}

class _SearchMoviePageState extends ConsumerState<SearchMoviePage> {
  final PagingController<int, Movie> _pagingController =
      PagingController(firstPageKey: 1);

  String? _searchTerm;
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
          .searchMovie(page: pageKey, query: _searchTerm ?? '');
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

  void _updateSearchTerm(String searchTerm) {
    _searchTerm = searchTerm;
    _pagingController.refresh();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = useTextEditingController();
    final double screenWidth = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 10),
            SearchBar(controller: searchController, trailing: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  _updateSearchTerm(searchController.text);
                },
              ),
            ]),
            const SizedBox(height: 10),
            Expanded(
              child: PagedGridView<int, Movie>(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: screenWidth <= BreakPoints.mobileSize
                      ? 1.75
                      : screenWidth <= BreakPoints.tabletSize
                          ? 1.4
                          : 1.5,
                  crossAxisSpacing: 5,
                  crossAxisCount: screenWidth <= BreakPoints.mobileSize
                      ? 1
                      : screenWidth <= BreakPoints.tabletSize
                          ? 2
                          : 4,
                ),
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Movie>(
                  noItemsFoundIndicatorBuilder: (_) {
                    return Center(
                      heightFactor: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.search, size: 50),
                          Text(
                            searchController.text.isEmpty
                                ? 'キーワードで映画を検索'
                                : '映画が見つかりません',
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        ],
                      ),
                    );
                  },
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
            ),
          ],
        ),
      ),
    );
  }
}
