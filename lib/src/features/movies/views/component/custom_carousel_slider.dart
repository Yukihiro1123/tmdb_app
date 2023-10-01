import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../utils/breakpoints.dart';
import '../../data_model/movie_response/movie/movie.dart';
import '../../data_model/movie_response/movie_response.dart';
import 'movie_card.dart';

class CustomCarouselSlider extends StatelessWidget {
  const CustomCarouselSlider({super.key, required this.movieResponse});
  final MovieResponse movieResponse;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final controller = CarouselController();
    return CarouselSlider(
      carouselController: controller,
      options: CarouselOptions(
        aspectRatio: screenWidth <= BreakPoints.mobileSize
            ? 1.5
            : screenWidth <= BreakPoints.tabletSize
                ? 3
                : 4,
        viewportFraction: screenWidth <= BreakPoints.mobileSize
            ? 0.8
            : screenWidth <= BreakPoints.tabletSize
                ? 0.5
                : 0.33,
      ),
      items: movieResponse.results.map(
        (Movie movie) {
          return SizedBox(
            width: double.infinity,
            child: MovieCard(item: movie),
          );
        },
      ).toList(),
    );
  }
}
