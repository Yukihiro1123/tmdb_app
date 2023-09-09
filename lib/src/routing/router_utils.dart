enum AppRoute {
  movies,
  search,
}

extension AppRouteExtention on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.movies:
        return '/movies';
      case AppRoute.search:
        return '/search';
    }
  }
}
