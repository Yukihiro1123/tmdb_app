import 'package:drift/drift.dart' hide JsonKey;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie/movie.dart';
import 'package:tmdb_app/src/features/movies/database/type_converter.dart';

part 'movie_response.freezed.dart';
part 'movie_response.g.dart';

@UseRowClass(MovieResponse)
class MovieResponses extends Table {
  IntColumn get page => integer()();
  IntColumn get totalResults => integer()();
  IntColumn get totalPages => integer()();
  TextColumn get preferences => text().map(const MovieConverter())();
}

@freezed
class MovieResponse with _$MovieResponse {
  factory MovieResponse({
    required int page,
    required List<Movie> results,
    @JsonKey(name: 'total_results') required int totalResults,
    @JsonKey(name: 'total_pages') required int totalPages,
    @Default([]) List<String> errors,
  }) = _MovieResponse;

  factory MovieResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseFromJson(json);
}
