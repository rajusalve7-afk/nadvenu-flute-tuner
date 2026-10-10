/// How quickly the needle follows a new pitch.
enum Sensitivity { low, medium, high }

/// Equal temperament is the default. Just intonation is a Pro preview mode.
enum Temperament { equal, just }

/// Persisted tuner preferences. Immutable; update through [copyWith].
class AppSettings {
  const AppSettings({
    required this.a4Hz,
    required this.toleranceCents,
    required this.sensitivity,
    required this.darkTheme,
    required this.languageCode,
    required this.showIndianSwaras,
    required this.instrument,
    required this.saPitchClass,
    required this.proPreview,
    required this.temperament,
    required this.savedRating,
  });

  factory AppSettings.defaults() {
    return const AppSettings(
      a4Hz: 440,
      toleranceCents: 5,
      sensitivity: Sensitivity.medium,
      darkTheme: true,
      languageCode: 'en',
      showIndianSwaras: true,
      instrument: InstrumentId.bansuri,
      saPitchClass: 0,
      proPreview: false,
      temperament: Temperament.equal,
      savedRating: 0,
    );
  }

  final double a4Hz;
  final double toleranceCents;
  final Sensitivity sensitivity;
  final bool darkTheme;
  final String languageCode;
  final bool showIndianSwaras;
  final InstrumentId instrument;
  final int saPitchClass;
  final bool proPreview;
  final Temperament temperament;
  final int savedRating;

  /// Sargam is shown for the bansuri even if the toggle is off.
  bool get swarasVisible =>
      showIndianSwaras || instrument == InstrumentId.bansuri;

  AppSettings copyWith({
    double? a4Hz,
    double? toleranceCents,
    Sensitivity? sensitivity,
    bool? darkTheme,
    String? languageCode,
    bool? showIndianSwaras,
    InstrumentId? instrument,
    int? saPitchClass,
    bool? proPreview,
    Temperament? temperament,
    int? savedRating,
  }) {
    return AppSettings(
      a4Hz: a4Hz ?? this.a4Hz,
      toleranceCents: toleranceCents ?? this.toleranceCents,
      sensitivity: sensitivity ?? this.sensitivity,
      darkTheme: darkTheme ?? this.darkTheme,
      languageCode: languageCode ?? this.languageCode,
      showIndianSwaras: showIndianSwaras ?? this.showIndianSwaras,
      instrument: instrument ?? this.instrument,
      saPitchClass: saPitchClass ?? this.saPitchClass,
      proPreview: proPreview ?? this.proPreview,
      temperament: temperament ?? this.temperament,
      savedRating: savedRating ?? this.savedRating,
    );
  }

  Map<String, Object?> toJson() => {
    'a4': a4Hz,
    'tol': toleranceCents,
    'sens': sensitivity.name,
    'dark': darkTheme,
    'lang': languageCode,
    'swaras': showIndianSwaras,
    'inst': instrument.name,
    'sa': saPitchClass,
    'pro': proPreview,
    'temp': temperament.name,
    'rating': savedRating,
  };

  factory AppSettings.fromJson(Map<String, Object?> json) {
    final defaults = AppSettings.defaults();
    return AppSettings(
      a4Hz: (json['a4'] as num?)?.toDouble() ?? defaults.a4Hz,
      toleranceCents:
          (json['tol'] as num?)?.toDouble() ?? defaults.toleranceCents,
      sensitivity: Sensitivity.values.byName(
        json['sens'] as String? ?? defaults.sensitivity.name,
      ),
      darkTheme: json['dark'] as bool? ?? defaults.darkTheme,
      languageCode: json['lang'] as String? ?? defaults.languageCode,
      showIndianSwaras: json['swaras'] as bool? ?? defaults.showIndianSwaras,
      instrument: InstrumentId.values.byName(
        json['inst'] as String? ?? defaults.instrument.name,
      ),
      saPitchClass: (json['sa'] as num?)?.toInt() ?? defaults.saPitchClass,
      proPreview: json['pro'] as bool? ?? defaults.proPreview,
      temperament: Temperament.values.byName(
        json['temp'] as String? ?? defaults.temperament.name,
      ),
      savedRating: (json['rating'] as num?)?.toInt() ?? defaults.savedRating,
    );
  }
}

/// Flutes the tuner knows about.
enum InstrumentId {
  bansuri,
  concert,
  nativeAmerican,
  quena,
  recorder,
  chromatic,
}
