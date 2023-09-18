import 'database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part "local_database.g.dart";

@riverpod
LocalDatabase localDatabase(LocalDatabaseRef ref) {
  final localDatabase = LocalDatabase();
  return localDatabase;
}
