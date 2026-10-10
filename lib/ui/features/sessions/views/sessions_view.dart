import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/tuning_session.dart';
import '../../../../domain/tuning/tuning_math.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../core/labels.dart';
import '../../../core/theme/app_theme.dart';
import '../view_models/sessions_view_model.dart';

class SessionsView extends StatelessWidget {
  const SessionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = AppPalette.of(context);
    final sessions = context.watch<SessionsViewModel>().sessions;
    return Scaffold(
      backgroundColor: palette.bg,
      body: SafeArea(
        bottom: false,
        child: sessions.isEmpty
            ? _Empty(l10n: l10n, palette: palette)
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                itemCount: sessions.length + 1,
                separatorBuilder: (_, index) =>
                    index == 0 ? const SizedBox(height: 12) : const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Text(
                      l10n.tuningSessions,
                      style: TextStyle(
                        color: palette.ink,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  }
                  return _SessionTile(session: sessions[index - 1]);
                },
              ),
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.l10n, required this.palette});

  final AppLocalizations l10n;
  final AppPalette palette;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.folder_open_rounded, color: palette.gold, size: 42),
            const SizedBox(height: 12),
            Text(
              l10n.noSessions,
              style: TextStyle(
                color: palette.ink,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.noSessionsBody,
              textAlign: TextAlign.center,
              style: TextStyle(color: palette.muted),
            ),
          ],
        ),
      ),
    );
  }
}

class _SessionTile extends StatelessWidget {
  const _SessionTile({required this.session});

  final TuningSession session;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = AppPalette.of(context);
    final swara = TuningMath.swaraFor(
      midi: session.midi,
      saPitchClass: session.saPitchClass,
    );
    final note = TuningMath.noteLabel(session.midi);
    final syllable = swaraSyllable(l10n, swara);
    final variant = variantLabel(l10n, swara.variant);
    final swaraText = variant.isEmpty ? syllable : '$syllable ($variant)';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: palette.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: palette.line),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: palette.green.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.music_note_rounded, color: palette.green, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$note ($swaraText)',
                  style: TextStyle(
                    color: palette.ink,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  instrumentName(l10n, session.instrument),
                  style: TextStyle(color: palette.muted, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            _when(l10n, session.at),
            style: TextStyle(color: palette.muted, fontSize: 12),
          ),
        ],
      ),
    );
  }

  String _when(AppLocalizations l10n, DateTime at) {
    final local = at.toLocal();
    final now = DateTime.now();
    final hour = local.hour;
    final h = hour % 12 == 0 ? 12 : hour % 12;
    final minute = local.minute.toString().padLeft(2, '0');
    final clock = '$h:$minute ${hour >= 12 ? 'PM' : 'AM'}';
    final sameDay =
        local.year == now.year && local.month == now.month && local.day == now.day;
    if (sameDay) return l10n.todayTime(clock);
    return '${local.day}/${local.month}, $clock';
  }
}
