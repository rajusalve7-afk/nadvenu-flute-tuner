import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'data/repositories/session_repository.dart';
import 'data/repositories/settings_repository.dart';
import 'data/services/key_value_store.dart';
import 'data/services/pitch_capture_service.dart';
import 'ui/features/sessions/view_models/sessions_view_model.dart';
import 'ui/features/settings/view_models/settings_view_model.dart';
import 'ui/features/tuner/view_models/tuner_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  final prefs = await SharedPreferences.getInstance();
  final store = PreferencesStore(prefs);
  final settingsRepository = SettingsRepository(store);
  final sessionRepository = SessionRepository(store);
  await settingsRepository.load();
  await sessionRepository.load();
  final settings = SettingsViewModel(settingsRepository);
  final sessions = SessionsViewModel(sessionRepository);
  final pitch = PitchCaptureService();
  final tuner = TunerViewModel(
    settings: settings,
    sessions: sessionRepository,
    pitch: pitch,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: settings),
        ChangeNotifierProvider.value(value: sessions),
        ChangeNotifierProvider.value(value: tuner),
      ],
      child: const NadvenuApp(),
    ),
  );
}
