// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$watchNowPlayingMoviesControllerHash() =>
    r'e9f4349041c40bf0123b64912312d550aa433814';

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
    extends Family<AsyncValue<List<Movie>>> {
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
    extends AutoDisposeFutureProvider<List<Movie>> {
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
    FutureOr<List<Movie>> Function(WatchNowPlayingMoviesControllerRef provider)
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
  AutoDisposeFutureProviderElement<List<Movie>> createElement() {
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
    on AutoDisposeFutureProviderRef<List<Movie>> {
  /// The parameter `page` of this provider.
  dynamic get page;
}

class _WatchNowPlayingMoviesControllerProviderElement
    extends AutoDisposeFutureProviderElement<List<Movie>>
    with WatchNowPlayingMoviesControllerRef {
  _WatchNowPlayingMoviesControllerProviderElement(super.provider);

  @override
  dynamic get page => (origin as WatchNowPlayingMoviesControllerProvider).page;
}

String _$movieControllerHash() => r'a4afc05fa55b8f911d08d4b86de135c36e34aa62';

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
