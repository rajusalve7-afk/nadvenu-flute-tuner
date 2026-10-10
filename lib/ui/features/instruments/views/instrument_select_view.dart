import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/app_settings.dart';
import '../../../../domain/models/instrument.dart';
import '../../../../domain/tuning/tuning_math.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../core/labels.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/flute_art.dart';
import '../../settings/view_models/settings_view_model.dart';

class InstrumentSelectView extends StatelessWidget {
  const InstrumentSelectView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = AppPalette.of(context);
    final settings = context.watch<SettingsViewModel>();
    final selected = settings.settings.instrument;
    return AppPage(
      title: l10n.selectInstrument,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          for (final id in InstrumentId.values) ...[
            _InstrumentTile(
              id: id,
              selected: id == selected,
              onTap: () async {
                await settings.setInstrument(id);
                if (context.mounted) context.pop();
              },
            ),
            const SizedBox(height: 10),
          ],
          Text(
            l10n.rangeSpan(
              TuningMath.noteLabel(InstrumentRange.of(selected).lowMidi),
              TuningMath.noteLabel(InstrumentRange.of(selected).highMidi),
            ),
            textAlign: TextAlign.center,
            style: TextStyle(color: palette.muted, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _InstrumentTile extends StatelessWidget {
  const _InstrumentTile({
    required this.id,
    required this.selected,
    required this.onTap,
  });

  final InstrumentId id;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = AppPalette.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            color: palette.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? palette.gold : palette.line,
              width: selected ? 1.6 : 1,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              FluteArt(instrument: id),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      instrumentName(l10n, id),
                      style: TextStyle(
                        color: palette.ink,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      instrumentDescription(l10n, id),
                      style: TextStyle(color: palette.muted, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Icon(
                selected ? Icons.radio_button_checked : Icons.radio_button_off,
                color: selected ? palette.gold : palette.muted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
