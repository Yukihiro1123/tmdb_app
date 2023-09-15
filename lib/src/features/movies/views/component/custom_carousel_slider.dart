import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie/movie.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie_response.dart';
import 'package:tmdb_app/src/features/movies/views/component/movie_card.dart';
import 'package:tmdb_app/src/utils/breakpoints.dart';

class CustomCarouselSlider extends StatelessWidget {
  final MovieResponse movieResponse;
  const CustomCarouselSlider({super.key, required this.movieResponse});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final CarouselController controller = CarouselController();
    return CarouselSlider(
      carouselController: controller,
      options: CarouselOptions(
        aspectRatio: screenWidth <= BreakPoints.mobileSize
            ? 1.75
            : screenWidth <= BreakPoints.tabletSize
                ? 3
                : 4,
        viewportFraction: screenWidth <= BreakPoints.mobileSize
            ? 1
            : screenWidth <= BreakPoints.tabletSize
                ? 0.5
                : 0.33,
        autoPlay: false,
        enlargeCenterPage: false,
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
