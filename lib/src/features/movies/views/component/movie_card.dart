import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_app/src/common_widgets/RateBar.dart';
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
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              child: CachedImage(
                imageURL: item.backdropPath != null
                    ? "https://image.tmdb.org/t/p/w500/${item.backdropPath!}"
                    : "",
                width: double.infinity,
                height: 200,
                isCircle: false,
              ),
            ),
            ListTile(
              title: Text(
                item.title,
              ),
              subtitle: Row(
                children: [
                  Text("${item.voteAverage}/10"),
                  // RateBar(item: item),
                  Text("(${item.voteCount})"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
