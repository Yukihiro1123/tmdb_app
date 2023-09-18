// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$watchMovieDetailControllerHash() =>
    r'abb282f983edd64aa2909d93ae9fb1c3a5e70f64';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [watchMovieDetailController].
@ProviderFor(watchMovieDetailController)
const watchMovieDetailControllerProvider = WatchMovieDetailControllerFamily();

/// See also [watchMovieDetailController].
class WatchMovieDetailControllerFamily extends Family<AsyncValue<Movie>> {
  /// See also [watchMovieDetailController].
  const WatchMovieDetailControllerFamily();

  /// See also [watchMovieDetailController].
  WatchMovieDetailControllerProvider call(
    int movieId,
  ) {
    return WatchMovieDetailControllerProvider(
      movieId,
    );
  }

  @override
  WatchMovieDetailControllerProvider getProviderOverride(
    covariant WatchMovieDetailControllerProvider provider,
  ) {
    return call(
      provider.movieId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'watchMovieDetailControllerProvider';
}

/// See also [watchMovieDetailController].
class WatchMovieDetailControllerProvider
    extends AutoDisposeFutureProvider<Movie> {
  /// See also [watchMovieDetailController].
  WatchMovieDetailControllerProvider(
    int movieId,
  ) : this._internal(
          (ref) => watchMovieDetailController(
            ref as WatchMovieDetailControllerRef,
            movieId,
          ),
          from: watchMovieDetailControllerProvider,
          name: r'watchMovieDetailControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$watchMovieDetailControllerHash,
          dependencies: WatchMovieDetailControllerFamily._dependencies,
          allTransitiveDependencies:
              WatchMovieDetailControllerFamily._allTransitiveDependencies,
          movieId: movieId,
        );

  WatchMovieDetailControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.movieId,
  }) : super.internal();

  final int movieId;

  @override
  Override overrideWith(
    FutureOr<Movie> Function(WatchMovieDetailControllerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WatchMovieDetailControllerProvider._internal(
        (ref) => create(ref as WatchMovieDetailControllerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        movieId: movieId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Movie> createElement() {
    return _WatchMovieDetailControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WatchMovieDetailControllerProvider &&
        other.movieId == movieId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, movieId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WatchMovieDetailControllerRef on AutoDisposeFutureProviderRef<Movie> {
  /// The parameter `movieId` of this provider.
  int get movieId;
}

class _WatchMovieDetailControllerProviderElement
    extends AutoDisposeFutureProviderElement<Movie>
    with WatchMovieDetailControllerRef {
  _WatchMovieDetailControllerProviderElement(super.provider);

  @override
  int get movieId => (origin as WatchMovieDetailControllerProvider).movieId;
}

String _$watchUpcomingMoviesControllerHash() =>
    r'47264b8066b9ab3cff060d5db317f3ae4ddc9095';

/// See also [watchUpcomingMoviesController].
@ProviderFor(watchUpcomingMoviesController)
final watchUpcomingMoviesControllerProvider =
    AutoDisposeFutureProvider<MovieResponse>.internal(
  watchUpcomingMoviesController,
  name: r'watchUpcomingMoviesControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$watchUpcomingMoviesControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WatchUpcomingMoviesControllerRef
    = AutoDisposeFutureProviderRef<MovieResponse>;
String _$watchPopularMoviesControllerHash() =>
    r'5ec49976eb584efa71724a3a3993bec780044425';

/// See also [watchPopularMoviesController].
@ProviderFor(watchPopularMoviesController)
final watchPopularMoviesControllerProvider =
    AutoDisposeFutureProvider<MovieResponse>.internal(
  watchPopularMoviesController,
  name: r'watchPopularMoviesControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$watchPopularMoviesControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WatchPopularMoviesControllerRef
    = AutoDisposeFutureProviderRef<MovieResponse>;
String _$watchTopRatedMoviesControllerHash() =>
    r'825aa2665e9bc53328eb6feb53156aa3d125dbc8';

/// See also [watchTopRatedMoviesController].
@ProviderFor(watchTopRatedMoviesController)
final watchTopRatedMoviesControllerProvider =
    AutoDisposeFutureProvider<MovieResponse>.internal(
  watchTopRatedMoviesController,
  name: r'watchTopRatedMoviesControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$watchTopRatedMoviesControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WatchTopRatedMoviesControllerRef
    = AutoDisposeFutureProviderRef<MovieResponse>;
String _$movieControllerHash() => r'540aa7d8d898ac43a10dcdef00cff92d4d8e3747';

/// See also [MovieController].
@ProviderFor(MovieController)
final movieControllerProvider =
    AutoDisposeNotifierProvider<MovieController, AsyncValue<dynamic>>.internal(
  MovieController.new,
  name: r'movieControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$movieControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MovieController = AutoDisposeNotifier<AsyncValue<dynamic>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
