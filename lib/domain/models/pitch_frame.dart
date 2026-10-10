/// A single observation from the microphone or the demo engine.
class PitchFrame {
  const PitchFrame({
    required this.frequencyHz,
    required this.confidence,
    required this.waveform,
    required this.spectrum,
    required this.demo,
    required this.at,
  });

  final double? frequencyHz;
  final double confidence;
  final List<double> waveform;
  final List<double> spectrum;
  final bool demo;
  final DateTime at;
}
