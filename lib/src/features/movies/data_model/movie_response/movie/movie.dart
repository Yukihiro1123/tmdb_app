import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
class Movie with _$Movie {
  factory Movie({
    @JsonKey(name: 'id') required int movieId,
    required String title,
    required String overview,
    @JsonKey(name: 'genre_ids') required List<int> genreIds,
    required double popularity,
    @JsonKey(name: 'vote_average') required double voteAverage,
    @JsonKey(name: 'vote_count') required double voteCount,
    @JsonKey(name: 'release_date') required DateTime releaseDate,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @JsonKey(name: 'original_language') required String originalLang,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'adult') required bool isAdult,
    @JsonKey(name: 'video') required bool isVideo,
  }) = _Movie;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}
