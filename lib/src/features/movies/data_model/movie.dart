import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
class Movie with _$Movie {
  factory Movie({
    required List<String> movieId,
    required String title,
    required String overview,
    required List<String> genreIds,
    required double popularity,
    required double voteAverage,
    required int voteCount,
    required DateTime releaseDate,
    required String backdropPath,
    required String originalLang,
    required double posterPath,
    required bool isAdult,
    required bool isVideo,
  }) = _Movie;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}
