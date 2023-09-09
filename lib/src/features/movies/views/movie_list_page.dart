import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tmdb_app/src/features/movies/controller/movie_controller.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie_response.dart';

class MovieListPage extends HookConsumerWidget {
  const MovieListPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = useState(1);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ref.watch(watchNowPlayingMoviesControllerProvider(page.value)).when(
              error: (error, stackTrace) {
                return Text('公開中の映画データ取得時にエラーが発生しました: $error');
              },
              skipLoadingOnReload: true,
              skipLoadingOnRefresh: true,
              loading: () => const CircularProgressIndicator(),
              data: (MovieResponse response) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: response.results.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(response.results[index].title),
                      );
                    },
                  ),
                );
              })
        ],
      ),
    );
  }
}
