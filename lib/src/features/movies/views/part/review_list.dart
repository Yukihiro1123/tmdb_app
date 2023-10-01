import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../controller/movie_controller.dart';
import '../../data_model/review_response/review/review.dart';
import '../component/review_card.dart';

class ReviewList extends HookConsumerWidget {
  const ReviewList({
    super.key,
    required this.movieId,
  });
  final String movieId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pagingController = PagingController<int, Review>(firstPageKey: 1);
    final isMounted = useIsMounted();
    final movieController = ref.watch(
      movieControllerProvider.notifier,
    );
    useEffect(
      () {
        pagingController.addPageRequestListener((pageKey) {
          movieController.getMovieReview(
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
            },
          );
        });
        return pagingController.dispose;
      },
      const [],
    );
    return RefreshIndicator(
      onRefresh: () => Future.sync(
        pagingController.refresh,
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
              delay: const Duration(milliseconds: 75),
              position: index,
              duration: const Duration(milliseconds: 75),
              child: SlideAnimation(
                verticalOffset: 50,
                child: FadeInAnimation(
                  child: ReviewCard(item: item),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
