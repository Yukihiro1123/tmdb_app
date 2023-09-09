//一旦ここまで作ってflutter packages pub run build_runner build
import 'package:drift/drift.dart';

import 'database.dart';

part "dao.g.dart";

@DriftAccessor(tables: [MovieRecords])
class MovieDao extends DatabaseAccessor<LocalDatabase> with _$MovieDaoMixin {
  MovieDao(LocalDatabase db) : super(db);
  //データベースを空にする
  Future clearDB() => delete(movieRecords).go();
  //そこから挿入 2行以上insertしたい場合はbatchを使う
  Future insertDB(List<MovieRecord> articles) async {
    await batch((batch) {
      batch.insertAll(movieRecords, articles);
    });
  }

  //読み込み
  Future<List<MovieRecord>> get articlesFromDB => select(movieRecords).get();

  //以上3つを1つのトランザクションとする
  Future<List<MovieRecord>> insertAndReadMovieFromDB(
          List<MovieRecord> articles) =>
      transaction(() async {
        await clearDB();
        await insertDB(articles);
        return await articlesFromDB;
      });
}
