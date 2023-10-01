import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb_app/src/features/settings/theme/repository/theme_repository.dart';
import 'package:tmdb_app/src/utils/shared_preferences/shared_preferences_provider.dart';

class MockSharedPreferences extends AutoDisposeNotifier<SharedPreferences>
    with Mock
    implements SharedPreferences {}

void main() {
  late MockSharedPreferences sharedPreferences;
  late ProviderContainer container;

  setUp(() async {
    sharedPreferences = MockSharedPreferences();
    container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWith((ref) => sharedPreferences),
      ],
    );
  });

  tearDownAll(() {
    reset(sharedPreferences);
    container.dispose();
  });

  group('toggle theme', () {
    test('最初のテーマはfalse, 切り替え後にtrueになる', () async {
      const actual = false;
      final firstState = container.read(themeRepositoryProvider.notifier).state;
      expect(firstState, actual);
      //切り替え後trueになる
      await container.read(themeRepositoryProvider.notifier).toggleTheme();
      final secondState =
          container.read(themeRepositoryProvider.notifier).state;
      expect(secondState, !actual);
      //さらに切り替え後falseになる
      await container.read(themeRepositoryProvider.notifier).toggleTheme();
      final thirdState = container.read(themeRepositoryProvider.notifier).state;
      expect(thirdState, actual);
    });
  });
}
