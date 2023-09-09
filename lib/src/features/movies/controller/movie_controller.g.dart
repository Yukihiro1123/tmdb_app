// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$watchNowPlayingMoviesControllerHash() =>
    r'f388223a0f210a2dc86d7a124c5b151ae78034d1';

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

/// See also [watchNowPlayingMoviesController].
@ProviderFor(watchNowPlayingMoviesController)
const watchNowPlayingMoviesControllerProvider =
    WatchNowPlayingMoviesControllerFamily();

/// See also [watchNowPlayingMoviesController].
class WatchNowPlayingMoviesControllerFamily
    extends Family<AsyncValue<MovieResponse>> {
  /// See also [watchNowPlayingMoviesController].
  const WatchNowPlayingMoviesControllerFamily();

  /// See also [watchNowPlayingMoviesController].
  WatchNowPlayingMoviesControllerProvider call(
    dynamic page,
  ) {
    return WatchNowPlayingMoviesControllerProvider(
      page,
    );
  }

  @override
  WatchNowPlayingMoviesControllerProvider getProviderOverride(
    covariant WatchNowPlayingMoviesControllerProvider provider,
  ) {
    return call(
      provider.page,
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
  String? get name => r'watchNowPlayingMoviesControllerProvider';
}

/// See also [watchNowPlayingMoviesController].
class WatchNowPlayingMoviesControllerProvider
    extends AutoDisposeFutureProvider<MovieResponse> {
  /// See also [watchNowPlayingMoviesController].
  WatchNowPlayingMoviesControllerProvider(
    dynamic page,
  ) : this._internal(
          (ref) => watchNowPlayingMoviesController(
            ref as WatchNowPlayingMoviesControllerRef,
            page,
          ),
          from: watchNowPlayingMoviesControllerProvider,
          name: r'watchNowPlayingMoviesControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$watchNowPlayingMoviesControllerHash,
          dependencies: WatchNowPlayingMoviesControllerFamily._dependencies,
          allTransitiveDependencies:
              WatchNowPlayingMoviesControllerFamily._allTransitiveDependencies,
          page: page,
        );

  WatchNowPlayingMoviesControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.page,
  }) : super.internal();

  final dynamic page;

  @override
  Override overrideWith(
    FutureOr<MovieResponse> Function(
            WatchNowPlayingMoviesControllerRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WatchNowPlayingMoviesControllerProvider._internal(
        (ref) => create(ref as WatchNowPlayingMoviesControllerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        page: page,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<MovieResponse> createElement() {
    return _WatchNowPlayingMoviesControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WatchNowPlayingMoviesControllerProvider &&
        other.page == page;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WatchNowPlayingMoviesControllerRef
    on AutoDisposeFutureProviderRef<MovieResponse> {
  /// The parameter `page` of this provider.
  dynamic get page;
}

class _WatchNowPlayingMoviesControllerProviderElement
    extends AutoDisposeFutureProviderElement<MovieResponse>
    with WatchNowPlayingMoviesControllerRef {
  _WatchNowPlayingMoviesControllerProviderElement(super.provider);

  @override
  dynamic get page => (origin as WatchNowPlayingMoviesControllerProvider).page;
}

String _$watchMovieDetailControllerHash() =>
    r'abb282f983edd64aa2909d93ae9fb1c3a5e70f64';

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

String _$movieControllerHash() => r'eac11d275886d1e436a63a50267331af9d4857e0';

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
