import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:nadvenu_flute_tuner/domain/models/app_settings.dart';
import 'package:nadvenu_flute_tuner/domain/models/swara.dart';
import 'package:nadvenu_flute_tuner/domain/models/tuning_result.dart';
import 'package:nadvenu_flute_tuner/domain/tuning/tuning_math.dart';

void main() {
  group('TuningMath', () {
    test('A4 at the reference is A4 and exactly in tune', () {
      final result = TuningMath.analyze(
        frequencyHz: 440,
        a4Hz: 440,
        saPitchClass: 0,
        toleranceCents: 5,
        confidence: 1,
      );
      expect(result.noteLabel, 'A4');
      expect(result.midi, 69);
      expect(result.octave, 4);
      expect(result.cents, closeTo(0, 0.001));
      expect(result.inTune, isTrue);
      expect(result.status, TuningStatus.inTune);
    });

    test('C4 is about 261.63 Hz when A4 is 440', () {
      final hz = TuningMath.midiToFrequency(60, 440);
      expect(hz, closeTo(261.6256, 0.001));
      final result = TuningMath.analyze(
        frequencyHz: hz,
        a4Hz: 440,
        saPitchClass: 0,
        toleranceCents: 5,
        confidence: 0.9,
      );
      expect(result.noteLabel, 'C4');
      expect(result.octave, 4);
      expect(result.cents.abs(), lessThan(0.01));
    });

    test('G is Pa when Sa is C, not Ga', () {
      final g4 = TuningMath.midiToFrequency(67, 440);
      final result = TuningMath.analyze(
        frequencyHz: g4,
        a4Hz: 440,
        saPitchClass: 0,
        toleranceCents: 5,
        confidence: 1,
      );
      expect(result.noteLabel, 'G4');
      expect(result.swara.degree, 4);
      expect(result.swara.variant, SwaraVariant.shuddha);
    });

    test('shuddha and altered swaras from C as Sa', () {
      Swara of(int midi) => TuningMath.swaraFor(midi: midi, saPitchClass: 0);
      expect(of(60).degree, 0); // Sa
      expect(of(61), const Swara(degree: 1, variant: SwaraVariant.komal));
      expect(of(62), const Swara(degree: 1, variant: SwaraVariant.shuddha));
      expect(of(63), const Swara(degree: 2, variant: SwaraVariant.komal));
      expect(of(64), const Swara(degree: 2, variant: SwaraVariant.shuddha));
      expect(of(65), const Swara(degree: 3, variant: SwaraVariant.shuddha));
      expect(of(66), const Swara(degree: 3, variant: SwaraVariant.tivra));
      expect(of(68), const Swara(degree: 5, variant: SwaraVariant.komal));
      expect(of(69), const Swara(degree: 5, variant: SwaraVariant.shuddha));
      expect(of(70), const Swara(degree: 6, variant: SwaraVariant.komal));
      expect(of(71), const Swara(degree: 6, variant: SwaraVariant.shuddha));
    });

    test('moving Sa to D makes E a shuddha Re', () {
      final e4 = TuningMath.midiToFrequency(64, 440);
      final result = TuningMath.analyze(
        frequencyHz: e4,
        a4Hz: 440,
        saPitchClass: 2,
        toleranceCents: 5,
        confidence: 1,
      );
      expect(result.noteLabel, 'E4');
      expect(result.swara.degree, 1);
      expect(result.swara.variant, SwaraVariant.shuddha);
    });

    test('flat and sharp follow the sign of the cents', () {
      final sharp = TuningMath.analyze(
        frequencyHz: 445,
        a4Hz: 440,
        saPitchClass: 0,
        toleranceCents: 5,
        confidence: 1,
      );
      expect(sharp.cents, greaterThan(5));
      expect(sharp.status, TuningStatus.sharp);
      expect(sharp.inTune, isFalse);

      final flatHz = 440 * math.pow(2, -10 / 1200).toDouble();
      final flat = TuningMath.analyze(
        frequencyHz: flatHz,
        a4Hz: 440,
        saPitchClass: 0,
        toleranceCents: 5,
        confidence: 1,
      );
      expect(flat.cents, closeTo(-10, 0.05));
      expect(flat.status, TuningStatus.flat);

      final closeHz = 440 * math.pow(2, 3 / 1200).toDouble();
      final near = TuningMath.analyze(
        frequencyHz: closeHz,
        a4Hz: 440,
        saPitchClass: 0,
        toleranceCents: 5,
        confidence: 1,
      );
      expect(near.inTune, isTrue);
      expect(near.status, TuningStatus.inTune);
    });

    test('changing A4 retunes every target', () {
      final at440 = TuningMath.midiToFrequency(69, 440);
      final at432 = TuningMath.midiToFrequency(69, 432);
      expect(at440, 440);
      expect(at432, 432);
      final heardAs432 = TuningMath.analyze(
        frequencyHz: 432,
        a4Hz: 432,
        saPitchClass: 0,
        toleranceCents: 5,
        confidence: 1,
      );
      expect(heardAs432.noteLabel, 'A4');
      expect(heardAs432.cents.abs(), lessThan(0.01));
      final sameToneAt440 = TuningMath.analyze(
        frequencyHz: 432,
        a4Hz: 440,
        saPitchClass: 0,
        toleranceCents: 5,
        confidence: 1,
      );
      expect(sameToneAt440.cents, lessThan(-5));
    });

    test('just Pa is in tune at 3/2 and about two cents sharp in equal temperament', () {
      final c4 = TuningMath.midiToFrequency(60, 440);
      final jiPa = c4 * 3 / 2;
      final just = TuningMath.analyze(
        frequencyHz: jiPa,
        a4Hz: 440,
        saPitchClass: 0,
        toleranceCents: 5,
        confidence: 1,
        temperament: Temperament.just,
      );
      expect(just.noteLabel, 'G4');
      expect(just.swara.degree, 4);
      expect(just.cents.abs(), lessThan(0.2));

      final equal = TuningMath.analyze(
        frequencyHz: jiPa,
        a4Hz: 440,
        saPitchClass: 0,
        toleranceCents: 5,
        confidence: 1,
      );
      expect(equal.cents, closeTo(1.955, 0.05));
    });

    test('octave numbers follow scientific pitch', () {
      expect(TuningMath.octaveOf(57), 3);
      expect(TuningMath.noteLabel(57), 'A3');
      expect(TuningMath.noteLabel(72), 'C5');
    });
  });
}
