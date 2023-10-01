import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common_widgets/cached_image.dart';
import '../../data_model/movie_response/movie/movie.dart';
import '../component/category_chips.dart';
import 'review_list.dart';

class MovieDetailPageBody extends StatelessWidget {
  const MovieDetailPageBody({
    super.key,
    required this.movie,
  });
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const Key('singleChildScrollView'),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: AnimationLimiter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: [
                Text(
                  movie.tagline ?? '',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  movie.overview ?? '',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 10),
                CategoryChips(movie: movie),
                const SizedBox(height: 10),
                Text(
                  '${AppLocalizations.of(context)!.releaseDate}:${movie.releaseDate}',
                ),
                const SizedBox(height: 10),
                movie.productionCompanies == null ||
                        movie.productionCompanies!.isEmpty
                    ? const SizedBox.shrink()
                    : Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              AppLocalizations.of(context)!.productionCompanies,
                            ),
                          ),
                          Column(
                            children: [
                              CachedImage(
                                boxFit: BoxFit.contain,
                                imageURL: movie.productionCompanies![0]
                                    ['logo_path'],
                                width: 80,
                                height: 80,
                                isCircle: true,
                              ),
                              Text(movie.productionCompanies?[0]['name']),
                            ],
                          ),
                        ],
                      ),
                const SizedBox(height: 10),
                TextButton.icon(
                  onPressed: () {
                    _openExternalSite(movie.homepage);
                  },
                  icon: const Icon(Icons.link),
                  label: Text(AppLocalizations.of(context)!.homePage),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.review}:${movie.voteAverage}/10',
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '(${movie.voteCount}${AppLocalizations.of(context)!.reviewedBy})',
                    ),
                  ],
                ),
                Text(AppLocalizations.of(context)!.review),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.3,
                  child: ReviewList(movieId: movie.id.toString()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openExternalSite(String? homepage) async {
    if (homepage == null || homepage == '') {
      return;
    }
    final url = Uri.parse(homepage);
    if (await canLaunchUrl(url)) {
      // URLを開く
      await launchUrl(url);
    } else {
      throw Exception('Could not launch $url');
    }
  }
}
