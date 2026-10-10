import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/flute_art.dart';
import '../../../../domain/models/app_settings.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _fade;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fade = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
    _timer = Timer(const Duration(milliseconds: 2300), () {
      if (!mounted) return;
      context.go('/tuner');
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _fade.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF07060A),
      body: FadeTransition(
        opacity: CurvedAnimation(parent: _fade, curve: Curves.easeOut),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomPaint(painter: _MountainPainter()),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0.4, 0.15),
                  radius: 0.7,
                  colors: [Color(0x55E0B23A), Color(0x00000000)],
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0.15, 0.25),
              child: Transform.rotate(
                angle: -0.55,
                child: FluteArt(
                  instrument: InstrumentId.bansuri,
                  width: 280,
                  height: 78,
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(28, 36, 28, 28),
                child: Column(
                  children: [
                    const Icon(
                      Icons.music_note_rounded,
                      color: Color(0xFFE0B23A),
                      size: 72,
                      shadows: [
                        Shadow(color: Color(0x88E0B23A), blurRadius: 24),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text('Nadvenu', style: AppTheme.brand(context, size: 40)),
                    const SizedBox(height: 4),
                    Text(
                      l10n.productName,
                      style: const TextStyle(
                        color: Color(0xFFF7F2E7),
                        fontSize: 16,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 72,
                      height: 1,
                      color: const Color(0xFFE0B23A),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      l10n.tagline,
                      style: const TextStyle(
                        color: Color(0xFFE0B23A),
                        fontSize: 16,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MountainPainter extends CustomPainter {
  const _MountainPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final back = Path()
      ..moveTo(0, size.height * 0.72)
      ..lineTo(size.width * 0.25, size.height * 0.48)
      ..lineTo(size.width * 0.48, size.height * 0.66)
      ..lineTo(size.width * 0.72, size.height * 0.4)
      ..lineTo(size.width, size.height * 0.62)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(back, Paint()..color = const Color(0xFF1A140C));
    final front = Path()
      ..moveTo(0, size.height * 0.82)
      ..lineTo(size.width * 0.3, size.height * 0.62)
      ..lineTo(size.width * 0.55, size.height * 0.78)
      ..lineTo(size.width * 0.82, size.height * 0.58)
      ..lineTo(size.width, size.height * 0.74)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(front, Paint()..color = const Color(0xFF100E0C));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
