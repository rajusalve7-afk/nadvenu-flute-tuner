import 'dart:math' as math;

/// A detected fundamental and how periodic the buffer was.
class PitchEstimate {
  const PitchEstimate({required this.frequencyHz, required this.confidence});

  final double frequencyHz;
  final double confidence;
}

/// YIN-style pitch detector. Pure Dart so the same path runs on web and mobile.
class PitchDetector {
  const PitchDetector();

  PitchEstimate? detect(
    List<double> samples,
    int sampleRate, {
    double rmsGate = 0.01,
  }) {
    if (samples.length < 256 || sampleRate <= 0) return null;

    var data = samples;
    var rate = sampleRate;
    if (data.length > 1400) {
      final half = <double>[];
      for (var i = 0; i + 1 < data.length; i += 2) {
        half.add((data[i] + data[i + 1]) * 0.5);
      }
      data = half;
      rate = sampleRate ~/ 2;
    }

    final n = data.length;
    var sumSq = 0.0;
    for (final sample in data) {
      sumSq += sample * sample;
    }
    final rms = math.sqrt(sumSq / n);
    if (rms < rmsGate) return null;

    final minLag = math.max(2, (rate / 1600).floor());
    final maxLag = math.min(n ~/ 2, (rate / 55).ceil());
    if (maxLag <= minLag) return null;

    final diff = List<double>.filled(maxLag + 1, 0);
    for (var tau = 1; tau <= maxLag; tau++) {
      var sum = 0.0;
      final limit = n - tau;
      for (var i = 0; i < limit; i++) {
        final delta = data[i] - data[i + tau];
        sum += delta * delta;
      }
      diff[tau] = sum;
    }

    final cmnd = List<double>.filled(maxLag + 1, 1);
    var running = 0.0;
    for (var tau = 1; tau <= maxLag; tau++) {
      running += diff[tau];
      cmnd[tau] = running == 0 ? 1 : diff[tau] * tau / running;
    }

    const threshold = 0.18;
    int? best;
    var tau = minLag;
    while (tau <= maxLag) {
      if (cmnd[tau] < threshold) {
        while (tau + 1 <= maxLag && cmnd[tau + 1] < cmnd[tau]) {
          tau++;
        }
        best = tau;
        break;
      }
      tau++;
    }
    if (best == null) {
      var minValue = double.infinity;
      var minTau = minLag;
      for (var t = minLag; t <= maxLag; t++) {
        if (cmnd[t] < minValue) {
          minValue = cmnd[t];
          minTau = t;
        }
      }
      if (minValue < 0.45) best = minTau;
    }
    if (best == null) return null;

    final x0 = best > 0 ? cmnd[best - 1] : cmnd[best];
    final x1 = cmnd[best];
    final x2 = best < maxLag ? cmnd[best + 1] : cmnd[best];
    final denom = 2 * (x0 - 2 * x1 + x2);
    final delta = denom == 0 ? 0.0 : (x0 - x2) / denom;
    final period = best + delta;
    if (period <= 1) return null;

    final hz = rate / period;
    if (hz < 50 || hz > 2000) return null;
    final confidence = (1 - x1).clamp(0.0, 1.0).toDouble();
    return PitchEstimate(frequencyHz: hz, confidence: confidence);
  }
}
