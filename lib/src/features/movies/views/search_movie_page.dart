import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tmdb_app/src/features/movies/controller/movie_controller.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie/movie.dart';
import 'package:tmdb_app/src/features/movies/views/component/movie_card.dart';
import 'package:tmdb_app/src/features/movies/views/component/movie_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tmdb_app/src/utils/breakpoints.dart';

class SearchMoviePage extends HookConsumerWidget {
  const SearchMoviePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PagingController<int, Movie> _pagingController =
        PagingController(firstPageKey: 1);
    final isMounted = useIsMounted();
    final usersViewModel = ref.watch(
      movieControllerProvider.notifier,
    );
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final TextEditingController searchController = useTextEditingController();

    useEffect(
      () {
        _pagingController.addPageRequestListener((pageKey) {
          usersViewModel.searchMovie(
              query: searchController.text,
              page: pageKey,
              onSuccess: (data) {
                if (isMounted()) {
                  if (data.page == data.totalPages) {
                    _pagingController.appendLastPage(data.results);
                  } else {
                    _pagingController.appendPage(data.results, pageKey + 1);
                  }
                }
              },
              onError: (error) {
                // print(error);
                _pagingController.error = error;
              });
        });
        return () => _pagingController.dispose();
      },
      const [],
    );

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 10),
            SearchBar(
              controller: searchController,
              trailing: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _pagingController.refresh();
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => Future.sync(
                  () => _pagingController.refresh(),
                ),
                child: PagedGridView(
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
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Movie>(
                    noItemsFoundIndicatorBuilder: (context) {
                      return Center(
                          child: Text(
                        searchController.text.isEmpty
                            ? AppLocalizations.of(context).searchByKeyword
                            : AppLocalizations.of(context).movieNotFound,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ));
                    },
                    itemBuilder: (context, item, index) {
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        columnCount: screenWidth <= BreakPoints.mobileSize
                            ? 1
                            : screenWidth <= BreakPoints.tabletSize
                                ? 2
                                : 4,
                        child: SlideAnimation(
                          child: FadeInAnimation(
                            child: MovieCard(
                              item: item,
                              onTap: () {},
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
