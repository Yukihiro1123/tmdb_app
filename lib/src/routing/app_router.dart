import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_app/src/features/movies/views/movie_detail_page.dart';
import 'package:tmdb_app/src/features/movies/views/search_movie_page.dart';
import 'package:tmdb_app/src/features/navigation/bottom_navigation.dart';
import 'package:tmdb_app/src/features/settings/view/set_language_page.dart';
import 'package:tmdb_app/src/features/settings/view/settings_page.dart';
import 'package:tmdb_app/src/routing/router_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tmdb_app/src/features/movies/views/movie_list_page.dart';
part 'app_router.g.dart';

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  // このGlobalKeyは、GoRouterのインスタンスを取得するために必要です。
  final rootNavigatorKey = GlobalKey<NavigatorState>();
// このGlobalKeyは、各タブのGoRouterインスタンスを取得するために必要です。
  final sectionNavigatorKey = GlobalKey<NavigatorState>();
  return GoRouter(
      navigatorKey: rootNavigatorKey,
      debugLogDiagnostics: false,
      initialLocation: AppRoute.movies.path,
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            // カスタムシェル（BottomNavigationBar など）を実装したウィジェットを返します。
            // ステートフルな方法で他のブランチにナビゲートできるように、 // [StatefulNavigationShell] が渡されます。
            return BottomNavigation(navigationShell);
          },
          branches: [
            StatefulShellBranch(
              navigatorKey: sectionNavigatorKey,
              // このブランチルートを追加する
              // 各ルートとそのサブルート (利用可能な場合) 例: feed/uuid/details
              routes: <RouteBase>[
                GoRoute(
                    path: AppRoute.movies.path,
                    name: AppRoute.movies.name,
                    pageBuilder: (context, state) {
                      return NoTransitionPage(
                        key: state.pageKey,
                        child: MovieListPage(key: state.pageKey),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: AppRoute.movie.path,
                        name: AppRoute.movie.name,
                        pageBuilder: (context, state) {
                          final String movieId =
                              state.pathParameters['movieId']!;
                          return NoTransitionPage(
                            key: state.pageKey,
                            child: MovieDetailPage(
                              key: state.pageKey,
                              movieId: movieId,
                            ),
                          );
                        },
                      ),
                    ]),
              ],
            ),
            StatefulShellBranch(
              // このブランチルートを追加する
              // 各ルートとそのサブルート (利用可能な場合) 例: feed/uuid/details
              routes: <RouteBase>[
                GoRoute(
                  path: AppRoute.search.path,
                  name: AppRoute.search.name,
                  pageBuilder: (context, state) {
                    return NoTransitionPage(
                      key: state.pageKey,
                      child: SearchMoviePage(key: state.pageKey),
                    );
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              // このブランチルートを追加する
              // 各ルートとそのサブルート (利用可能な場合) 例: feed/uuid/details
              routes: <RouteBase>[
                GoRoute(
                  path: AppRoute.settings.path,
                  name: AppRoute.settings.name,
                  pageBuilder: (context, state) {
                    return NoTransitionPage(
                      key: state.pageKey,
                      child: SettingsPage(key: state.pageKey),
                    );
                  },
                  routes: <RouteBase>[
                    GoRoute(
                      path: AppRoute.language.path,
                      name: AppRoute.language.name,
                      pageBuilder: (context, state) {
                        return NoTransitionPage(
                          key: state.pageKey,
                          child: SetLanguagePage(key: state.pageKey),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ]);
}
