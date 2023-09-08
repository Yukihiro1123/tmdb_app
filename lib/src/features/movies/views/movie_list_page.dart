import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tmdb_app/src/features/movies/controller/movie_controller.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie/movie.dart';

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
                print(error);
                print(stackTrace);
                return Text('公開中の映画データ取得時にエラーが発生しました: $error');
              },
              loading: () => const CircularProgressIndicator(),
              data: (List<Movie> movies) {
                print(movies);
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text(movies[index].title),
                    );
                  },
                );
              })
        ],
      ),
    );
  }
}
