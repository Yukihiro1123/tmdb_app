import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

// import 'package:tmdb_app/src/common_widgets/RateBar.dart';
import '../../../../common_widgets/cached_image.dart';
import '../../../../routing/router_utils.dart';
import '../../data_model/movie_response/movie/movie.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.item,
  });
  final Movie item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.goNamed(
        AppRoute.movie.name,
        pathParameters: {
          'movieId': item.id.toString(),
        },
      ),
      child: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
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
                    imageURL: item.backdropPath,
                    width: double.infinity,
                    height: double.infinity,
                    isCircle: false,
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: AutoSizeText(
                    item.title,
                    maxFontSize: 18,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('${item.voteAverage}/10'),
                      Text('(${item.voteCount})'),
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
