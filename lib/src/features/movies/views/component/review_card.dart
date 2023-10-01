import 'package:flutter/material.dart';
import '../../../../common_widgets/cached_image.dart';
import '../../data_model/review_response/review/review.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.item});
  final Review item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedImage(
        imageURL: item.authorDetails['avatar_path'],
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
