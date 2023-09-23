import 'package:tmdb_app/env.dart';

final String nowPlayingUrlPage1 = Uri(
  scheme: 'https',
  host: 'api.themoviedb.org',
  path: '3/movie/now_playing',
  queryParameters: {
    'language': 'ja-JP',
    'with_original_language': 'ja',
    'api_key': Env.apiKey,
    'include_adult': 'false',
    'page': '1',
  },
).toString();

final String nowPlayingUrlPage2 = Uri(
  scheme: 'https',
  host: 'api.themoviedb.org',
  path: '3/movie/now_playing',
  queryParameters: {
    'language': 'ja-JP',
    'with_original_language': 'ja',
    'api_key': Env.apiKey,
    'include_adult': 'false',
    'page': '2',
  },
).toString();

final String detailPageUrl = Uri(
  scheme: 'https',
  host: 'api.themoviedb.org',
  path: '3/movie/1083862',
  queryParameters: {
    'language': 'ja-JP',
    'api_key': Env.apiKey,
  },
).toString();

final String searchPage1Url = Uri(
  scheme: 'https',
  host: 'api.themoviedb.org',
  path: '3/search/movie',
  queryParameters: {
    'query': '犬',
    'language': 'ja-JP',
    'with_original_language': 'ja',
    'api_key': Env.apiKey,
    'include_adult': 'false',
    'page': '1',
  },
).toString();
final String searchPage2Url = Uri(
  scheme: 'https',
  host: 'api.themoviedb.org',
  path: '3/search/movie',
  queryParameters: {
    'query': '犬',
    'language': 'ja-JP',
    'with_original_language': 'ja',
    'api_key': Env.apiKey,
    'include_adult': 'false',
    'page': '2',
  },
).toString();
final String noResultUrl = Uri(
  scheme: 'https',
  host: 'api.themoviedb.org',
  path: '3/search/movie',
  queryParameters: {
    'query': 'dddd',
    'language': 'ja-JP',
    'with_original_language': 'ja',
    'api_key': Env.apiKey,
    'include_adult': 'false',
    'page': '1',
  },
).toString();

final String reviewUrl = Uri(
  scheme: 'https',
  host: 'api.themoviedb.org',
  path: '3/movie/1083862/reviews',
  queryParameters: {
    // 'language': 'ja-JP',
    'api_key': Env.apiKey,
  },
).toString();
