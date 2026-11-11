import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/main_shell.dart';
import '../screens/daftar_destinasi_screen.dart';
import '../screens/detail_destinasi_screen.dart';
import '../screens/tentang_screen.dart';
import '../screens/not_found_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  errorBuilder: (context, state) => const NotFoundScreen(),
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const DaftarDestinasiScreen(),
              routes: [
                GoRoute(
                  path: 'destinasi/:id',
                  builder: (context, state) {
                    final id = state.pathParameters['id'] ?? '';
                    return DetailDestinasiScreen(id: id);
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/tentang',
              builder: (context, state) => const TentangScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
