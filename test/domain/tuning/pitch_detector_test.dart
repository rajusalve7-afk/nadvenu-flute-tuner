import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:nadvenu_flute_tuner/domain/tuning/pitch_detector.dart';

void main() {
  const detector = PitchDetector();

  List<double> sine(double hz, {int sampleRate = 44100, int length = 4096}) {
    return List<double>.generate(length, (i) {
      return math.sin(2 * math.pi * hz * i / sampleRate);
    });
  }

  group('PitchDetector', () {
    test('finds A4 and C4 in a pure tone', () {
      final a4 = detector.detect(sine(440), 44100, rmsGate: 0.001);
      expect(a4, isNotNull);
      expect(a4!.frequencyHz, closeTo(440, 1.5));
      expect(a4.confidence, greaterThan(0.5));

      final c4 = detector.detect(sine(261.63), 44100, rmsGate: 0.001);
      expect(c4, isNotNull);
      expect(c4!.frequencyHz, closeTo(261.63, 1.5));
    });

    test('silence stays silent', () {
      final quiet = List<double>.filled(4096, 0);
      expect(detector.detect(quiet, 44100), isNull);
    });
  });
}
