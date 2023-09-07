enum AppRoute {
  movies,
}

extension AppRouteExtention on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.movies:
        return '/movies';
    }
  }
}
