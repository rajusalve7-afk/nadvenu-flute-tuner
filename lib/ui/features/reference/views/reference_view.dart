import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_page.dart';
import '../../settings/view_models/settings_view_model.dart';

class ReferenceView extends StatelessWidget {
  const ReferenceView({super.key});

  static const _presets = [432.0, 440.0, 442.0];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = AppPalette.of(context);
    final settings = context.watch<SettingsViewModel>();
    final hz = settings.settings.a4Hz;
    return AppPage(
      title: l10n.referenceTitle,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        children: [
          const SizedBox(height: 12),
          Text(
            l10n.a4Symbol,
            textAlign: TextAlign.center,
            style: TextStyle(color: palette.muted, fontSize: 16),
          ),
          Text(
            l10n.hzValue(_label(hz)),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: palette.ink,
              fontSize: 52,
              fontWeight: FontWeight.w700,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              _step(context, Icons.remove, l10n.decrease, () {
                settings.setA4(hz - 1);
              }),
              Expanded(
                child: Slider(
                  value: hz.clamp(415, 466),
                  min: 415,
                  max: 466,
                  onChanged: settings.setA4,
                ),
              ),
              _step(context, Icons.add, l10n.increase, () {
                settings.setA4(hz + 1);
              }),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (final preset in _presets)
                ChoiceChip(
                  label: Text(l10n.hzValue(preset.round().toString())),
                  selected: (hz - preset).abs() < 0.4,
                  showCheckmark: false,
                  onSelected: (_) => settings.setA4(preset),
                  selectedColor: palette.gold,
                  labelStyle: TextStyle(
                    color: (hz - preset).abs() < 0.4
                        ? palette.onGold
                        : palette.gold,
                    fontWeight: FontWeight.w700,
                  ),
                  backgroundColor: Colors.transparent,
                  side: BorderSide(color: palette.gold),
                ),
            ],
          ),
          const SizedBox(height: 28),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: palette.card,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: palette.line),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: palette.gold, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l10n.standardFootnote,
                    style: TextStyle(color: palette.muted, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _label(double hz) {
    if ((hz - hz.round()).abs() < 0.05) return hz.round().toString();
    return hz.toStringAsFixed(1);
  }

  Widget _step(
    BuildContext context,
    IconData icon,
    String tooltip,
    VoidCallback onTap,
  ) {
    final palette = AppPalette.of(context);
    return IconButton.filledTonal(
      tooltip: tooltip,
      onPressed: onTap,
      icon: Icon(icon, color: palette.onGold),
      style: IconButton.styleFrom(backgroundColor: palette.gold),
    );
  }
}
