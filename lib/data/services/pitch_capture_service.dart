import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:record/record.dart';

import '../../domain/models/pitch_frame.dart';
import '../../domain/tuning/pitch_detector.dart';
import 'demo_pitch_engine.dart';

/// Microphone capture with an automatic demo-tone fallback.
class PitchCaptureService {
  PitchCaptureService({
    this._demo = const DemoPitchEngine(),
    this._detector = const PitchDetector(),
  });

  final DemoPitchEngine _demo;
  final PitchDetector _detector;
  AudioRecorder? _recorder;

  final _frames = StreamController<PitchFrame>.broadcast();
  Stream<PitchFrame> get frames => _frames.stream;

  bool isMic = false;
  double a4Hz = 440;
  int saPitchClass = 0;
  double rmsGate = 0.008;

  Timer? _timer;
  final _watch = Stopwatch();
  StreamSubscription<Uint8List>? _micSub;
  final _pcm = BytesBuilder(copy: false);
  final _sampleRate = 44100;

  void updateContext({
    required double a4Hz,
    required int saPitchClass,
    required double rmsGate,
  }) {
    this.a4Hz = a4Hz;
    this.saPitchClass = saPitchClass;
    this.rmsGate = rmsGate;
  }

  Future<void> startDemoIfIdle() async {
    if (_timer != null && !isMic) return;
    await startDemo();
  }

  Future<void> startDemo() async {
    await _stopMic();
    isMic = false;
    _watch
      ..reset()
      ..start();
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 50), (_) {
      if (_frames.isClosed) return;
      _frames.add(
        _demo.frame(
          elapsed: _watch.elapsed,
          a4Hz: a4Hz,
          saPitchClass: saPitchClass,
        ),
      );
    });
  }

  /// Returns false when the platform refuses the microphone.
  Future<bool> startMic() async {
    try {
      _recorder ??= AudioRecorder();
      final recorder = _recorder!;
      final allowed = await recorder.hasPermission();
      if (!allowed) {
        await startDemo();
        return false;
      }
      await _stopMic();
      _timer?.cancel();
      _timer = null;
      final stream = await recorder.startStream(
        const RecordConfig(
          encoder: AudioEncoder.pcm16bits,
          sampleRate: 44100,
          numChannels: 1,
          autoGain: false,
          echoCancel: false,
          noiseSuppress: false,
        ),
      );
      isMic = true;
      _pcm.clear();
      _micSub = stream.listen(
        _onPcm,
        onError: (_) {
          startDemo();
        },
        onDone: () {
          if (isMic) startDemo();
        },
      );
      return true;
    } catch (_) {
      await startDemo();
      return false;
    }
  }

  void _onPcm(Uint8List chunk) {
    if (chunk.isEmpty || _frames.isClosed) return;
    _pcm.add(chunk);
    final bytes = _pcm.toBytes();
    const samplesNeeded = 2048;
    final need = samplesNeeded * 2;
    if (bytes.length < need) return;
    final start = bytes.length - need;
    final view = ByteData.sublistView(bytes, start);
    final samples = List<double>.generate(samplesNeeded, (i) {
      return view.getInt16(i * 2, Endian.little) / 32768.0;
    });
    _pcm.clear();
    final estimate = _detector.detect(
      samples,
      _sampleRate,
      rmsGate: rmsGate,
    );
    _frames.add(
      PitchFrame(
        frequencyHz: estimate?.frequencyHz,
        confidence: estimate?.confidence ?? 0,
        waveform: _waveform(samples),
        spectrum: _spectrum(samples, _sampleRate),
        demo: false,
        at: DateTime.now(),
      ),
    );
  }

  List<double> _waveform(List<double> samples) {
    final out = List<double>.filled(64, 0);
    if (samples.isEmpty) return out;
    var peak = 0.0;
    for (final sample in samples) {
      final abs = sample.abs();
      if (abs > peak) peak = abs;
    }
    final scale = peak < 0.001 ? 1.0 : 1 / peak;
    final step = samples.length / out.length;
    for (var i = 0; i < out.length; i++) {
      out[i] = (samples[(i * step).floor()] * scale).clamp(-1.0, 1.0);
    }
    return out;
  }

  List<double> _spectrum(List<double> samples, int sampleRate) {
    const bins = 48;
    final mags = List<double>.filled(bins, 0);
    final n = samples.length;
    if (n == 0) return mags;
    for (var bin = 0; bin < bins; bin++) {
      final freq = 70 * math.pow(2, bin / 8).toDouble();
      final omega = 2 * math.pi * freq / sampleRate;
      final coeff = 2 * math.cos(omega);
      var s0 = 0.0;
      var s1 = 0.0;
      var s2 = 0.0;
      for (var i = 0; i < n; i += 2) {
        s0 = samples[i] + coeff * s1 - s2;
        s2 = s1;
        s1 = s0;
      }
      final real = s1 - s2 * math.cos(omega);
      final imag = s2 * math.sin(omega);
      mags[bin] = math.sqrt(real * real + imag * imag) / n;
    }
    return mags;
  }

  Future<void> _stopMic() async {
    isMic = false;
    await _micSub?.cancel();
    _micSub = null;
    try {
      await _recorder?.stop();
    } catch (_) {
      // Stopping a recorder that never started is fine.
    }
  }

  Future<void> dispose() async {
    _timer?.cancel();
    await _stopMic();
    await _recorder?.dispose();
    await _frames.close();
  }
}
