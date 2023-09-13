import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:tmdb_app/src/features/movies/dao/type_converter.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie/movie.dart';

import 'dao.dart';

part "database.g.dart";

class MovieRecord extends Table {
  TextColumn get movieId => text()();
  TextColumn get title => text()();
  TextColumn get overview => text()();
  TextColumn get genreIds => text()();
  RealColumn get voteAverage => real()();
  IntColumn get voteCount => integer()();
  TextColumn get releaseDate => text()();
  TextColumn get backdropPath => text()();
  TextColumn get originalLanguage => text()();
  TextColumn get posterPath => text()();
  BoolColumn get isAdult => boolean()();
  BoolColumn get isVideo => boolean()();
  TextColumn get genres => text().map(MapConverter())();
  TextColumn get homepage => text()();
  TextColumn get productionCompanies => text().map(MapConverter())();
  TextColumn get productionCountries => text().map(MapConverter())();
  IntColumn get revenue => integer()();
  TextColumn get status => text()();
  TextColumn get tagline => text()();
}

class MovieResponseRecord extends Table {
  IntColumn get page => integer()();
  IntColumn get totalResults => integer()();
  IntColumn get totalPages => integer()();
  TextColumn get preferences => text().map(const MovieConverter())();
}

@DriftDatabase(tables: [MovieResponseRecord], daos: [MovieDao])
class LocalDatabase extends _$LocalDatabase {
  //create functionでopenConnectionを作成
  LocalDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    //データベースのパスにnews.dbというデータベースを作成
    final file = File(path.join(dbFolder.path, 'movie.db'));
    return NativeDatabase(file);
  });
}
