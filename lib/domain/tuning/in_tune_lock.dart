/// Fires once when the same note stays in tune long enough to save.
class InTuneLock {
  DateTime? _since;
  String? _noteId;
  bool _fired = false;

  bool update({
    required DateTime at,
    required bool inTune,
    required String noteId,
    required double confidence,
    Duration hold = const Duration(milliseconds: 1500),
    double minConfidence = 0.72,
  }) {
    if (!inTune || confidence < minConfidence) {
      _reset();
      return false;
    }
    if (_noteId != noteId) {
      _noteId = noteId;
      _since = at;
      _fired = false;
      return false;
    }
    if (_fired || _since == null) return false;
    if (at.difference(_since!) >= hold) {
      _fired = true;
      return true;
    }
    return false;
  }

  void _reset() {
    _since = null;
    _noteId = null;
    _fired = false;
  }
}
