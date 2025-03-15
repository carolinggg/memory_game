import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/constants.dart';
import '../pages/memory_match_page.dart';
import 'game_button.dart';

class GameOptions extends StatelessWidget {
  const GameOptions({Key? key}) : super(key: key);

  static Route<dynamic> _routeBuilder(BuildContext context, int gameLevel) {
    return MaterialPageRoute(
      builder: (_) {
        return MemoryMatchPage(gameLevel: gameLevel);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: gameLevels.map((level) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: GameButton(
            onPressed: () =>
                GoRouter.of(context).go('/level/${level['level']}'),
            title: level['title'],
            color: level['color']![700]!,
            width: 250,
          ),
        );
      }).toList(),
    );
  }
}
