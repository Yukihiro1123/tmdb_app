import 'package:flutter/material.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie/movie.dart';

class CategoryChips extends StatelessWidget {
  final Movie movie;
  const CategoryChips({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.0,
      children: movie.genres!.map<Widget>((item) {
        return Column(
          children: [
            const SizedBox(height: 10),
            movie.genres == null
                ? const SizedBox.shrink()
                : FilterChip(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    label: Text(
                      item["name"],
                    ),
                    onSelected: (bool value) {},
                  ),
          ],
        );
      }).toList(),
    );
  }
}
