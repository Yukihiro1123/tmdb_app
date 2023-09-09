import 'package:dio/dio.dart';
import 'package:tmdb_app/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie_response.dart';

import 'package:tmdb_app/src/utils/dio_provider.dart';
part 'movie_repository.g.dart';

@riverpod
class MovieRepository extends _$MovieRepository {
  @override
  Dio build() {
    return ref.read(dioProvider);
  }

  Future<MovieResponse> getNowPlayingMovies({
    required int page,
  }) async {
    final String url = Uri(
      scheme: 'https',
      host: 'api.themoviedb.org',
      path: '3/movie/now_playing',
      queryParameters: {
        'language': 'ja-JP',
        'with_original_language': 'ja',
        'api_key': Env.apiKey,
        'include_adult': 'false',
        'page': '$page',
      },
    ).toString();
    final response = await state.get(url);
    return MovieResponse.fromJson(response.data);
  }

  Future<MovieResponse> searchMovie({
    required String query,
    required int page,
  }) async {
    final String url = Uri(
      scheme: 'https',
      host: 'api.themoviedb.org',
      path: '3/search/movie',
      queryParameters: {
        'query': query,
        'language': 'ja-JP',
        'with_original_language': 'ja',
        'api_key': Env.apiKey,
        'include_adult': 'false',
        'page': '$page',
      },
    ).toString();
    final response = await state.get(url);
    print(response.data);
    return MovieResponse.fromJson(response.data);
  }
}
