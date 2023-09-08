import 'package:dio/dio.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie/movie.dart';

import 'package:tmdb_app/src/features/movies/data_model/movie_response.dart';

class MoviesRepository {
  MoviesRepository({required this.client, required this.apiKey});
  final Dio client;
  final String apiKey;

  Future<List<Movie>> getNowPlayingMovies({required int page}) async {
    final String url = Uri(
      scheme: 'https',
      host: 'api.themoviedb.org',
      path: '3/movie/now_playing',
      queryParameters: {
        'api_key': apiKey,
        'include_adult': 'false',
        'page': '$page',
      },
    ).toString();
    final response = await client.get(url);
    final movies = MovieResponse.fromJson(response.data);
    return movies.results;
  }
}
