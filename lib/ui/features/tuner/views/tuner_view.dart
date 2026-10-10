import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/instrument.dart';
import '../../../../domain/tuning/tuning_math.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../core/labels.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/cents_gauge.dart';
import '../../../core/widgets/waveform_strip.dart';
import '../../../shell/app_shell.dart';
import '../../settings/view_models/settings_view_model.dart';
import '../view_models/tuner_view_model.dart';

class TunerView extends StatefulWidget {
  const TunerView({super.key, this.autostart = true});

  final bool autostart;

  @override
  State<TunerView> createState() => _TunerViewState();
}

class _TunerViewState extends State<TunerView> {
  @override
  void initState() {
    super.initState();
    final tuner = context.read<TunerViewModel>();
    tuner.addListener(_onTuner);
    if (widget.autostart) {
      tuner.ensureRunning();
    }
  }

  @override
  void dispose() {
    context.read<TunerViewModel>().removeListener(_onTuner);
    super.dispose();
  }

  void _onTuner() {
    if (!mounted) return;
    final tuner = context.read<TunerViewModel>();
    final l10n = AppLocalizations.of(context);
    final lock = tuner.takeLockNote();
    final micFailed = tuner.takeMicFailure();
    if (lock != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.sessionLocked(lock))),
      );
    }
    if (micFailed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.micUnavailable)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tuner = context.watch<TunerViewModel>();
    final settings = context.watch<SettingsViewModel>();
    final l10n = AppLocalizations.of(context);
    final palette = AppPalette.of(context);
    final result = tuner.result;
    final prefs = settings.settings;
    final range = InstrumentRange.of(prefs.instrument);
    final showSwara = result != null && prefs.swarasVisible;
    final headline = result == null
        ? '—'
        : (showSwara
              ? swaraSyllable(l10n, result.swara)
              : result.noteLabel);
    final variant = result != null && prefs.swarasVisible
        ? variantLabel(l10n, result.swara.variant)
        : '';
    final outside = result != null && !range.contains(result.midi);

    return Scaffold(
      backgroundColor: palette.bg,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
          children: [
            Row(
              children: [
                const Icon(Icons.music_note_rounded, size: 28),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Nadvenu', style: AppTheme.brand(context, size: 20)),
                          if (prefs.proPreview) ...[
                            const SizedBox(width: 6),
                            Icon(Icons.workspace_premium, size: 16, color: palette.gold),
                          ],
                        ],
                      ),
                      Text(
                        l10n.productName,
                        style: TextStyle(color: palette.muted, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: l10n.openMenu,
                  onPressed: () => DrawerHost.open(context),
                  icon: Icon(Icons.menu_rounded, color: palette.ink),
                ),
                IconButton(
                  tooltip: l10n.settingsTitle,
                  onPressed: () => context.go('/settings'),
                  icon: Icon(Icons.settings_outlined, color: palette.ink),
                ),
              ],
            ),
            if (tuner.demo)
              Container(
                key: const Key('demo-banner'),
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: palette.gold.withValues(alpha: 0.7)),
                  color: palette.gold.withValues(alpha: 0.08),
                ),
                child: Text(
                  l10n.demoBanner,
                  style: TextStyle(color: palette.gold, fontSize: 12.5),
                ),
              ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => context.push('/instruments'),
                child: Ink(
                  decoration: BoxDecoration(
                    color: palette.card,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: palette.line),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.instrumentLabel,
                              style: TextStyle(color: palette.muted, fontSize: 11),
                            ),
                            Text(
                              instrumentName(l10n, prefs.instrument),
                              key: const Key('instrument-name'),
                              style: TextStyle(
                                color: palette.ink,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              l10n.rangeSpan(
                                TuningMath.noteLabel(range.lowMidi),
                                TuningMath.noteLabel(range.highMidi),
                              ),
                              style: TextStyle(color: palette.gold, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.expand_more, color: palette.muted),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.rootScale,
              style: TextStyle(color: palette.muted, fontSize: 12),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: TuningMath.pitchNames.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final selected = prefs.saPitchClass == index;
                  return ChoiceChip(
                    key: Key('root-chip-$index'),
                    label: Text(TuningMath.pitchNames[index]),
                    selected: selected,
                    showCheckmark: false,
                    labelStyle: TextStyle(
                      color: selected ? palette.onGold : palette.gold,
                      fontWeight: FontWeight.w700,
                    ),
                    selectedColor: palette.gold,
                    backgroundColor: Colors.transparent,
                    side: BorderSide(color: palette.gold.withValues(alpha: 0.7)),
                    onSelected: (_) => settings.setRoot(index),
                  );
                },
              ),
            ),
            const SizedBox(height: 4),
            CentsGauge(
              cents: result?.cents ?? 0,
              inTune: result?.inTune ?? false,
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  headline,
                  key: const Key('swara-label'),
                  style: TextStyle(
                    fontFamily: showSwara ? 'Cinzel' : 'Outfit',
                    fontSize: showSwara ? 56 : 48,
                    height: 1,
                    color: palette.ink,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (showSwara) ...[
                  const SizedBox(width: 8),
                  Text(
                    result.noteLabel,
                    key: const Key('note-label'),
                    style: TextStyle(color: palette.muted, fontSize: 20),
                  ),
                ],
              ],
            ),
            if (variant.isNotEmpty)
              Text(
                variant,
                textAlign: TextAlign.center,
                style: TextStyle(color: palette.gold, fontSize: 12),
              ),
            const SizedBox(height: 4),
            Text(
              result == null
                  ? l10n.waitingForTone
                  : l10n.hzValue(result.frequencyHz.toStringAsFixed(1)),
              key: const Key('detected-hz'),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: palette.gold,
                fontSize: 26,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (result != null)
              Text(
                l10n.targetHz(result.targetHz.toStringAsFixed(1)),
                textAlign: TextAlign.center,
                style: TextStyle(color: palette.muted, fontSize: 13),
              ),
            const SizedBox(height: 10),
            Center(
              child: Container(
                key: const Key('status-pill'),
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                decoration: BoxDecoration(
                  color: result == null
                      ? palette.card
                      : (result.inTune ? palette.green : palette.red),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  result == null
                      ? (tuner.micLive ? l10n.listening : l10n.waitingForTone)
                      : statusLabel(l10n, result.status),
                  style: TextStyle(
                    color: result == null ? palette.muted : Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            if (outside)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  l10n.outsideRange,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: palette.muted, fontSize: 12),
                ),
              ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: palette.card,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: palette.line),
              ),
              child: Row(
                children: [
                  _Stat(
                    value: result == null ? '—' : _cents(result.cents),
                    label: l10n.cents,
                  ),
                  _divider(palette),
                  _Stat(
                    value: result == null
                        ? '—'
                        : l10n.percentValue((result.confidence * 100).round()),
                    label: l10n.confidence,
                  ),
                  _divider(palette),
                  _Stat(
                    value: l10n.hzValue(_whole(prefs.a4Hz)),
                    label: l10n.a4Reference,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            WaveformStrip(samples: tuner.waveform),
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  Material(
                    color: Colors.transparent,
                    shape: const CircleBorder(),
                    child: InkWell(
                      key: const Key('mic-button'),
                      customBorder: const CircleBorder(),
                      onTap: tuner.toggleInput,
                      child: Ink(
                        width: 74,
                        height: 74,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: palette.gold, width: 2),
                          color: tuner.micLive
                              ? palette.gold.withValues(alpha: 0.16)
                              : Colors.transparent,
                          boxShadow: [
                            BoxShadow(
                              color: palette.gold.withValues(alpha: 0.35),
                              blurRadius: 18,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.mic_rounded,
                          color: palette.gold,
                          size: 34,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    tuner.micLive ? l10n.listening : l10n.demoBanner,
                    style: TextStyle(color: palette.muted, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider(AppPalette palette) {
    return Container(width: 1, height: 36, color: palette.line);
  }

  String _cents(double cents) {
    final rounded = cents.round();
    if (rounded > 0) return '+$rounded';
    return '$rounded';
  }

  String _whole(double hz) {
    if ((hz - hz.round()).abs() < 0.05) return hz.round().toString();
    return hz.toStringAsFixed(1);
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: palette.ink,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(color: palette.muted, fontSize: 11)),
        ],
      ),
    );
  }
}
