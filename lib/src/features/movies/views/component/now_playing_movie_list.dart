import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tmdb_app/src/features/movies/controller/movie_controller.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie/movie.dart';
import 'package:tmdb_app/src/features/movies/views/component/movie_card.dart';
import 'package:tmdb_app/src/features/movies/views/component/movie_list.dart';
import 'package:tmdb_app/src/utils/breakpoints.dart';

class NowPlayingMovieList extends HookConsumerWidget {
  const NowPlayingMovieList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PagingController<int, Movie> _pagingController =
        PagingController(firstPageKey: 1);
    final isMounted = useIsMounted();
    final usersViewModel = ref.watch(
      movieControllerProvider.notifier,
    );
    useEffect(
      () {
        _pagingController.addPageRequestListener((pageKey) {
          usersViewModel.getNowPlayingMovies(
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
    return MovieList(
      pagingController: _pagingController,
      noItemsFoundWidget: const SizedBox.shrink(),
    );
  }
}
