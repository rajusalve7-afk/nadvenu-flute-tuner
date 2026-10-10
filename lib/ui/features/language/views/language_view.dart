import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../../core/labels.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_page.dart';
import '../../settings/view_models/settings_view_model.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({super.key});

  static const _flags = {
    'en': '🇬🇧',
    'hi': '🇮🇳',
    'mr': '🇮🇳',
    'gu': '🇮🇳',
    'bn': '🇧🇩',
    'ta': '🇮🇳',
    'te': '🇮🇳',
  };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = AppPalette.of(context);
    final settings = context.watch<SettingsViewModel>();
    final current = settings.settings.languageCode;
    return AppPage(
      title: l10n.selectLanguage,
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        itemCount: supportedLanguageCodes.length,
        separatorBuilder: (_, _) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final code = supportedLanguageCodes[index];
          final selected = code == current;
          return Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () => settings.setLanguage(code),
              child: Ink(
                decoration: BoxDecoration(
                  color: palette.card,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: selected ? palette.gold : palette.line),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Row(
                  children: [
                    Text(_flags[code] ?? '', style: const TextStyle(fontSize: 22)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        languageLabel(l10n, code),
                        style: TextStyle(
                          color: palette.ink,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Icon(
                      selected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: selected ? palette.gold : palette.muted,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
