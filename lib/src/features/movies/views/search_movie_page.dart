import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tmdb_app/src/features/movies/controller/movie_controller.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie/movie.dart';
import 'package:tmdb_app/src/routing/router_utils.dart';

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
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SearchBar(controller: searchController, trailing: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  _updateSearchTerm(searchController.text);
                },
              ),
            ]),
            Expanded(
              child: PagedListView<int, Movie>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Movie>(
                  itemBuilder: (context, item, index) => ListTile(
                    title: Text(item.title),
                    onTap: () {
                      context.goNamed(AppRoute.movie.name, queryParameters: {
                        "movieId": item.id.toString(),
                      });
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
