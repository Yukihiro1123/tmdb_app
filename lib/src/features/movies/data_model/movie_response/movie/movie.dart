import 'package:freezed_annotation/freezed_annotation.dart';
part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
class Movie with _$Movie {
  factory Movie({
    @JsonKey(name: 'vote_count') int? voteCount,
    required int id,
    @Default(false) bool video,
    @JsonKey(name: 'vote_average') double? voteAverage,
    required String title,
    double? popularity,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'original_language') String? originalLanguage,
    @JsonKey(name: 'original_title') String? originalTitle,
    @JsonKey(name: 'genre_ids') List<int>? genreIds,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    bool? adult,
    String? overview,
    @JsonKey(name: 'release_date') String? releaseDate,
    //detailで取得できるデータ
    // @JsonKey(name: 'belongs_to_collection')
    //     Map<String, dynamic>? collection,
    // int? budget,
    List<Map<String, dynamic>>? genres,
    String? homepage,
    // @JsonKey(name: 'imdb_id')
    //     String? imdbId,
    @JsonKey(name: 'production_companies')
    List<Map<String, dynamic>>? productionCompanies,
    @JsonKey(name: 'production_countries')
    List<Map<String, dynamic>>? productionCountries,
    int? revenue,
    // @JsonKey(name: 'spoken_languages')
    //     List<Map<String, dynamic>>? spokenLang,
    String? status,
    String? tagline,
  }) = _Movie;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}
