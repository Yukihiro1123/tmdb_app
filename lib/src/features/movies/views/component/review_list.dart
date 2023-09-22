import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tmdb_app/src/common_widgets/cached_image.dart';
import 'package:tmdb_app/src/features/movies/controller/movie_controller.dart';
import 'package:tmdb_app/src/features/movies/data_model/review_response/review/review.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReviewList extends HookConsumerWidget {
  final String movieId;
  const ReviewList({
    super.key,
    required this.movieId,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PagingController<int, Review> pagingController =
        PagingController(firstPageKey: 1);
    final isMounted = useIsMounted();
    final usersViewModel = ref.watch(
      movieControllerProvider.notifier,
    );
    useEffect(
      () {
        pagingController.addPageRequestListener((pageKey) {
          usersViewModel.getMovieReview(
              movieId: int.parse(movieId),
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
      const [],
    );
    return RefreshIndicator(
      onRefresh: () => Future.sync(
        () => pagingController.refresh(),
      ),
      child: PagedListView<int, Review>(
        shrinkWrap: true,
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate<Review>(
          noItemsFoundIndicatorBuilder: (_) {
            return Center(
              heightFactor: 10,
              child: Text(
                AppLocalizations.of(context)!.reviewNotFound,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          },
          itemBuilder: (context, item, index) {
            return AnimationConfiguration.staggeredList(
              delay: const Duration(milliseconds: 375),
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: ListTile(
                    leading: CachedImage(
                      imageURL: item.authorDetails["avatar_path"] != null
                          ? "https://image.tmdb.org/t/p/w500${item.authorDetails["avatar_path"]}"
                          : "https://picsum.photos/250?image=9",
                      width: 50,
                      height: 50,
                      isCircle: true,
                    ),
                    title: Text(
                      item.author,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    subtitle: Text(
                      item.content,
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
