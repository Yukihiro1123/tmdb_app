import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb_app/main.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie/movie.dart';
import 'package:tmdb_app/src/routing/app_router.dart';
import 'package:tmdb_app/src/utils/shared_preferences/shared_preferences_provider.dart';

class MockSharedPreferences extends AutoDisposeNotifier<SharedPreferences>
    with Mock
    implements SharedPreferences {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    late MockSharedPreferences mockSharedPreferences;
    late ProviderContainer container;
    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
      container = ProviderContainer();
    });
    tearDown(() {
      reset(mockSharedPreferences);
      container.dispose();
    });
    testWidgets('統合テスト', (tester) async {
      final router = container.read(goRouterProvider);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            goRouterProvider.overrideWith((ref) => router),
            sharedPreferencesProvider
                .overrideWith((ref) => mockSharedPreferences),
          ],
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();
      //映画検索テスト
      // await tester.tap(find.byIcon(Icons.search));
      // await tester.pumpAndSettle();
      // //キーワードにあった映画が出てくる
      // expect(find.text('キーワードで映画を検索'), findsOneWidget);
      // expect(find.byType(SearchBar), findsOneWidget);
      // await tester.enterText(find.byType(SearchBar), '犬');
      // await tester.pumpAndSettle();
      // await tester.tap(find.byIcon(Icons.search).at(0));
      // await tester.pumpAndSettle();
      // expect(find.text('Dog'), findsOneWidget);
      // //スクロール
      // await tester.drag(
      //   find.byType(PagedGridView<int, Movie>),
      //   const Offset(0.0, -5000),
      // );

      // await tester.pumpAndSettle();
      // expect(find.text('トッド・ソロンズの子犬物語'), findsOneWidget);
      // await tester.pumpAndSettle();
      // //２ページ目の最初
      // expect(find.text('ジョー・ダート 華麗なる負け犬の伝説'), findsOneWidget);
      // //Not Found
      // await tester.enterText(find.byType(SearchBar), '');
      // await tester.pumpAndSettle();
      // await tester.tap(find.byIcon(Icons.search).at(0));
      // await tester.pumpAndSettle();
      // expect(find.text('映画が見つかりません'), findsOneWidget);
      //ホーム画面に遷移テスト
      await tester.tap(find.byIcon(Icons.home));
      await tester.pumpAndSettle();
      expect(find.text('ホーム'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();
      expect(find.text('設定'), findsOneWidget);
      expect(find.text("言語"), findsOneWidget);
      //ダークモード切り替えテスト
      expect(find.text("ダークモード"), findsOneWidget);
      await tester.tap(find.text("ダークモード"));
      await tester.pumpAndSettle();
      expect(
        Theme.of(tester.element(find.text("ダークモード"))).brightness,
        equals(Brightness.dark),
      );
      //言語切り替えテスト
      await tester.tap(find.text("言語"));
      await tester.pumpAndSettle();
      expect(find.text("英語"), findsOneWidget);
      await tester.tap(find.text("英語"));
      await tester.pumpAndSettle();
      expect(find.text("Japanese"), findsOneWidget);
      await tester.tap(find.byIcon(Icons.arrow_back_ios));
      await tester.pumpAndSettle();
      expect(find.text("Language"), findsOneWidget);
      //ライトモード切り替えテスト
      expect(find.text("dark theme"), findsOneWidget);
      await tester.tap(find.text("dark theme"));
      await tester.pumpAndSettle();
      expect(
        Theme.of(tester.element(find.text("dark theme"))).brightness,
        equals(Brightness.light),
      );
      //言語切り替えテスト
      await tester.tap(find.text("Language"));
      await tester.pumpAndSettle();
      expect(find.text("Japanese"), findsOneWidget);
      await tester.tap(find.text("Japanese"));
      await tester.pumpAndSettle();
      expect(find.text("日本語"), findsOneWidget);
      await tester.tap(find.byIcon(Icons.arrow_back_ios));
      await tester.pumpAndSettle();
      expect(find.text("言語"), findsOneWidget);
    });
  });
}
