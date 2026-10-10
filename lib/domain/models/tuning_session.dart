import 'app_settings.dart';

/// A stable in-tune reading the player locked.
class TuningSession {
  const TuningSession({
    required this.id,
    required this.midi,
    required this.saPitchClass,
    required this.instrument,
    required this.at,
  });

  final String id;
  final int midi;
  final int saPitchClass;
  final InstrumentId instrument;
  final DateTime at;

  Map<String, Object?> toJson() => {
    'id': id,
    'midi': midi,
    'sa': saPitchClass,
    'inst': instrument.name,
    'at': at.toUtc().toIso8601String(),
  };

  factory TuningSession.fromJson(Map<String, Object?> json) {
    return TuningSession(
      id: json['id'] as String? ?? '',
      midi: (json['midi'] as num?)?.toInt() ?? 60,
      saPitchClass: (json['sa'] as num?)?.toInt() ?? 0,
      instrument: InstrumentId.values.byName(
        json['inst'] as String? ?? InstrumentId.bansuri.name,
      ),
      at: DateTime.tryParse(json['at'] as String? ?? '') ?? DateTime.now(),
    );
  }

  /// Realistic practice log used the first time the app opens.
  static List<TuningSession> seed(DateTime now) {
    const notes = <int>[60, 62, 64, 65, 67];
    const minutes = <int>[4, 8, 14, 20, 28];
    return [
      for (var i = 0; i < notes.length; i++)
        TuningSession(
          id: 'seed-$i',
          midi: notes[i],
          saPitchClass: 0,
          instrument: InstrumentId.bansuri,
          at: now.subtract(Duration(minutes: minutes[i])),
        ),
    ];
  }
}
