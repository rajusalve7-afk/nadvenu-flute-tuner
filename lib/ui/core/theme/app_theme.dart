import 'package:flutter/material.dart';

/// Near-black and warm gold, with a paper theme when dark mode is off.
class AppPalette {
  const AppPalette({
    required this.bg,
    required this.card,
    required this.cardAlt,
    required this.line,
    required this.gold,
    required this.goldDeep,
    required this.ink,
    required this.muted,
    required this.green,
    required this.red,
    required this.onGold,
  });

  final Color bg;
  final Color card;
  final Color cardAlt;
  final Color line;
  final Color gold;
  final Color goldDeep;
  final Color ink;
  final Color muted;
  final Color green;
  final Color red;
  final Color onGold;

  static const dark = AppPalette(
    bg: Color(0xFF0C0C0E),
    card: Color(0xFF17171B),
    cardAlt: Color(0xFF101014),
    line: Color(0xFF3A3428),
    gold: Color(0xFFE0B23A),
    goldDeep: Color(0xFFC4922A),
    ink: Color(0xFFF7F2E7),
    muted: Color(0xFFA89B86),
    green: Color(0xFF2FBF71),
    red: Color(0xFFE24B4B),
    onGold: Color(0xFF1A1408),
  );

  static const light = AppPalette(
    bg: Color(0xFFF6F0E4),
    card: Color(0xFFFFFBF3),
    cardAlt: Color(0xFFF3EADF),
    line: Color(0xFFE2D3B0),
    gold: Color(0xFFA67C1A),
    goldDeep: Color(0xFF8C6412),
    ink: Color(0xFF1E160C),
    muted: Color(0xFF6E6254),
    green: Color(0xFF1E8F4E),
    red: Color(0xFFC73636),
    onGold: Color(0xFFFFF8EA),
  );

  static AppPalette of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? dark : light;
  }
}

class AppTheme {
  static const _fallback = [
    'NotoDeva',
    'NotoGuj',
    'NotoBeng',
    'NotoTaml',
    'NotoTelu',
  ];

  static ThemeData dark() => _build(AppPalette.dark, Brightness.dark);

  static ThemeData light() => _build(AppPalette.light, Brightness.light);

  static ThemeData _build(AppPalette palette, Brightness brightness) {
    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: palette.bg,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: palette.gold,
        onPrimary: palette.onGold,
        secondary: palette.green,
        onSecondary: palette.onGold,
        error: palette.red,
        onError: Colors.white,
        surface: palette.card,
        onSurface: palette.ink,
      ),
      fontFamily: 'Outfit',
      fontFamilyFallback: _fallback,
      splashFactory: InkRipple.splashFactory,
    );
    final text = base.textTheme.apply(
      fontFamily: 'Outfit',
      fontFamilyFallback: _fallback,
      bodyColor: palette.ink,
      displayColor: palette.ink,
    );
    return base.copyWith(
      textTheme: text,
      iconTheme: IconThemeData(color: palette.gold),
      dividerColor: palette.line,
      sliderTheme: SliderThemeData(
        activeTrackColor: palette.gold,
        inactiveTrackColor: palette.line,
        thumbColor: palette.gold,
        overlayColor: palette.gold.withValues(alpha: 0.16),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return palette.gold;
          return palette.muted;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return palette.gold.withValues(alpha: 0.35);
          }
          return palette.line;
        }),
      ),
    );
  }

  static TextStyle brand(BuildContext context, {double size = 22}) {
    final palette = AppPalette.of(context);
    return TextStyle(
      fontFamily: 'Cinzel',
      fontFamilyFallback: const ['Outfit', ..._fallback],
      fontWeight: FontWeight.w600,
      fontSize: size,
      color: palette.gold,
      height: 1.05,
    );
  }
}
