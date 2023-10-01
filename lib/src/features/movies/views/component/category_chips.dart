import 'package:flutter/material.dart';
import '../../data_model/movie_response/movie/movie.dart';

class CategoryChips extends StatelessWidget {
  const CategoryChips({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
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
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    label: Text(
                      item['name'],
                    ),
                    onSelected: (bool value) {},
                  ),
          ],
        );
      }).toList(),
    );
  }
}
