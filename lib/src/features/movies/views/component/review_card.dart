import 'package:flutter/material.dart';
import 'package:tmdb_app/src/common_widgets/cached_image.dart';
import 'package:tmdb_app/src/features/movies/data_model/review_response/review/review.dart';

class ReviewCard extends StatelessWidget {
  final Review item;
  const ReviewCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedImage(
        imageURL: item.authorDetails["avatar_path"] != null
            ? "https://image.tmdb.org/t/p/w500${item.authorDetails["avatar_path"]}"
            : "assets/images/cinema.jpeg",
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
    );
  }
}
