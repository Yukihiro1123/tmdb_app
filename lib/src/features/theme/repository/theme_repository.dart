import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb_app/src/utils/shared_preferences/shared_preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'theme_repository.g.dart';

@riverpod
class ThemeRepository extends _$ThemeRepository {
  @override
  SharedPreferences build() {
    return ref.read(sharedPreferencesProvider);
  }

  bool getTheme() {
    return state.getBool("darkMode") ?? false;
  }

  void toggleTheme() async {
    final bool currentTheme = getTheme();
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool("darkMode", !currentTheme);
  }
}
