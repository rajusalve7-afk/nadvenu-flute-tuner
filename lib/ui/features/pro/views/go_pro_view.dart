import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_page.dart';
import '../../settings/view_models/settings_view_model.dart';

class GoProView extends StatelessWidget {
  const GoProView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = AppPalette.of(context);
    final settings = context.watch<SettingsViewModel>();
    final unlocked = settings.settings.proPreview;
    final benefits = [
      (Icons.block, l10n.benefitAdFreeTitle, l10n.benefitAdFreeBody),
      (Icons.tune, l10n.benefitModesTitle, l10n.benefitModesBody),
      (Icons.bar_chart_rounded, l10n.benefitAnalysisTitle, l10n.benefitAnalysisBody),
      (Icons.all_inclusive, l10n.benefitSessionsTitle, l10n.benefitSessionsBody),
      (Icons.library_music_outlined, l10n.benefitProfilesTitle, l10n.benefitProfilesBody),
      (Icons.favorite_outline, l10n.benefitSupportTitle, l10n.benefitSupportBody),
    ];
    return AppPage(
      title: l10n.goPro,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          const Icon(Icons.workspace_premium, size: 54),
          const SizedBox(height: 8),
          Text(
            l10n.nadvenuPro,
            textAlign: TextAlign.center,
            style: AppTheme.brand(context, size: 32),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.unlockPotential,
            textAlign: TextAlign.center,
            style: TextStyle(color: palette.muted),
          ),
          const SizedBox(height: 18),
          for (final benefit in benefits)
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: palette.gold.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(benefit.$1, color: palette.gold),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          benefit.$2,
                          style: TextStyle(
                            color: palette.ink,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          benefit.$3,
                          style: TextStyle(color: palette.muted, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: unlocked
                ? null
                : () async {
                    await settings.setProPreview(true);
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.upgradeDone)),
                    );
                  },
            icon: const Icon(Icons.workspace_premium),
            label: Text(unlocked ? l10n.proActive : l10n.upgradeToPro),
            style: FilledButton.styleFrom(
              backgroundColor: palette.gold,
              foregroundColor: palette.onGold,
              disabledBackgroundColor: palette.gold.withValues(alpha: 0.45),
              disabledForegroundColor: palette.onGold,
              minimumSize: const Size.fromHeight(52),
              textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () async {
              await settings.setProPreview(true);
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.restoreDone)),
              );
            },
            child: Text(l10n.restorePurchase),
          ),
          Text(
            l10n.proPreviewNote,
            textAlign: TextAlign.center,
            style: TextStyle(color: palette.muted, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
