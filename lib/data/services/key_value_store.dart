import 'package:shared_preferences/shared_preferences.dart';

/// Tiny string store so repositories can be tested without plugins.
abstract class KeyValueStore {
  String? getString(String key);
  Future<void> setString(String key, String value);
}

class MemoryStore implements KeyValueStore {
  final Map<String, String> _values = {};

  @override
  String? getString(String key) => _values[key];

  @override
  Future<void> setString(String key, String value) async {
    _values[key] = value;
  }
}

class PreferencesStore implements KeyValueStore {
  PreferencesStore(this._prefs);

  final SharedPreferences _prefs;

  @override
  String? getString(String key) => _prefs.getString(key);

  @override
  Future<void> setString(String key, String value) {
    return _prefs.setString(key, value);
  }
}
