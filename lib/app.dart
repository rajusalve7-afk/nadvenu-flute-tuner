import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'l10n/generated/app_localizations.dart';
import 'ui/core/theme/app_theme.dart';
import 'ui/core/widgets/phone_frame.dart';
import 'ui/features/settings/view_models/settings_view_model.dart';
import 'ui/routing/app_router.dart';

class NadvenuApp extends StatefulWidget {
  const NadvenuApp({super.key});

  @override
  State<NadvenuApp> createState() => _NadvenuAppState();
}

class _NadvenuAppState extends State<NadvenuApp> {
  late final _router = createRouter();

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsViewModel>();
    return MaterialApp.router(
      title: 'Nadvenu Flute Tuner Pro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: settings.darkTheme ? ThemeMode.dark : ThemeMode.light,
      locale: Locale(settings.languageCode),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: _router,
      builder: (context, child) {
        return PhoneFrame(child: child ?? const SizedBox.shrink());
      },
    );
  }
}
