// Copyright 2023, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'screens/level_selection.dart';
import 'screens/main_menu_screen.dart';
import 'settings/settings_screen.dart';
import 'style/my_transition.dart';
import 'style/palette.dart';
import 'screens/memory_match_page.dart';
import 'screens/win_game_screen.dart';

/// The router describes the game's navigational hierarchy, from the main
/// screen through settings screens all the way to each individual level.
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainMenuScreen(key: Key('main menu')),
      routes: [
        GoRoute(
            path: 'play',
            pageBuilder: (context, state) => buildMyTransition<void>(
                  key: const ValueKey('play'),
                  color: context.watch<Palette>().yellow,
                  child: const LevelSelectionScreen(
                    key: Key('level selection'),
                  ),
                ),
            routes: [
              GoRoute(
                path: 'won',
                redirect: (context, state) {
                  if (state.extra == null) {
                    // Trying to navigate to a win screen without any data.
                    // Possibly by using the browser's back button.
                    return '/';
                  }

                  // Otherwise, do not redirect.
                  return null;
                },
                pageBuilder: (context, state) {
                  final map = state.extra! as Map<String, dynamic>;
                  final int score =
                      map['score'] as int; // Ensure it's an integer

                  return buildMyTransition<void>(
                    key: const ValueKey('won'),
                    color: context.watch<Palette>().backgroundPlaySession,
                    child: WinGameScreen(
                      score: score,
                      key: const Key('win game'),
                    ),
                  );
                },
              )
            ]),
        GoRoute(
          path: 'settings',
          builder: (context, state) =>
              const SettingsScreen(key: Key('settings')),
        ),
        GoRoute(
          path: '/level/:levelId',
          builder: (context, state) {
            final levelId = state.pathParameters['levelId'];
            return levelId != null
                ? MemoryMatchPage(gameLevel: int.parse(levelId))
                : const Scaffold(
                    body: Center(child: Text('Invalid level ID')),
                  );
          },
        ),
      ],
    ),
  ],
);
