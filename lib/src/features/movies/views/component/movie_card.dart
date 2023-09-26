import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
// import 'package:tmdb_app/src/common_widgets/RateBar.dart';
import 'package:tmdb_app/src/common_widgets/cached_image.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie/movie.dart';
import 'package:tmdb_app/src/routing/router_utils.dart';

class MovieCard extends StatelessWidget {
  final Movie item;

  const MovieCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.goNamed(AppRoute.movie.name, pathParameters: {
        "movieId": item.id.toString(),
      }),
      child: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        //TODO ここ何とかする
        child: SizedBox(
          height: 250,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  child: CachedImage(
                    imageURL: item.backdropPath != null
                        ? "https://image.tmdb.org/t/p/w500${item.backdropPath!}"
                        : "assets/images/cinema.jpeg",
                    width: double.infinity,
                    height: double.infinity,
                    isCircle: false,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: ListTile(
                  title: AutoSizeText(
                    item.title,
                    minFontSize: 12,
                    maxFontSize: 18,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("${item.voteAverage}/10"),
                      Text("(${item.voteCount})"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
