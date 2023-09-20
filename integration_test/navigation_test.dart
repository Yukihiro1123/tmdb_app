import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb_app/main.dart';
// import 'package:tmdb_app/src/features/settings/lang/controller/lang_controller.dart';
// import 'package:tmdb_app/src/features/settings/theme/controller/theme_controller.dart';
import 'package:tmdb_app/src/routing/app_router.dart';
import 'package:tmdb_app/src/utils/shared_preferences/shared_preferences_provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MockSharedPreferences extends AutoDisposeNotifier<SharedPreferences>
    with Mock
    implements SharedPreferences {}

// class MockThemeController extends AutoDisposeNotifier<bool>
//     with Mock
//     implements ThemeController {
//   @override
//   bool build() {
//     return false;
//   }
// }

// class MockLangController extends AutoDisposeNotifier<String>
//     with Mock
//     implements LangController {
//   @override
//   String build() {
//     return 'ja';
//   }
// }

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    // late MockLangController mockLangController;
    // late MockThemeController mockThemeController;
    late MockSharedPreferences mockSharedPreferences;
    late ProviderContainer container;
    setUp(() {
      // mockLangController = MockLangController();
      // mockThemeController = MockThemeController();
      mockSharedPreferences = MockSharedPreferences();
      container = ProviderContainer();
    });
    tearDown(() {
      reset(mockSharedPreferences);
      container.dispose();
    });
    testWidgets('ボトムナビゲーションから画面遷移が適切に行われる', (tester) async {
      final router = container.read(goRouterProvider);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            goRouterProvider.overrideWith((ref) => router),
            sharedPreferencesProvider
                .overrideWith((ref) => mockSharedPreferences),
            // langControllerProvider.overrideWith(() => mockLangController),
            // themeControllerProvider.overrideWith(() => mockThemeController)
          ],
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();
      expect(find.text('キーワードで映画を検索'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.home));
      await tester.pumpAndSettle();
      expect(find.text('ホーム'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();
      expect(find.text('設定'), findsOneWidget);
    });
  });
}
