import 'app_settings.dart';

/// Playable range for an instrument, in MIDI note numbers.
class InstrumentRange {
  const InstrumentRange({
    required this.id,
    required this.lowMidi,
    required this.highMidi,
  });

  final InstrumentId id;
  final int lowMidi;
  final int highMidi;

  bool contains(int midi) => midi >= lowMidi && midi <= highMidi;

  static const all = <InstrumentId, InstrumentRange>{
    InstrumentId.bansuri: InstrumentRange(
      id: InstrumentId.bansuri,
      lowMidi: 60,
      highMidi: 96,
    ),
    InstrumentId.concert: InstrumentRange(
      id: InstrumentId.concert,
      lowMidi: 59,
      highMidi: 98,
    ),
    InstrumentId.nativeAmerican: InstrumentRange(
      id: InstrumentId.nativeAmerican,
      lowMidi: 57,
      highMidi: 81,
    ),
    InstrumentId.quena: InstrumentRange(
      id: InstrumentId.quena,
      lowMidi: 67,
      highMidi: 91,
    ),
    InstrumentId.recorder: InstrumentRange(
      id: InstrumentId.recorder,
      lowMidi: 65,
      highMidi: 98,
    ),
    InstrumentId.chromatic: InstrumentRange(
      id: InstrumentId.chromatic,
      lowMidi: 36,
      highMidi: 108,
    ),
  };

  static InstrumentRange of(InstrumentId id) => all[id]!;
}
