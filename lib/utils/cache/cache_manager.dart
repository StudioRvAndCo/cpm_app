import 'package:cpm/models/base_model.dart';
import 'package:cpm/utils/cache/cache_key.dart';
import 'package:cpm/utils/platform_manager.dart';
import 'package:json_cache/json_cache.dart';
import 'package:localstorage/localstorage.dart';
import 'package:path_provider/path_provider.dart';

class CacheManager {
  static final CacheManager _singleton = CacheManager._internal();

  factory CacheManager() {
    return _singleton;
  }

  CacheManager._internal();

  late final LocalStorage _storage;
  late final JsonCache _cache;

  Future<void> init() async {
    final cachePath = PlatformManager().isWeb ? null : (await getApplicationCacheDirectory()).path;
    _storage = LocalStorage('cache', cachePath);
    _cache = JsonCacheMem(JsonCacheLocalStorage(_storage));
  }

  String _buildKey(CacheKey cacheKey, [int? id]) {
    return '${cacheKey.name}${id != null ? '_$id' : ''}';
  }

  Future<bool> contains(CacheKey cacheKey, [int? id]) async {
    return _cache.contains(_buildKey(cacheKey, id));
  }

  void set(CacheKey cacheKey, List<BaseModel> models, [int? id]) {
    final key = _buildKey(cacheKey, id);
    final data = {for (final model in models) model.id.toString(): model.toJsonCache()};

    _cache.refresh(key, data);
  }

  Future<List<Model>> get<Model extends BaseModel>(
    CacheKey cacheKey,
    Model Function(Map<String, dynamic>) constructor, [
    int? id,
  ]) async {
    assert(Model != dynamic);

    final key = _buildKey(cacheKey, id);
    final models = await _cache.value(key);

    return models == null ? [] : models.values.map((e) => constructor(e as Map<String, dynamic>)).toList();
  }

  Future<void> clear([CacheKey? cacheKey, int? id]) async {
    if (cacheKey != null) {
      await _cache.remove(_buildKey(cacheKey, id));
    } else {
      await _cache.clear();
    }
  }
}
