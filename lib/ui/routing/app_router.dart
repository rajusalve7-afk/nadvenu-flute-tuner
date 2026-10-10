import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/analysis/views/analysis_view.dart';
import '../features/instruments/views/instrument_select_view.dart';
import '../features/language/views/language_view.dart';
import '../features/legal/views/info_pages.dart';
import '../features/pro/views/go_pro_view.dart';
import '../features/reference/views/reference_view.dart';
import '../features/sessions/views/sessions_view.dart';
import '../features/settings/views/settings_view.dart';
import '../features/splash/views/splash_view.dart';
import '../features/tuner/views/tuner_view.dart';
import '../shell/app_shell.dart';

GoRouter createRouter() {
  return GoRouter(
    initialLocation: '/',
    errorBuilder: (context, state) {
      return Scaffold(
        body: Center(child: Text(state.error?.toString() ?? 'Not found')),
      );
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/tuner',
                builder: (context, state) => const TunerView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/analysis',
                builder: (context, state) => const AnalysisView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/sessions',
                builder: (context, state) => const SessionsView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsView(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/instruments',
        builder: (context, state) => const InstrumentSelectView(),
      ),
      GoRoute(path: '/pro', builder: (context, state) => const GoProView()),
      GoRoute(
        path: '/language',
        builder: (context, state) => const LanguageView(),
      ),
      GoRoute(
        path: '/reference',
        builder: (context, state) => const ReferenceView(),
      ),
      GoRoute(
        path: '/privacy',
        builder: (context, state) => const PrivacyView(),
      ),
      GoRoute(path: '/share', builder: (context, state) => const ShareView()),
      GoRoute(path: '/rate', builder: (context, state) => const RateView()),
    ],
  );
}
