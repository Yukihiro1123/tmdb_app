import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tmdb_app/src/features/movies/views/component/now_playing_movie_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tmdb_app/src/features/movies/views/recommended_movie_list.dart';

class MovieListPage extends HookConsumerWidget {
  const MovieListPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('TMDB'),
            centerTitle: true,
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  text: AppLocalizations.of(context)!.nowPlaying,
                ),
                Tab(
                  text: AppLocalizations.of(context)!.recommend,
                ),
              ],
            ),
          ),
          body: const Padding(
            padding: EdgeInsets.all(8.0),
            child: TabBarView(
              children: [
                NowPlayingMovieList(),
                RecommendedMovieList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
