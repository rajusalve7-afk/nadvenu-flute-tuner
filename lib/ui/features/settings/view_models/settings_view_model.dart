import 'package:flutter/foundation.dart';

import '../../../../data/repositories/settings_repository.dart';
import '../../../../domain/models/app_settings.dart';

/// Presentation logic for every preference the tuner reads.
class SettingsViewModel extends ChangeNotifier {
  SettingsViewModel(this._repository);

  final SettingsRepository _repository;

  AppSettings get settings => _repository.current;

  String get languageCode => settings.languageCode;

  bool get darkTheme => settings.darkTheme;

  Future<void> setA4(double hz) {
    return _save(settings.copyWith(a4Hz: hz.clamp(415, 466).toDouble()));
  }

  Future<void> setTolerance(double cents) {
    return _save(
      settings.copyWith(toleranceCents: cents.clamp(1, 25).toDouble()),
    );
  }

  Future<void> setSensitivity(Sensitivity sensitivity) {
    return _save(settings.copyWith(sensitivity: sensitivity));
  }

  Future<void> setDarkTheme(bool enabled) {
    return _save(settings.copyWith(darkTheme: enabled));
  }

  Future<void> setLanguage(String code) {
    return _save(settings.copyWith(languageCode: code));
  }

  Future<void> setShowSwaras(bool enabled) {
    return _save(settings.copyWith(showIndianSwaras: enabled));
  }

  Future<void> setInstrument(InstrumentId instrument) {
    return _save(settings.copyWith(instrument: instrument));
  }

  Future<void> setRoot(int pitchClass) {
    return _save(settings.copyWith(saPitchClass: pitchClass.clamp(0, 11)));
  }

  Future<void> setProPreview(bool unlocked) {
    return _save(settings.copyWith(proPreview: unlocked));
  }

  Future<void> setTemperament(Temperament temperament) {
    return _save(settings.copyWith(temperament: temperament));
  }

  Future<void> setRating(int stars) {
    return _save(settings.copyWith(savedRating: stars.clamp(0, 5)));
  }

  Future<void> _save(AppSettings next) async {
    await _repository.save(next);
    notifyListeners();
  }
}
