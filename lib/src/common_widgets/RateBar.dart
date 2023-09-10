import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../features/movies/data_model/movie_response/movie/movie.dart';

class RateBar extends StatelessWidget {
  final Movie item;
  const RateBar({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemSize: 15,
      initialRating: item.voteAverage ?? 0,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 10,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}
