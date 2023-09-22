import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tmdb_app/src/features/movies/controller/movie_controller.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie/movie.dart';
import 'package:tmdb_app/src/features/movies/views/component/movie_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchMoviePage extends HookConsumerWidget {
  const SearchMoviePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PagingController<int, Movie> pagingController =
        PagingController(firstPageKey: 1);
    final isSearching = useState(false);
    final isMounted = useIsMounted();
    final usersViewModel = ref.watch(
      movieControllerProvider.notifier,
    );
    final TextEditingController searchController = useTextEditingController();

    useEffect(
      () {
        if (!isSearching.value) {
          return null;
        }
        pagingController.addPageRequestListener((pageKey) {
          usersViewModel.searchMovie(
              query: searchController.text,
              page: pageKey,
              onSuccess: (data) {
                if (isMounted()) {
                  if (data.page == data.totalPages) {
                    pagingController.appendLastPage(data.results);
                  } else {
                    pagingController.appendPage(data.results, pageKey + 1);
                  }
                }
              },
              onError: (error) {
                // debugPrint(error);
                pagingController.error = error;
              });
        });
        return () => pagingController.dispose();
      },
      [isSearching.value],
    );
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            const SizedBox(height: 10),
            SearchBar(
              controller: searchController,
              trailing: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (searchController.text.isEmpty) {
                      return;
                    }
                    isSearching.value = true;
                    pagingController.refresh();
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            isSearching.value == false
                ? Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.movie, size: 30),
                        Text(AppLocalizations.of(context)!.searchByKeyword),
                      ],
                    ),
                  )
                : Expanded(
                    child: MovieList(
                    pagingController: pagingController,
                    noItemsFoundWidget: Align(
                      heightFactor: 8,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          const Icon(Icons.priority_high, size: 30),
                          Text(
                            AppLocalizations.of(context)!.movieNotFound,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}
