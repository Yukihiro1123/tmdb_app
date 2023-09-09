import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import 'dao.dart';

part "database.g.dart";

class Movie extends Table {
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
}

@DriftDatabase(tables: [Movie], daos: [MovieDao])
class MyDatabase extends _$MyDatabase {
  //create functionでopenConnectionを作成
  MyDatabase() : super(_openConnection());

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
