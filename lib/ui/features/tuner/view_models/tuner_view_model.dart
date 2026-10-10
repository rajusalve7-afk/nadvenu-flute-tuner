import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../../data/repositories/session_repository.dart';
import '../../../../data/services/pitch_capture_service.dart';
import '../../../../domain/models/app_settings.dart';
import '../../../../domain/models/pitch_frame.dart';
import '../../../../domain/models/tuning_result.dart';
import '../../../../domain/models/tuning_session.dart';
import '../../../../domain/tuning/in_tune_lock.dart';
import '../../../../domain/tuning/tuning_math.dart';
import '../../settings/view_models/settings_view_model.dart';

/// Drives the needle, the analysis chart, and in-tune session locks.
class TunerViewModel extends ChangeNotifier {
  TunerViewModel({
    required SettingsViewModel settings,
    required SessionRepository sessions,
    required PitchCaptureService pitch,
    InTuneLock? lock,
  }) : _settings = settings, // ignore: prefer_initializing_formals
       _sessions = sessions, // ignore: prefer_initializing_formals
       _pitch = pitch, // ignore: prefer_initializing_formals
       _lock = lock ?? InTuneLock() {
    _pushContext();
    _settings.addListener(_handleSettings);
    _subscription = _pitch.frames.listen(_onFrame);
  }

  final SettingsViewModel _settings;
  final SessionRepository _sessions;
  final PitchCaptureService _pitch;
  final InTuneLock _lock;

  StreamSubscription<PitchFrame>? _subscription;
  PitchFrame? frame;
  TuningResult? result;
  double? _smoothHz;
  String? pendingLockNote;
  bool pendingMicFailure = false;

  AppSettings get settings => _settings.settings;

  bool get demo => !(frame?.demo == false && _pitch.isMic);

  bool get micLive => _pitch.isMic;

  List<double> get waveform => frame?.waveform ?? const [];

  List<double> get spectrum => frame?.spectrum ?? const [];

  Future<void> ensureRunning() => _pitch.startDemoIfIdle();

  Future<void> toggleInput() async {
    if (_pitch.isMic) {
      await _pitch.startDemo();
      notifyListeners();
      return;
    }
    final ok = await _pitch.startMic();
    if (!ok) pendingMicFailure = true;
    notifyListeners();
  }

  /// Injects a frame without opening the microphone. Used by widget tests.
  void previewFrame(PitchFrame frame) => _onFrame(frame);

  bool takeMicFailure() {
    if (!pendingMicFailure) return false;
    pendingMicFailure = false;
    return true;
  }

  String? takeLockNote() {
    final note = pendingLockNote;
    pendingLockNote = null;
    return note;
  }

  void _handleSettings() {
    _pushContext();
    _recompute(DateTime.now(), allowLock: false);
    notifyListeners();
  }

  void _pushContext() {
    final gate = switch (settings.sensitivity) {
      Sensitivity.low => 0.02,
      Sensitivity.medium => 0.008,
      Sensitivity.high => 0.003,
    };
    _pitch.updateContext(
      a4Hz: settings.a4Hz,
      saPitchClass: settings.saPitchClass,
      rmsGate: gate,
    );
  }

  void _onFrame(PitchFrame next) {
    frame = next;
    final hz = next.frequencyHz;
    if (hz == null) {
      _smoothHz = null;
    } else {
      final alpha = switch (settings.sensitivity) {
        Sensitivity.low => 0.22,
        Sensitivity.medium => 0.5,
        Sensitivity.high => 0.8,
      };
      _smoothHz = _smoothHz == null
          ? hz
          : _smoothHz! + alpha * (hz - _smoothHz!);
    }
    _recompute(next.at, allowLock: true);
    notifyListeners();
  }

  void _recompute(DateTime at, {required bool allowLock}) {
    final hz = _smoothHz;
    final confidence = frame?.confidence ?? 0;
    if (hz == null) {
      result = null;
      return;
    }
    result = TuningMath.analyze(
      frequencyHz: hz,
      a4Hz: settings.a4Hz,
      saPitchClass: settings.saPitchClass,
      toleranceCents: settings.toleranceCents,
      confidence: confidence,
      temperament: settings.temperament,
    );
    if (!allowLock) return;
    final tuning = result!;
    final fired = _lock.update(
      at: at,
      inTune: tuning.inTune,
      confidence: tuning.confidence,
      noteId: '${tuning.midi}|${settings.instrument.name}|${settings.saPitchClass}',
    );
    if (!fired) return;
    pendingLockNote = tuning.noteLabel;
    _sessions.add(
      TuningSession(
        id: at.microsecondsSinceEpoch.toString(),
        midi: tuning.midi,
        saPitchClass: settings.saPitchClass,
        instrument: settings.instrument,
        at: at,
      ),
    );
  }

  @override
  void dispose() {
    _settings.removeListener(_handleSettings);
    _subscription?.cancel();
    super.dispose();
  }
}
