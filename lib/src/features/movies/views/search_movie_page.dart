import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../controller/movie_controller.dart';
import '../data_model/movie_response/movie/movie.dart';
import 'part/movie_list.dart';

class SearchMoviePage extends HookConsumerWidget {
  const SearchMoviePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PagingController<int, Movie> pagingController =
        useMemoized(() => PagingController(firstPageKey: 1));
    final isSearching = useState(false);
    final isMounted = useIsMounted();
    final movieController = ref.watch(
      movieControllerProvider.notifier,
    );
    final searchController = useTextEditingController();

    useEffect(
      () {
        if (!isSearching.value) {
          return null;
        }
        pagingController.addPageRequestListener((pageKey) {
          movieController.searchMovie(
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
            },
          );
        });
        return pagingController.dispose;
      },
      [isSearching.value],
    );
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('TMDB'),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: SearchBar(
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
          ),
        ),
        body: !isSearching.value
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.movie, size: 30),
                    Text(AppLocalizations.of(context)!.searchByKeyword),
                  ],
                ),
              )
            : CustomScrollView(
                key: const Key('searchPageScrollView'),
                slivers: [
                  MovieList(
                    pagingController: pagingController,
                    noItemsFoundWidget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.priority_high, size: 30),
                        Text(
                          AppLocalizations.of(context)!.movieNotFound,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
