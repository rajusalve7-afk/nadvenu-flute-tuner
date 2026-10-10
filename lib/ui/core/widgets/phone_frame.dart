import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Phone chrome on wide windows, full bleed on a narrow screen.
class PhoneFrame extends StatelessWidget {
  const PhoneFrame({super.key, required this.child});

  final Widget child;

  static const wideBreakpoint = 720.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < wideBreakpoint) return child;
        final height = (constraints.maxHeight - 36).clamp(640.0, 880.0);
        const width = 400.0;
        final media = MediaQuery.of(context);
        return DecoratedBox(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0, -0.2),
              radius: 1.05,
              colors: [Color(0xFF2A2416), Color(0xFF070708)],
            ),
          ),
          child: Center(
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: AppPalette.dark.bg,
                borderRadius: BorderRadius.circular(36),
                border: Border.all(color: AppPalette.dark.gold, width: 1.4),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x66E0B23A),
                    blurRadius: 36,
                    spreadRadius: -8,
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: MediaQuery(
                data: media.copyWith(
                  size: Size(width, height - 28),
                  padding: EdgeInsets.zero,
                  viewPadding: EdgeInsets.zero,
                  viewInsets: EdgeInsets.zero,
                ),
                child: Column(
                  children: [
                    const _StatusBar(),
                    Expanded(child: child),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _StatusBar extends StatelessWidget {
  const _StatusBar();

  @override
  Widget build(BuildContext context) {
    final now = TimeOfDay.now();
    final hour = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;
    final minute = now.minute.toString().padLeft(2, '0');
    return Container(
      height: 28,
      color: const Color(0xFF0C0C0E),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          Text(
            '$hour:$minute',
            style: const TextStyle(
              color: Color(0xFFF7F2E7),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.signal_cellular_alt,
            size: 14,
            color: Color(0xFFF7F2E7),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.wifi, size: 14, color: Color(0xFFF7F2E7)),
          const SizedBox(width: 4),
          const Icon(Icons.battery_full, size: 16, color: Color(0xFFF7F2E7)),
        ],
      ),
    );
  }
}
