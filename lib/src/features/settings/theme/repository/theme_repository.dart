import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../utils/shared_preferences/shared_preferences_provider.dart';

part 'theme_repository.g.dart';

@riverpod
class ThemeRepository extends _$ThemeRepository {
  @override
  bool build() {
    return ref.read(sharedPreferencesProvider).getBool('darkMode') ?? false;
  }

  Future<void> toggleTheme() async {
    state = !state;
    final pref = ref.read(sharedPreferencesProvider);
    await AsyncValue.guard(() async {
      await pref.setBool('darkMode', state);
    });
  }
}
