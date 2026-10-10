import 'dart:math' as math;

import '../../domain/models/pitch_frame.dart';
import '../../domain/tuning/tuning_math.dart';

/// A built-in tone that wanders flat, settles in tune, then drifts sharp.
///
/// The browser build uses this whenever the microphone is blocked, so the
/// needle, chart, and session lock still have something to follow.
class DemoPitchEngine {
  const DemoPitchEngine();

  static const cycle = Duration(seconds: 12);

  /// Sa, Re, Ga, Ma, Pa — shuddha degrees as semitone offsets.
  static const _degrees = <int>[0, 2, 4, 5, 7];

  PitchFrame frame({
    required Duration elapsed,
    required double a4Hz,
    required int saPitchClass,
    DateTime? at,
  }) {
    final cycleMs = cycle.inMilliseconds;
    final span = cycleMs * _degrees.length;
    final pos = elapsed.inMilliseconds % span;
    final noteIndex = pos ~/ cycleMs;
    final local = (pos % cycleMs) / cycleMs;
    final midi = 60 + saPitchClass + _degrees[noteIndex];
    final target = TuningMath.midiToFrequency(midi, a4Hz);
    final cents = _cents(local);
    final hz = target * math.pow(2, cents / 1200).toDouble();
    final confidence = (1 - (cents.abs() / 90)).clamp(0.62, 0.98).toDouble();
    final seconds = elapsed.inMilliseconds / 1000;
    final waveform = List<double>.generate(64, (i) {
      final t = seconds + i / 48;
      final carrier = hz / 70;
      return (0.72 * math.sin(2 * math.pi * carrier * t) +
              0.2 * math.sin(4 * math.pi * carrier * t))
          .clamp(-1.0, 1.0)
          .toDouble();
    });
    final spectrum = List<double>.generate(48, (i) {
      final freq = 70 * math.pow(2, i / 8).toDouble();
      var mag = 0.0;
      for (var h = 1; h <= 6; h++) {
        final harmonic = hz * h;
        final dist = (freq - harmonic).abs() / (harmonic * 0.07 + 18);
        mag += (1 / h) * math.exp(-dist * dist);
      }
      return mag;
    });
    return PitchFrame(
      frequencyHz: hz,
      confidence: confidence,
      waveform: waveform,
      spectrum: spectrum,
      demo: true,
      at: at ?? DateTime.now(),
    );
  }

  double _cents(double local) {
    if (local < 0.25) {
      return -32 + (local / 0.25) * 22;
    }
    if (local < 0.40) {
      return -10 + ((local - 0.25) / 0.15) * 10;
    }
    if (local < 0.62) {
      return math.sin((local - 0.40) * 24) * 1.4;
    }
    if (local < 0.85) {
      return ((local - 0.62) / 0.23) * 28;
    }
    return 28 - ((local - 0.85) / 0.15) * 12;
  }
}
