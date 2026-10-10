import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../domain/models/tuning_session.dart';
import '../services/key_value_store.dart';

/// Saved in-tune locks, newest first.
class SessionRepository extends ChangeNotifier {
  SessionRepository(this._store);

  static const storageKey = 'nadvenu.sessions.v1';
  static const _maxStored = 300;

  final KeyValueStore _store;
  List<TuningSession> _sessions = const [];

  List<TuningSession> get sessions => List.unmodifiable(_sessions);

  Future<void> load() async {
    final raw = _store.getString(storageKey);
    if (raw == null || raw.isEmpty) {
      _sessions = TuningSession.seed(DateTime.now());
      await _persist();
      return;
    }
    try {
      final json = jsonDecode(raw);
      if (json is List) {
        _sessions = [
          for (final item in json)
            if (item is Map)
              TuningSession.fromJson(item.cast<String, Object?>()),
        ];
      }
    } catch (_) {
      _sessions = TuningSession.seed(DateTime.now());
    }
    if (_sessions.isEmpty) {
      _sessions = TuningSession.seed(DateTime.now());
      await _persist();
    }
  }

  Future<void> add(TuningSession session) async {
    _sessions = [session, ..._sessions];
    if (_sessions.length > _maxStored) {
      _sessions = _sessions.sublist(0, _maxStored);
    }
    await _persist();
    notifyListeners();
  }

  Future<void> _persist() {
    return _store.setString(
      storageKey,
      jsonEncode([for (final session in _sessions) session.toJson()]),
    );
  }
}
