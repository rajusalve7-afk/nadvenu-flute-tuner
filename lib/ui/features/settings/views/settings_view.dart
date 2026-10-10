import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/app_settings.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../core/labels.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_page.dart';
import '../view_models/settings_view_model.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final settingsVm = context.watch<SettingsViewModel>();
    final settings = settingsVm.settings;
    final palette = AppPalette.of(context);
    return AppPage(
      title: l10n.settingsTitle,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        children: [
          SectionLabel(l10n.sectionTuning),
          GoldCard(
            child: Column(
              children: [
                _Row(
                  title: l10n.referenceFrequency,
                  value: l10n.hzValue(_hz(settings.a4Hz)),
                  onTap: () => context.push('/reference'),
                ),
                Divider(color: palette.line, height: 1),
                _Row(
                  title: l10n.tuningTolerance,
                  value: l10n.toleranceValue(settings.toleranceCents.round()),
                  onTap: () => _editTolerance(context, settingsVm),
                ),
                Divider(color: palette.line, height: 1),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.sensitivity, style: TextStyle(color: palette.ink)),
                      Slider(
                        value: settings.sensitivity.index.toDouble(),
                        min: 0,
                        max: 2,
                        divisions: 2,
                        label: switch (settings.sensitivity) {
                          Sensitivity.low => l10n.low,
                          Sensitivity.medium => l10n.medium,
                          Sensitivity.high => l10n.high,
                        },
                        onChanged: (value) {
                          settingsVm.setSensitivity(
                            Sensitivity.values[value.round()],
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(l10n.low, style: TextStyle(color: palette.muted, fontSize: 12)),
                          Text(l10n.medium, style: TextStyle(color: palette.gold, fontSize: 12)),
                          Text(l10n.high, style: TextStyle(color: palette.muted, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(color: palette.line, height: 1),
                _Row(
                  title: l10n.tuningMode,
                  value: settings.temperament == Temperament.equal
                      ? l10n.equalTemperament
                      : l10n.justIntonation,
                  onTap: () => _editTemperament(context, settingsVm),
                ),
              ],
            ),
          ),
          SectionLabel(l10n.sectionPreferences),
          GoldCard(
            child: Column(
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.darkTheme),
                  value: settings.darkTheme,
                  onChanged: settingsVm.setDarkTheme,
                ),
                Divider(color: palette.line, height: 1),
                _Row(
                  title: l10n.language,
                  value: languageLabel(l10n, settings.languageCode),
                  onTap: () => context.push('/language'),
                ),
                Divider(color: palette.line, height: 1),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.showSwaras),
                  value: settings.showIndianSwaras,
                  onChanged: settingsVm.setShowSwaras,
                ),
                Divider(color: palette.line, height: 1),
                _Row(
                  title: l10n.defaultInstrument,
                  value: instrumentName(l10n, settings.instrument),
                  onTap: () => context.push('/instruments'),
                ),
              ],
            ),
          ),
          SectionLabel(l10n.sectionAbout),
          GoldCard(
            child: Column(
              children: [
                _Row(
                  title: l10n.privacyPolicy,
                  onTap: () => context.push('/privacy'),
                ),
                Divider(color: palette.line, height: 1),
                _Row(title: l10n.rateUs, onTap: () => context.push('/rate')),
                Divider(color: palette.line, height: 1),
                _Row(title: l10n.appVersion, value: l10n.versionLabel),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _hz(double hz) {
    if ((hz - hz.round()).abs() < 0.05) return hz.round().toString();
    return hz.toStringAsFixed(1);
  }

  Future<void> _editTolerance(
    BuildContext context,
    SettingsViewModel settings,
  ) async {
    final l10n = AppLocalizations.of(context);
    var cents = settings.settings.toleranceCents;
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final palette = AppPalette.of(context);
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.tuningTolerance,
                    style: TextStyle(
                      color: palette.ink,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.toleranceValue(cents.round()),
                    style: TextStyle(color: palette.gold, fontSize: 22),
                  ),
                  Slider(
                    value: cents,
                    min: 1,
                    max: 20,
                    divisions: 19,
                    onChanged: (value) => setState(() => cents = value),
                    onChangeEnd: settings.setTolerance,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _editTemperament(
    BuildContext context,
    SettingsViewModel settings,
  ) async {
    final l10n = AppLocalizations.of(context);
    final next = settings.settings.temperament == Temperament.equal
        ? Temperament.just
        : Temperament.equal;
    if (next == Temperament.just && !settings.settings.proPreview) {
      await showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(l10n.nadvenuPro),
            content: Text(l10n.proRequired),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.close),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.push('/pro');
                },
                child: Text(l10n.goPro),
              ),
            ],
          );
        },
      );
      return;
    }
    await settings.setTemperament(next);
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.title, this.value, this.onTap});

  final String title;
  final String? value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Expanded(
              child: Text(title, style: TextStyle(color: palette.ink)),
            ),
            if (value != null)
              Flexible(
                child: Text(
                  value!,
                  textAlign: TextAlign.end,
                  style: TextStyle(color: palette.muted),
                ),
              ),
            if (onTap != null) ...[
              const SizedBox(width: 4),
              Icon(Icons.chevron_right, color: palette.muted, size: 20),
            ],
          ],
        ),
      ),
    );
  }
}
