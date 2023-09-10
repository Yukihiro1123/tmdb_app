enum AppRoute {
  movies,
  movie,
  search,
}

extension AppRouteExtention on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.movies:
        return '/movies';
      case AppRoute.movie:
        return 'movieId';
      case AppRoute.search:
        return '/search';
    }
  }
}
