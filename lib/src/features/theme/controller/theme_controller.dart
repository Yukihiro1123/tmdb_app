import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tmdb_app/src/features/theme/repository/theme_repository.dart';

part 'theme_controller.g.dart';

@riverpod
class ThemeController extends _$ThemeController {
  @override
  bool build() {
    return ref.watch(themeRepositoryProvider);
  }

  Future<void> toggleTheme() async {
    return await ref.read(themeRepositoryProvider.notifier).toggleTheme();
  }
}
