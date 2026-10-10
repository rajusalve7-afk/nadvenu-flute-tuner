import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../domain/models/app_settings.dart';

/// Painted flutes. Original drawings, not photographs.
class FluteArt extends StatelessWidget {
  const FluteArt({
    super.key,
    required this.instrument,
    this.width = 112,
    this.height = 36,
  });

  final InstrumentId instrument;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(painter: _FlutePainter(instrument)),
    );
  }
}

class _FlutePainter extends CustomPainter {
  _FlutePainter(this.instrument);

  final InstrumentId instrument;

  @override
  void paint(Canvas canvas, Size size) {
    switch (instrument) {
      case InstrumentId.bansuri:
        _bansuri(canvas, size);
      case InstrumentId.concert:
        _concert(canvas, size);
      case InstrumentId.nativeAmerican:
        _native(canvas, size);
      case InstrumentId.quena:
        _quena(canvas, size);
      case InstrumentId.recorder:
        _recorder(canvas, size);
      case InstrumentId.chromatic:
        _chromatic(canvas, size);
    }
  }

  void _bansuri(Canvas canvas, Size size) {
    final body = RRect.fromRectAndRadius(
      Rect.fromLTWH(2, size.height * 0.28, size.width - 4, size.height * 0.44),
      const Radius.circular(20),
    );
    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFE6C27A), Color(0xFF8A5A24), Color(0xFFC48A3A)],
      ).createShader(body.outerRect);
    canvas.drawRRect(body, paint);
    final ring = Paint()..color = const Color(0xFF5C3A16);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.18, size.height * 0.26, 3, size.height * 0.48), ring);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.78, size.height * 0.26, 3, size.height * 0.48), ring);
    final hole = Paint()..color = const Color(0xFF2A1608);
    for (var i = 0; i < 6; i++) {
      final x = size.width * (0.32 + i * 0.07);
      canvas.drawCircle(Offset(x, size.height * 0.5), size.height * 0.09, hole);
    }
  }

  void _concert(Canvas canvas, Size size) {
    final body = RRect.fromRectAndRadius(
      Rect.fromLTWH(4, size.height * 0.32, size.width - 8, size.height * 0.36),
      const Radius.circular(8),
    );
    canvas.drawRRect(
      body,
      Paint()
        ..shader = const LinearGradient(
          colors: [Color(0xFFF4F7FB), Color(0xFF8E98A6), Color(0xFFD5DCE6)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(body.outerRect),
    );
    final key = Paint()..color = const Color(0xFF5E6772);
    for (var i = 0; i < 7; i++) {
      final x = size.width * (0.22 + i * 0.09);
      canvas.drawCircle(Offset(x, size.height * 0.34), 3.2, key);
      canvas.drawLine(
        Offset(x, size.height * 0.34),
        Offset(x, size.height * 0.66),
        key..strokeWidth = 1.2,
      );
    }
  }

  void _native(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(8, size.height * 0.62)
      ..lineTo(size.width * 0.72, size.height * 0.3)
      ..lineTo(size.width - 6, size.height * 0.38)
      ..lineTo(size.width * 0.7, size.height * 0.72)
      ..close();
    canvas.drawPath(path, Paint()..color = const Color(0xFF8C5A32));
    canvas.drawCircle(
      Offset(size.width - 10, size.height * 0.34),
      6,
      Paint()..color = const Color(0xFFE0B23A),
    );
    final hole = Paint()..color = const Color(0xFF3A2414);
    for (var i = 0; i < 5; i++) {
      canvas.drawCircle(
        Offset(size.width * (0.28 + i * 0.08), size.height * 0.5),
        2.4,
        hole,
      );
    }
  }

  void _quena(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(size.width * 0.55, size.height * 0.5);
    canvas.rotate(-0.4);
    final rect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset.zero, width: size.width * 0.7, height: 12),
      const Radius.circular(6),
    );
    canvas.drawRRect(rect, Paint()..color = const Color(0xFF6B4428));
    final hole = Paint()..color = const Color(0xFF24140C);
    for (var i = 0; i < 6; i++) {
      canvas.drawCircle(Offset(-size.width * 0.22 + i * 12, 0), 2.2, hole);
    }
    canvas.drawCircle(Offset(size.width * 0.32, -2), 3, Paint()..color = const Color(0xFFD7B07A));
    canvas.restore();
  }

  void _recorder(Canvas canvas, Size size) {
    final body = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.16, size.height * 0.22, size.width * 0.7, size.height * 0.56),
      const Radius.circular(10),
    );
    canvas.drawRRect(body, Paint()..color = const Color(0xFFF3E6C8));
    final beak = Path()
      ..moveTo(size.width * 0.16, size.height * 0.35)
      ..lineTo(6, size.height * 0.42)
      ..lineTo(size.width * 0.16, size.height * 0.62)
      ..close();
    canvas.drawPath(beak, Paint()..color = const Color(0xFFE7D3A4));
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.28, size.height * 0.22, 8, 6),
      Paint()..color = const Color(0xFF6E5838),
    );
    final hole = Paint()..color = const Color(0xFF6E5838);
    for (var i = 0; i < 6; i++) {
      canvas.drawCircle(Offset(size.width * (0.4 + i * 0.07), size.height * 0.5), 2.3, hole);
    }
  }

  void _chromatic(Canvas canvas, Size size) {
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(6, size.height * 0.36, size.width - 12, size.height * 0.28),
      const Radius.circular(12),
    );
    canvas.drawRRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          colors: [Color(0xFFE0B23A), Color(0xFF8E98A6), Color(0xFFE0B23A)],
        ).createShader(rect.outerRect),
    );
    final hole = Paint()..color = const Color(0xFF1A1408);
    for (var i = 0; i < 8; i++) {
      final y = size.height * (0.42 + (i.isEven ? 0 : 0.16));
      canvas.drawCircle(Offset(size.width * (0.18 + i * 0.08), y), 2.1, hole);
    }
    canvas.drawArc(
      Rect.fromLTWH(size.width - 22, size.height * 0.28, 16, 16),
      math.pi,
      math.pi,
      false,
      Paint()
        ..color = const Color(0xFFE0B23A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4,
    );
  }

  @override
  bool shouldRepaint(covariant _FlutePainter oldDelegate) {
    return oldDelegate.instrument != instrument;
  }
}
