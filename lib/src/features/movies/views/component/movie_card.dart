import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_app/src/common_widgets/cached_image.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie/movie.dart';
import 'package:tmdb_app/src/routing/router_utils.dart';

class MovieCard extends StatelessWidget {
  final Movie item;
  final VoidCallback onTap;

  const MovieCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.goNamed(AppRoute.movie.name, queryParameters: {
        "movieId": item.id.toString(),
      }),
      child: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        // color: Colors.black,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              child: CachedImage(
                imageURL: item.posterPath,
                width: double.infinity,
                height: 200,
                isCircle: false,
              ),
            ),
            ListTile(
              title: Text(
                item.title,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              subtitle: Row(
                children: [
                  RatingBar.builder(
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
                  ),
                  Text("(${item.voteCount})")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
