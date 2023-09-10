import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tmdb_app/src/common_widgets/cached_image.dart';
import 'package:tmdb_app/src/common_widgets/review_card_shimmer.dart';
import 'package:tmdb_app/src/features/movies/controller/movie_controller.dart';
import 'package:tmdb_app/src/features/movies/data_model/review_response/review/review.dart';

class ReviewList extends StatefulHookConsumerWidget {
  final String movieId;
  const ReviewList({super.key, required this.movieId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReviewListState();
}

class _ReviewListState extends ConsumerState<ReviewList> {
  final PagingController<int, Review> _pagingController =
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
          .getMovieReview(page: pageKey, movieId: int.parse(widget.movieId));
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

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: PagedListView<int, Review>(
        shrinkWrap: true,
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Review>(
          firstPageProgressIndicatorBuilder: (_) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return const ReviewCardShimmer();
              },
            );
          },
          itemBuilder: (context, item, index) {
            return ListTile(
              leading: CachedImage(
                imageURL: item.authorDetails["avatar_path"] != null
                    ? "https://image.tmdb.org/t/p/w500/${item.authorDetails["avatar_path"]}"
                    : "",
                width: 50,
                height: 50,
                isCircle: true,
              ),
              title: Text(item.author),
              subtitle: Text(
                item.content,
                overflow: TextOverflow.ellipsis,
              ),
            );
          },
        ),
      ),
    );
  }
}
