import 'swara.dart';

enum TuningStatus { inTune, flat, sharp }

/// One analyzed pitch: equal-tempered identity plus cents and sargam.
class TuningResult {
  const TuningResult({
    required this.frequencyHz,
    required this.targetHz,
    required this.cents,
    required this.midi,
    required this.noteLabel,
    required this.octave,
    required this.pitchClass,
    required this.inTune,
    required this.status,
    required this.swara,
    required this.confidence,
    required this.saPitchClass,
  });

  final double frequencyHz;
  final double targetHz;
  final double cents;
  final int midi;
  final String noteLabel;
  final int octave;
  final int pitchClass;
  final bool inTune;
  final TuningStatus status;
  final Swara swara;
  final double confidence;
  final int saPitchClass;
}
