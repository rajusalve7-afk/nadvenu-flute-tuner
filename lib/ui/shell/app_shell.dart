import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/generated/app_localizations.dart';
import '../core/theme/app_theme.dart';
import '../features/tuner/views/tuner_drawer.dart';

class DrawerHost extends InheritedWidget {
  const DrawerHost({
    super.key,
    required this.scaffoldKey,
    required super.child,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;

  static void open(BuildContext context) {
    context
        .getInheritedWidgetOfExactType<DrawerHost>()
        ?.scaffoldKey
        .currentState
        ?.openEndDrawer();
  }

  @override
  bool updateShouldNotify(DrawerHost oldWidget) =>
      scaffoldKey != oldWidget.scaffoldKey;
}

class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = AppPalette.of(context);
    final index = widget.navigationShell.currentIndex;
    final items = [
      (Icons.mic_none_rounded, l10n.navTuner),
      (Icons.bar_chart_rounded, l10n.navAnalysis),
      (Icons.folder_open_rounded, l10n.navSessions),
      (Icons.settings_outlined, l10n.navSettings),
    ];
    return DrawerHost(
      scaffoldKey: _scaffoldKey,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: palette.bg,
        endDrawer: const TunerDrawer(),
        body: widget.navigationShell,
        bottomNavigationBar: DecoratedBox(
          decoration: BoxDecoration(
            color: palette.card,
            border: Border(top: BorderSide(color: palette.line)),
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: 64,
              child: Row(
                children: [
                  for (var i = 0; i < items.length; i++)
                    Expanded(
                      child: InkWell(
                        onTap: () => _goBranch(i),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              items[i].$1,
                              color: i == index ? palette.gold : palette.muted,
                              size: 22,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              items[i].$2,
                              style: TextStyle(
                                color: i == index ? palette.gold : palette.muted,
                                fontSize: 11,
                                fontWeight: i == index
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
