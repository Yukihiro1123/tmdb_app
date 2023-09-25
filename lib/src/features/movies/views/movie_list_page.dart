import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tmdb_app/src/features/movies/controller/movie_controller.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie/movie.dart';
import 'package:tmdb_app/src/features/movies/views/component/movie_list.dart';
import 'package:tmdb_app/src/features/movies/views/component/upcoming_movie_list.dart';

class MovieListPage extends HookConsumerWidget {
  const MovieListPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PagingController<int, Movie> pagingController =
        PagingController(firstPageKey: 1);
    final isMounted = useIsMounted();
    final movieController = ref.watch(
      movieControllerProvider.notifier,
    );
    useEffect(() {
      pagingController.addPageRequestListener((pageKey) {
        movieController.getNowPlayingMovies(
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
              debugPrint(error);
              pagingController.error = error;
            });
      });
      return () => pagingController.dispose();
    }, const []);

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text('TMDB'),
            ),
            /* Upcoming movie */
            const UpcomingMovieList(),
            MovieList(
              pagingController: pagingController,
              noItemsFoundWidget: const SizedBox.shrink(),
            )
          ],
        ),
      ),
    );
  }
}
