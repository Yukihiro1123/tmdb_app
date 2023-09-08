import 'package:go_router/go_router.dart';
import 'package:tmdb_app/src/routing/router_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tmdb_app/src/features/movies/views/movie_list_page.dart';
part 'app_router.g.dart';

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
      debugLogDiagnostics: false,
      initialLocation: AppRoute.movies.path,
      routes: [
        GoRoute(
          path: AppRoute.movies.path,
          name: AppRoute.movies.name,
          pageBuilder: (context, state) {
            return NoTransitionPage(
              key: state.pageKey,
              child: MovieListPage(key: state.pageKey),
            );
          },
        ),
      ]);
}
