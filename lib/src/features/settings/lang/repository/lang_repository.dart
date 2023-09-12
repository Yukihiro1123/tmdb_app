import 'package:tmdb_app/src/utils/shared_preferences/shared_preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'lang_repository.g.dart';

@riverpod
class LangRepository extends _$LangRepository {
  @override
  String build() {
    return ref.read(sharedPreferencesProvider).getString("lang") ?? 'ja';
  }

  Future<void> changeLang({required String lang}) async {
    state = lang;
    final pref = ref.read(sharedPreferencesProvider);
    AsyncValue.guard(() async {
      await pref.setString("lang", state);
    });
  }
}
