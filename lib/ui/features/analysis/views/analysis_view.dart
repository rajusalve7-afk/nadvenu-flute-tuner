import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../../core/labels.dart';
import '../../../core/theme/app_theme.dart';
import '../../tuner/view_models/tuner_view_model.dart';

class AnalysisView extends StatefulWidget {
  const AnalysisView({super.key, this.autostart = true});

  final bool autostart;

  @override
  State<AnalysisView> createState() => _AnalysisViewState();
}

class _AnalysisViewState extends State<AnalysisView> {
  var _harmonics = false;

  @override
  void initState() {
    super.initState();
    if (widget.autostart) {
      context.read<TunerViewModel>().ensureRunning();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = AppPalette.of(context);
    final tuner = context.watch<TunerViewModel>();
    final result = tuner.result;
    final swaras = tuner.settings.swarasVisible && result != null;
    return Scaffold(
      backgroundColor: palette.bg,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          children: [
            Text(
              l10n.analysisTitle,
              style: TextStyle(
                color: palette.ink,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: palette.card,
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  _toggle(l10n.spectrum, !_harmonics, palette, () {
                    setState(() => _harmonics = false);
                  }),
                  _toggle(l10n.harmonics, _harmonics, palette, () {
                    setState(() => _harmonics = true);
                  }),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 240,
              padding: const EdgeInsets.fromLTRB(8, 16, 12, 8),
              decoration: BoxDecoration(
                color: palette.cardAlt,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: palette.line),
              ),
              child: _harmonics
                  ? _HarmonicChart(spectrum: tuner.spectrum, color: palette.gold)
                  : _SpectrumChart(
                      spectrum: tuner.spectrum,
                      color: palette.gold,
                      grid: palette.line,
                    ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.detectedFrequency,
              style: TextStyle(color: palette.muted, fontSize: 12),
            ),
            Text(
              result == null
                  ? l10n.waitingForTone
                  : l10n.hzValue(result.frequencyHz.toStringAsFixed(1)),
              style: TextStyle(
                color: palette.gold,
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (result != null)
              Text(
                swaras
                    ? '${result.noteLabel} · ${swaraSyllable(l10n, result.swara)}'
                    : result.noteLabel,
                style: TextStyle(color: palette.ink, fontSize: 16),
              ),
            const SizedBox(height: 8),
            Text(
              result == null
                  ? l10n.confidence
                  : '${l10n.confidence} ${l10n.percentValue((result.confidence * 100).round())}',
              style: TextStyle(color: palette.muted),
            ),
            if (tuner.demo)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  l10n.demoBanner,
                  style: TextStyle(color: palette.gold, fontSize: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _toggle(String label, bool selected, AppPalette palette, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: selected ? palette.gold : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: selected ? palette.onGold : palette.muted,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _SpectrumChart extends StatelessWidget {
  const _SpectrumChart({
    required this.spectrum,
    required this.color,
    required this.grid,
  });

  final List<double> spectrum;
  final Color color;
  final Color grid;

  @override
  Widget build(BuildContext context) {
    final data = spectrum.isEmpty ? List<double>.filled(48, 0) : spectrum;
    var peak = 0.001;
    for (final value in data) {
      if (value > peak) peak = value;
    }
    final spots = [
      for (var i = 0; i < data.length; i++) FlSpot(i.toDouble(), data[i] / peak),
    ];
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: (data.length - 1).toDouble(),
        minY: 0,
        maxY: 1.05,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 0.25,
          getDrawingHorizontalLine: (_) => FlLine(color: grid, strokeWidth: 0.6),
          getDrawingVerticalLine: (_) => FlLine(color: grid, strokeWidth: 0.6),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              getTitlesWidget: (value, meta) => Text(
                value.toStringAsFixed(1),
                style: TextStyle(color: grid, fontSize: 9),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 12,
              getTitlesWidget: (value, meta) {
                const labels = {0: '80', 12: '250', 24: '800', 36: '2k'};
                final text = labels[value.round()] ?? '';
                return Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(text, style: TextStyle(color: grid, fontSize: 10)),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineTouchData: const LineTouchData(enabled: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: color,
            barWidth: 2,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: color.withValues(alpha: 0.18),
            ),
          ),
        ],
      ),
    );
  }
}

class _HarmonicChart extends StatelessWidget {
  const _HarmonicChart({required this.spectrum, required this.color});

  final List<double> spectrum;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final bars = List<double>.generate(8, (i) {
      if (spectrum.isEmpty) return 1 / (i + 1);
      final sample = spectrum[(i * 5) % spectrum.length];
      return (1 / (i + 1)) * (0.45 + sample);
    });
    var peak = 0.001;
    for (final bar in bars) {
      if (bar > peak) peak = bar;
    }
    return BarChart(
      BarChartData(
        maxY: 1,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          leftTitles: const AxisTitles(),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) => Text(
                '${value.toInt() + 1}',
                style: TextStyle(color: color, fontSize: 11),
              ),
            ),
          ),
        ),
        barGroups: [
          for (var i = 0; i < bars.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: bars[i] / peak,
                  color: color,
                  width: 14,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
