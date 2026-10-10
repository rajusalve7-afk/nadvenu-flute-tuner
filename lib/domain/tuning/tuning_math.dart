import 'dart:math' as math;

import '../models/app_settings.dart';
import '../models/swara.dart';
import '../models/tuning_result.dart';

/// Equal-tempered pitch math, plus optional just-intonation cents.
///
/// A4 is MIDI 69. Octave numbers follow the scientific convention
/// (C4 is MIDI 60, middle C).
class TuningMath {
  const TuningMath._();

  static const pitchNames = <String>[
    'C',
    'C#',
    'D',
    'D#',
    'E',
    'F',
    'F#',
    'G',
    'G#',
    'A',
    'A#',
    'B',
  ];

  /// Just ratios for semitone offsets 0–11 above Sa.
  static const justRatios = <double>[
    1 / 1, // Sa
    16 / 15, // komal Re
    9 / 8, // Re
    6 / 5, // komal Ga
    5 / 4, // Ga
    4 / 3, // Ma
    45 / 32, // tivra Ma
    3 / 2, // Pa
    8 / 5, // komal Dha
    5 / 3, // Dha
    9 / 5, // komal Ni
    15 / 8, // Ni
  ];

  static double midiToFrequency(int midi, double a4Hz) {
    return a4Hz * math.pow(2, (midi - 69) / 12).toDouble();
  }

  static double frequencyToMidi(double hz, double a4Hz) {
    return 69 + 12 * (math.log(hz / a4Hz) / math.ln2);
  }

  static int nearestMidi(double hz, double a4Hz) {
    return frequencyToMidi(hz, a4Hz).round();
  }

  static double centsBetween(double hz, double targetHz) {
    return 1200 * (math.log(hz / targetHz) / math.ln2);
  }

  static int octaveOf(int midi) => (midi ~/ 12) - 1;

  static int pitchClassOf(int midi) => midi % 12;

  static String noteLabel(int midi) =>
      '${pitchNames[pitchClassOf(midi)]}${octaveOf(midi)}';

  static int normalizeDegree(int pitchClass, int saPitchClass) {
    return (pitchClass - saPitchClass) % 12;
  }

  static Swara swaraFor({required int midi, required int saPitchClass}) {
    final degree = normalizeDegree(pitchClassOf(midi), saPitchClass);
    return Swara.semitoneMap[degree];
  }

  static double targetFrequency({
    required int midi,
    required double a4Hz,
    required int saPitchClass,
    required Temperament temperament,
  }) {
    if (temperament == Temperament.equal) {
      return midiToFrequency(midi, a4Hz);
    }
    final steps = normalizeDegree(pitchClassOf(midi), saPitchClass);
    final saMidi = midi - steps;
    return midiToFrequency(saMidi, a4Hz) * justRatios[steps];
  }

  static bool isInTune(double cents, double toleranceCents) {
    return cents.abs() <= toleranceCents;
  }

  static TuningResult analyze({
    required double frequencyHz,
    required double a4Hz,
    required int saPitchClass,
    required double toleranceCents,
    required double confidence,
    Temperament temperament = Temperament.equal,
  }) {
    final midi = nearestMidi(frequencyHz, a4Hz);
    final target = targetFrequency(
      midi: midi,
      a4Hz: a4Hz,
      saPitchClass: saPitchClass,
      temperament: temperament,
    );
    final cents = centsBetween(frequencyHz, target);
    final inTune = isInTune(cents, toleranceCents);
    final status = inTune
        ? TuningStatus.inTune
        : (cents < 0 ? TuningStatus.flat : TuningStatus.sharp);
    return TuningResult(
      frequencyHz: frequencyHz,
      targetHz: target,
      cents: cents,
      midi: midi,
      noteLabel: noteLabel(midi),
      octave: octaveOf(midi),
      pitchClass: pitchClassOf(midi),
      inTune: inTune,
      status: status,
      swara: swaraFor(midi: midi, saPitchClass: saPitchClass),
      confidence: confidence.clamp(0, 1),
      saPitchClass: saPitchClass,
    );
  }
}
