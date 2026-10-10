import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../../core/theme/app_theme.dart';

class TunerDrawer extends StatelessWidget {
  const TunerDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = AppPalette.of(context);
    final items = <_DrawerItem>[
      _DrawerItem(Icons.workspace_premium_outlined, l10n.goPro, '/pro', false),
      _DrawerItem(Icons.settings_outlined, l10n.settingsTitle, '/settings', true),
      _DrawerItem(Icons.folder_open_rounded, l10n.tuningSessions, '/sessions', true),
      _DrawerItem(Icons.bar_chart_rounded, l10n.analysisTitle, '/analysis', true),
      _DrawerItem(Icons.share_outlined, l10n.shareApp, '/share', false),
      _DrawerItem(Icons.star_border_rounded, l10n.rateUs, '/rate', false),
      _DrawerItem(Icons.shield_outlined, l10n.privacyPolicy, '/privacy', false),
    ];
    return Drawer(
      backgroundColor: palette.cardAlt,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 8, 12),
              child: Row(
                children: [
                  const Icon(Icons.music_note_rounded, size: 28),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nadvenu', style: AppTheme.brand(context, size: 20)),
                        Text(
                          l10n.productName,
                          style: TextStyle(color: palette.muted, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: l10n.close,
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, color: palette.ink),
                  ),
                ],
              ),
            ),
            Divider(color: palette.line, height: 1),
            for (final item in items)
              ListTile(
                leading: Icon(item.icon, color: palette.gold),
                title: Text(
                  item.label,
                  style: TextStyle(
                    color: palette.ink,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  final router = GoRouter.of(context);
                  Navigator.pop(context);
                  if (item.replace) {
                    router.go(item.path);
                  } else {
                    router.push(item.path);
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem {
  const _DrawerItem(this.icon, this.label, this.path, this.replace);

  final IconData icon;
  final String label;
  final String path;
  final bool replace;
}
