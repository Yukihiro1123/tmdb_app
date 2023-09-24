import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cache_manager_provider.g.dart';

@riverpod
CacheManager cachedManager(CachedManagerRef ref) {
  return DefaultCacheManager();
}
