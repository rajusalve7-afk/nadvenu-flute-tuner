import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Semicircular cents gauge from −50 to +50. Red at the edges, green at zero.
class CentsGauge extends StatelessWidget {
  const CentsGauge({super.key, required this.cents, required this.inTune});

  final double cents;
  final bool inTune;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    return SizedBox(
      height: 168,
      width: double.infinity,
      child: CustomPaint(
        painter: _GaugePainter(
          cents: cents,
          inTune: inTune,
          ink: palette.ink,
          muted: palette.muted,
          gold: palette.gold,
          green: palette.green,
        ),
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  _GaugePainter({
    required this.cents,
    required this.inTune,
    required this.ink,
    required this.muted,
    required this.gold,
    required this.green,
  });

  final double cents;
  final bool inTune;
  final Color ink;
  final Color muted;
  final Color gold;
  final Color green;

  static const _ticks = [-50, -30, -10, 0, 10, 30, 50];

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height - 18);
    final radius = math.min(size.width * 0.42, size.height - 36);
    final rect = Rect.fromCircle(center: center, radius: radius);
    const segments = 48;
    final arc = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.butt;
    for (var i = 0; i < segments; i++) {
      final t = i / (segments - 1);
      arc.color = _color(t);
      canvas.drawArc(rect, math.pi + (i / segments) * math.pi, math.pi / segments + 0.01, false, arc);
    }

    final tickPaint = Paint()
      ..color = muted.withValues(alpha: 0.85)
      ..strokeWidth = 1.4;
    for (final tick in _ticks) {
      final angle = _angle(tick.toDouble());
      final inner = _point(center, radius - 16, angle);
      final outer = _point(center, radius - 4, angle);
      canvas.drawLine(inner, outer, tickPaint);
      final label = _point(center, radius + 16, angle);
      final text = TextPainter(
        text: TextSpan(
          text: tick > 0 ? '+$tick' : '$tick',
          style: TextStyle(
            color: tick == 0 ? green : muted,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      text.paint(canvas, label - Offset(text.width / 2, text.height / 2));
    }

    final needleAngle = _angle(cents.clamp(-50, 50));
    final tip = _point(center, radius - 22, needleAngle);
    final needle = Paint()
      ..color = inTune ? green : gold
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(center, tip, needle);
    canvas.drawCircle(
      tip,
      5,
      Paint()
        ..color = inTune ? green : gold
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
    );
    canvas.drawCircle(center, 7, Paint()..color = gold);
    canvas.drawCircle(center, 3.5, Paint()..color = ink);
  }

  Color _color(double t) {
    final distance = (t - 0.5).abs() * 2;
    if (distance < 0.18) return green;
    if (distance < 0.45) return Color.lerp(green, gold, (distance - 0.18) / 0.27)!;
    return Color.lerp(gold, const Color(0xFFE24B4B), (distance - 0.45) / 0.55)!;
  }

  double _angle(double value) {
    final t = (value + 50) / 100;
    return math.pi + t * math.pi;
  }

  Offset _point(Offset center, double radius, double angle) {
    return Offset(
      center.dx + radius * math.cos(angle),
      center.dy + radius * math.sin(angle),
    );
  }

  @override
  bool shouldRepaint(covariant _GaugePainter oldDelegate) {
    return oldDelegate.cents != cents || oldDelegate.inTune != inTune;
  }
}
