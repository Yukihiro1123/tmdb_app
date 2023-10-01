import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../controller/movie_controller.dart';
import '../data_model/movie_response/movie/movie.dart';
import 'part/movie_list.dart';
import 'part/upcoming_movie_list.dart';

class MovieListPage extends HookConsumerWidget {
  const MovieListPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PagingController<int, Movie> pagingController =
        useMemoized(() => PagingController(firstPageKey: 1));
    final isMounted = useIsMounted();
    final movieController = ref.watch(
      movieControllerProvider.notifier,
    );
    useEffect(
      () {
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
            },
          );
        });
        return pagingController.dispose;
      },
      const [],
    );

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text('TMDB'),
              centerTitle: true,
            ),
            /* Upcoming movie */
            const UpcomingMovieList(),
            /* Now Playing movie */
            MovieList(
              pagingController: pagingController,
              noItemsFoundWidget: const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
