//一旦ここまで作ってflutter packages pub run build_runner build
import 'package:drift/drift.dart';

import 'database.dart';

part "dao.g.dart";

@DriftAccessor(tables: [MovieResponseRecord])
class MovieDao extends DatabaseAccessor<LocalDatabase> with _$MovieDaoMixin {
  MovieDao(LocalDatabase db) : super(db);
  //データベースを空にする
  Future clearDB() => delete(movieResponseRecord).go();
  //そこから挿入 2行以上insertしたい場合はbatchを使う
  Future insertDB(MovieResponseRecordData response) async {
    await into(movieResponseRecord).insert(response);
  }

  //読み込み
  Future<List<MovieResponseRecordData>> get movieResponseRecordFromDB =>
      select(movieResponseRecord).get();

  //以上3つを1つのトランザクションとする
  Future<List<MovieResponseRecordData>> insertAndReadMovieFromDB(
          MovieResponseRecordData movieResponseRecord) =>
      transaction(() async {
        await clearDB();
        await insertDB(movieResponseRecord);
        return await movieResponseRecordFromDB;
      });
}
