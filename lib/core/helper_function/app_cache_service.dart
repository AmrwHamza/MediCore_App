import 'package:hive_flutter/adapters.dart';

class AppCacheService {
  static const String _savedAtKey = '__savedAtMs__';

  final Box<dynamic> _box;

  AppCacheService(this._box);

  Future<void> put(String key, Map<String, dynamic> json) async {
    final payload = <String, dynamic>{
      ...json,
      _savedAtKey: DateTime.now().millisecondsSinceEpoch,
    };
    await _box.put(key, payload);
  }

  Future<Map<String, dynamic>?> get(
    String key, {
    Duration? maxAge,
    bool allowStale = false,
  }) async {
    final raw = _box.get(key);
    if (raw is! Map) return null;

    final savedAtMs = raw[_savedAtKey];
    if (savedAtMs is! int) return null;

    final age = DateTime.now().difference(
      DateTime.fromMillisecondsSinceEpoch(savedAtMs),
    );

    if (maxAge != null && age > maxAge && !allowStale) return null;

    final copy = Map<String, dynamic>.from(raw);
    copy.remove(_savedAtKey);
    return copy;
  }

  Future<void> remove(String key) => _box.delete(key);

  Future<void> clear() => _box.clear();
}
