import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tmdb_app/src/features/movies/controller/movie_controller.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie/movie.dart';
import 'package:tmdb_app/src/features/movies/views/component/movie_list.dart';
import 'package:tmdb_app/src/features/movies/views/component/upcoming_movie_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      if (mounted) {
        final isLastPage = newItems.page == newItems.totalPages;
        if (isLastPage) {
          _pagingController.appendLastPage(newItems.results);
        } else {
          final nextPageKey = pageKey + 1;
          _pagingController.appendPage(newItems.results, nextPageKey);
        }
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
                  AppLocalizations.of(context).upcoming,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                const UpcomingMovieList(),
                const SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context).nowPlaying,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                MovieList(
                  pagingController: _pagingController,
                  noItemsFoundWidget: Center(
                    heightFactor: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.search, size: 50),
                        Text(
                          AppLocalizations.of(context).movieNotFound,
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      ],
                    ),
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
