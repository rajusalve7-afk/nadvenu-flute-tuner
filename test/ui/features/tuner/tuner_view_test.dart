import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nadvenu_flute_tuner/data/repositories/session_repository.dart';
import 'package:nadvenu_flute_tuner/data/repositories/settings_repository.dart';
import 'package:nadvenu_flute_tuner/data/services/key_value_store.dart';
import 'package:nadvenu_flute_tuner/data/services/pitch_capture_service.dart';
import 'package:nadvenu_flute_tuner/domain/models/pitch_frame.dart';
import 'package:nadvenu_flute_tuner/domain/tuning/tuning_math.dart';
import 'package:nadvenu_flute_tuner/l10n/generated/app_localizations.dart';
import 'package:nadvenu_flute_tuner/ui/features/sessions/view_models/sessions_view_model.dart';
import 'package:nadvenu_flute_tuner/ui/features/settings/view_models/settings_view_model.dart';
import 'package:nadvenu_flute_tuner/ui/features/tuner/view_models/tuner_view_model.dart';
import 'package:nadvenu_flute_tuner/ui/features/tuner/views/tuner_view.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('tuner shows Sa for C4 and komal Ni when Sa moves to D', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(400, 980);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final settingsRepository = SettingsRepository(MemoryStore());
    final sessionRepository = SessionRepository(MemoryStore());
    await sessionRepository.load();
    final settings = SettingsViewModel(settingsRepository);
    final sessions = SessionsViewModel(sessionRepository);
    final tuner = TunerViewModel(
      settings: settings,
      sessions: sessionRepository,
      pitch: PitchCaptureService(),
    );
    final c4 = TuningMath.midiToFrequency(60, 440);
    tuner.previewFrame(
      PitchFrame(
        frequencyHz: c4,
        confidence: 0.98,
        waveform: const [0, 0.4, 0, -0.4],
        spectrum: const [0.1, 0.8, 0.3],
        demo: true,
        at: DateTime(2026, 10, 10, 10, 30),
      ),
    );

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: settings),
          ChangeNotifierProvider.value(value: sessions),
          ChangeNotifierProvider.value(value: tuner),
        ],
        child: const MaterialApp(
          locale: Locale('en'),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: TunerView(autostart: false),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Sa'), findsOneWidget);
    expect(find.text('C4'), findsOneWidget);
    expect(find.text('In Tune'), findsOneWidget);
    expect(find.text('Indian Bansuri'), findsOneWidget);
    expect(find.textContaining('261.6'), findsWidgets);
    expect(find.text('Demo mode — simulated pitch'), findsWidgets);

    await tester.tap(find.byKey(const Key('root-chip-2')));
    await tester.pumpAndSettle();

    expect(find.text('Ni'), findsOneWidget);
    expect(find.text('komal'), findsOneWidget);
    expect(find.text('C4'), findsOneWidget);
    expect(find.text('In Tune'), findsOneWidget);
  });
}
