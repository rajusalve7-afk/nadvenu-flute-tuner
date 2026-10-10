import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_page.dart';
import '../../settings/view_models/settings_view_model.dart';

class PrivacyView extends StatelessWidget {
  const PrivacyView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = AppPalette.of(context);
    return AppPage(
      title: l10n.privacyTitle,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          Text(
            'Nadvenu Flutes',
            style: AppTheme.brand(context, size: 22),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.privacyBody,
            style: TextStyle(color: palette.ink, height: 1.45, fontSize: 15),
          ),
        ],
      ),
    );
  }
}

class ShareView extends StatelessWidget {
  const ShareView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = AppPalette.of(context);
    return AppPage(
      title: l10n.shareTitle,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.shareMessage,
              style: TextStyle(color: palette.ink, height: 1.4, fontSize: 16),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: l10n.shareMessage));
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.shareCopied)),
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: palette.gold,
                foregroundColor: palette.onGold,
                minimumSize: const Size.fromHeight(48),
              ),
              child: Text(l10n.copyText),
            ),
          ],
        ),
      ),
    );
  }
}

class RateView extends StatefulWidget {
  const RateView({super.key});

  @override
  State<RateView> createState() => _RateViewState();
}

class _RateViewState extends State<RateView> {
  late int _stars;

  @override
  void initState() {
    super.initState();
    _stars = context.read<SettingsViewModel>().settings.savedRating;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = AppPalette.of(context);
    final settings = context.read<SettingsViewModel>();
    return AppPage(
      title: l10n.rateTitle,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              l10n.rateBody,
              style: TextStyle(color: palette.ink, height: 1.4),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 1; i <= 5; i++)
                  IconButton(
                    tooltip: '$i',
                    onPressed: () => setState(() => _stars = i),
                    icon: Icon(
                      i <= _stars ? Icons.star_rounded : Icons.star_border_rounded,
                      color: palette.gold,
                      size: 36,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: _stars == 0
                  ? null
                  : () async {
                      await settings.setRating(_stars);
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.rateThanks)),
                      );
                    },
              style: FilledButton.styleFrom(
                backgroundColor: palette.gold,
                foregroundColor: palette.onGold,
                minimumSize: const Size.fromHeight(48),
              ),
              child: Text(l10n.submitRating),
            ),
          ],
        ),
      ),
    );
  }
}
