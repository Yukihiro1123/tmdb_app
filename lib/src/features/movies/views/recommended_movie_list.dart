import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tmdb_app/src/features/movies/views/component/upcoming_movie_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RecommendedMovieList extends HookConsumerWidget {
  const RecommendedMovieList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context).upcoming,
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 10),
            const UpcomingMovieList(),
            Text(AppLocalizations.of(context).upcoming,
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 10),
            const UpcomingMovieList(),
            Text(AppLocalizations.of(context).upcoming,
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 10),
            const UpcomingMovieList(),
          ],
        ),
      ),
    );
  }
}
