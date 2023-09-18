import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie_response.dart';

part "database.g.dart";

final databaseProvider = Provider<LocalDatabase>(
  (ref) => LocalDatabase(),
);

@DriftDatabase(tables: [MovieResponse])
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
