import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tmdb_app/src/features/movies/views/search_movie_page.dart';
import 'package:tmdb_app/src/utils/dio/dio_provider.dart';

import '../integration_test/helper/mock_response.dart';
import '../integration_test/helper/mock_url.dart';

class MockDio extends AutoDisposeNotifier<Dio> with Mock implements Dio {}

void main() {
  late MockDio mockDio;

  setUp(() {
    HttpOverrides.global = null;
    mockDio = MockDio();
  });

  tearDownAll(() {
    reset(mockDio);
  });
  group('NowPlayingMovieList', () {
    testWidgets('検索結果がヒットして、映画リストが出てくる', (widgetTester) async {
      when(() => mockDio.get(searchPage1Url)).thenAnswer(
        (_) async {
          return Response(
            statusCode: 200,
            data: mockSearchPage1Response,
            requestOptions: RequestOptions(baseUrl: searchPage1Url),
          );
        },
      );
      when(() => mockDio.get(searchPage2Url)).thenAnswer(
        (_) async {
          return Response(
            statusCode: 200,
            data: mockSearchPage2Response,
            requestOptions: RequestOptions(baseUrl: searchPage2Url),
          );
        },
      );
      await widgetTester.runAsync(() async {
        await widgetTester.pumpWidget(
          ProviderScope(
            overrides: [
              dioProvider.overrideWith((ref) => mockDio),
            ],
            child: const MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: Locale('ja'),
              home: Material(
                child: SearchMoviePage(),
              ),
            ),
          ),
        );
        await widgetTester.pumpAndSettle();
        //検索フォーム
        expect(find.byIcon(Icons.search), findsOneWidget);
        expect(find.text('キーワードで映画を検索'), findsOneWidget);
        final queryForm = find.byType(SearchBar);
        await widgetTester.enterText(queryForm, '犬');
        await widgetTester.tap(find.byIcon(Icons.search));
        await widgetTester.pumpAndSettle();
        expect(find.text('キーワードで映画を検索'), findsNothing);
        await widgetTester.pumpAndSettle();
        expect(find.text('Dog'), findsOneWidget);
        await widgetTester.drag(
          find.byType(CustomScrollView),
          const Offset(0.0, -2000),
        );
        await widgetTester.pumpAndSettle();
        expect(find.text("トッド・ソロンズの子犬物語"), findsOneWidget);
        await widgetTester.drag(
          find.byType(CustomScrollView),
          const Offset(0.0, -2000),
        );
        await widgetTester.pumpAndSettle();
        expect(find.text("天才犬ピーボ博士のタイムトラベル"), findsOneWidget);
      });
    });

    testWidgets('検索結果がヒットしなければ映画リストが出てこず、映画が見つかりませんと出る', (widgetTester) async {
      when(() => mockDio.get(noResultUrl)).thenAnswer(
        (_) async {
          return Response(
            statusCode: 200,
            data: mockNoResultResponse,
            requestOptions: RequestOptions(baseUrl: searchPage1Url),
          );
        },
      );
      await widgetTester.runAsync(() async {
        await widgetTester.pumpWidget(
          ProviderScope(
            overrides: [dioProvider.overrideWith((ref) => mockDio)],
            child: const MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: Locale('ja'),
              home: Material(
                child: SearchMoviePage(),
              ),
            ),
          ),
        );
        await widgetTester.pumpAndSettle();
        //検索フォーム
        expect(find.byIcon(Icons.search), findsOneWidget);
        expect(find.text('キーワードで映画を検索'), findsOneWidget);
        final queryForm = find.byType(SearchBar);
        await widgetTester.enterText(queryForm, 'dddd');
        await widgetTester.tap(find.byIcon(Icons.search));
        await widgetTester.pumpAndSettle();
        expect(find.text('キーワードで映画を検索'), findsNothing);
        await widgetTester.pumpAndSettle();
        expect(find.text('映画が見つかりません'), findsOneWidget);
      });
    });
  });
}
