import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:tmdb_app/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie/movie.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie_response.dart';
import 'package:tmdb_app/src/features/movies/data_model/review_response/review_response.dart';
import 'package:tmdb_app/src/utils/database/database_provider.dart';

import 'package:tmdb_app/src/utils/dio/dio_provider.dart';
part 'movie_repository.g.dart';

@riverpod
class MovieRepository extends _$MovieRepository {
  @override
  StoreRef build() {
    return StoreRef.main();
  }

  Future<MovieResponse> insertAndReadMovieFromDB({
    required String storePath,
    required Map<String, dynamic> response,
  }) async {
    //delete
    await state.record(storePath).delete(ref.read(databaseProvider));
    //insert
    await state.record(storePath).add(ref.read(databaseProvider), response);
    //read
    final result = await state.record(storePath).get(ref.read(databaseProvider))
        as Map<String, dynamic>;
    debugPrint('data cleaned, saved and read from db');
    return MovieResponse.fromJson(result);
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
      debugPrint("now playing movie page$page");
      final response = await ref.read(dioProvider).get(url);
      if (response.statusCode == 200) {
        return await insertAndReadMovieFromDB(
          storePath: "nowPlaying",
          response: response.data,
        );
      } else {
        throw Exception('Failed to load movie');
      }
    } on DioException catch (e) {
      debugPrint(e.toString());
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
      final response = await ref.read(dioProvider).get(url);
      return MovieResponse.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<MovieResponse> getPopularMovies() async {
    try {
      final String url = Uri(
        scheme: 'https',
        host: 'api.themoviedb.org',
        path: '3/movie/popular',
        queryParameters: {
          'language': 'ja-JP',
          'api_key': Env.apiKey,
          'include_adult': 'false',
          'page': '1',
        },
      ).toString();
      final response = await ref.read(dioProvider).get(url);
      return MovieResponse.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<MovieResponse> getTopRatedMovies() async {
    try {
      final String url = Uri(
        scheme: 'https',
        host: 'api.themoviedb.org',
        path: '3/movie/top_rated',
        queryParameters: {
          'language': 'ja-JP',
          'api_key': Env.apiKey,
          'include_adult': 'false',
          'page': '1',
        },
      ).toString();
      final response = await ref.read(dioProvider).get(url);
      return MovieResponse.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<MovieResponse> searchMovie({
    required String query,
    required int page,
  }) async {
    try {
      debugPrint("search page:${page.toString()}");
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
      final response = await ref.read(dioProvider).get(url);
      return MovieResponse.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint(e.toString());
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
      final response = await ref.read(dioProvider).get(url);
      return Movie.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint(e.toString());
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
      final response = await ref.read(dioProvider).get(url);
      return ReviewResponse.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
