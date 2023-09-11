import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tmdb_app/src/features/movies/controller/movie_controller.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie/movie.dart';
import 'package:tmdb_app/src/features/movies/views/component/movie_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final hasSearched = useState(false);
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
                    hasSearched.value = true;
                    _updateSearchTerm(searchController.text);
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: MovieList(
                pagingController: _pagingController,
                noItemsFoundWidget: Center(
                  heightFactor: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.search, size: 50),
                      Text(
                        hasSearched.value == false
                            ? AppLocalizations.of(context).searchByKeyword
                            : AppLocalizations.of(context).movieNotFound,
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    ],
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
