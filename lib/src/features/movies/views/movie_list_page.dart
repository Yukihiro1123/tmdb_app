import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tmdb_app/src/features/movies/views/component/now_playing_movie_list.dart';
import 'package:tmdb_app/src/features/movies/views/component/upcoming_movie_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MovieListPage extends HookConsumerWidget {
  const MovieListPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TMDB'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   AppLocalizations.of(context).upcoming,
              //   style: Theme.of(context).textTheme.titleMedium,
              // ),
              // const SizedBox(height: 10),
              // const UpcomingMovieList(),
              const SizedBox(height: 10),
              Text(
                AppLocalizations.of(context).nowPlaying,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              const Expanded(child: NowPlayingMovieList()),
            ],
          ),
        ),
      ),
    );
  }
}
