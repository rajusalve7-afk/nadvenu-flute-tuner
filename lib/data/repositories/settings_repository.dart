import 'dart:convert';

import '../../domain/models/app_settings.dart';
import '../services/key_value_store.dart';

/// Single source of truth for tuner preferences.
class SettingsRepository {
  SettingsRepository(this._store);

  static const storageKey = 'nadvenu.settings.v1';

  final KeyValueStore _store;
  AppSettings _current = AppSettings.defaults();

  AppSettings get current => _current;

  Future<void> load() async {
    final raw = _store.getString(storageKey);
    if (raw == null || raw.isEmpty) return;
    try {
      final json = jsonDecode(raw);
      if (json is Map<String, Object?>) {
        _current = AppSettings.fromJson(json);
      } else if (json is Map) {
        _current = AppSettings.fromJson(json.cast<String, Object?>());
      }
    } catch (_) {
      _current = AppSettings.defaults();
    }
  }

  Future<void> save(AppSettings settings) async {
    _current = settings;
    await _store.setString(storageKey, jsonEncode(settings.toJson()));
  }
}
