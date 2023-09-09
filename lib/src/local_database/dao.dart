import 'package:drift/drift.dart';

import 'database.dart';

part "dao.g.dart";

@DriftAccessor(tables: [Movie])
class MovieDao extends DatabaseAccessor<MyDatabase> with _$MovieDaoMixin {
  MovieDao(MyDatabase db) : super(db);
}
