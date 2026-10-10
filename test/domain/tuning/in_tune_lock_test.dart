import 'package:flutter_test/flutter_test.dart';
import 'package:nadvenu_flute_tuner/domain/tuning/in_tune_lock.dart';

void main() {
  group('InTuneLock', () {
    test('fires once after the note holds in tune', () {
      final lock = InTuneLock();
      final start = DateTime(2026, 10, 10, 10, 30);
      expect(
        lock.update(
          at: start,
          inTune: true,
          noteId: 'C4',
          confidence: 0.9,
        ),
        isFalse,
      );
      expect(
        lock.update(
          at: start.add(const Duration(milliseconds: 1499)),
          inTune: true,
          noteId: 'C4',
          confidence: 0.9,
        ),
        isFalse,
      );
      expect(
        lock.update(
          at: start.add(const Duration(milliseconds: 1500)),
          inTune: true,
          noteId: 'C4',
          confidence: 0.9,
        ),
        isTrue,
      );
      expect(
        lock.update(
          at: start.add(const Duration(seconds: 3)),
          inTune: true,
          noteId: 'C4',
          confidence: 0.95,
        ),
        isFalse,
      );
    });

    test('a new note or a flat reading restarts the hold', () {
      final lock = InTuneLock();
      final start = DateTime(2026, 10, 10, 10);
      lock.update(at: start, inTune: true, noteId: 'C4', confidence: 0.9);
      expect(
        lock.update(
          at: start.add(const Duration(seconds: 2)),
          inTune: true,
          noteId: 'D4',
          confidence: 0.9,
        ),
        isFalse,
      );
      expect(
        lock.update(
          at: start.add(const Duration(seconds: 4)),
          inTune: false,
          noteId: 'D4',
          confidence: 0.9,
        ),
        isFalse,
      );
      expect(
        lock.update(
          at: start.add(const Duration(seconds: 5)),
          inTune: true,
          noteId: 'D4',
          confidence: 0.4,
        ),
        isFalse,
      );
    });
  });
}
