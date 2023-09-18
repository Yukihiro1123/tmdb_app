import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie/movie.dart';

class MapConverter extends TypeConverter<Map<String, dynamic>, String> {
  @override
  Map<String, dynamic> fromSql(String fromDb) {
    return Map<String, dynamic>.from(json.decode(fromDb));
  }

  @override
  String toSql(Map<String, dynamic> value) {
    return json.encode(value);
  }
}

class MovieConverter extends TypeConverter<Movie, String> {
  const MovieConverter();

  @override
  Movie fromSql(String fromDb) {
    return Movie.fromJson(json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String toSql(Movie value) {
    return json.encode(value.toJson());
  }
}
