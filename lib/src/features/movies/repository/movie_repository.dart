import 'package:dio/dio.dart';
import 'package:tmdb_app/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tmdb_app/src/features/movies/dao/database.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie/movie.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie_response.dart';
import 'package:tmdb_app/src/features/movies/data_model/review_response/review_response.dart';

import 'package:tmdb_app/src/utils/dio/dio_provider.dart';
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
    try {
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
    } on DioException catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<MovieResponse> getUpcomingMovies() async {
    try {
      final String url = Uri(
        scheme: 'https',
        host: 'api.themoviedb.org',
        path: '3/movie/upcoming',
        queryParameters: {
          'language': 'ja-JP',
          'api_key': Env.apiKey,
          'include_adult': 'false',
          'page': '1',
        },
      ).toString();
      final response = await state.get(url);
      return MovieResponse.fromJson(response.data);
    } on DioException catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<MovieResponse> searchMovie({
    required String query,
    required int page,
  }) async {
    try {
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
      return MovieResponse.fromJson(response.data);
    } on DioException catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Movie> getMovieDetail({required int movieId}) async {
    try {
      final String url = Uri(
        scheme: 'https',
        host: 'api.themoviedb.org',
        path: '3/movie/$movieId',
        queryParameters: {
          'language': 'ja-JP',
          'api_key': Env.apiKey,
        },
      ).toString();
      final response = await state.get(url);
      return Movie.fromJson(response.data);
    } on DioException catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<ReviewResponse> getMovieReview({
    required int page,
    required int movieId,
  }) async {
    try {
      final String url = Uri(
        scheme: 'https',
        host: 'api.themoviedb.org',
        path: '3/movie/$movieId/reviews',
        queryParameters: {
          // 'language': 'ja-JP',
          'api_key': Env.apiKey,
        },
      ).toString();
      final response = await state.get(url);
      return ReviewResponse.fromJson(response.data);
    } on DioException catch (e) {
      print(e);
      rethrow;
    }
  }
}
