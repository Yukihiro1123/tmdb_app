import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../repository/theme_repository.dart';

part 'theme_controller.g.dart';

@riverpod
class ThemeController extends _$ThemeController {
  @override
  bool build() {
    return ref.watch(themeRepositoryProvider);
  }

  Future<void> toggleTheme() async {
    await AsyncValue.guard(() {
      return ref.read(themeRepositoryProvider.notifier).toggleTheme();
    });
  }
}
