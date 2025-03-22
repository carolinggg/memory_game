import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';

import '../models/game.dart';
import '../widgets/game_timer.dart';
import '../widgets/memory_card.dart';
import '../widgets/restart_game.dart';

class MemoryMatchPage extends StatefulWidget {
  const MemoryMatchPage({
    required this.gameLevel,
    super.key,
  });

  final int gameLevel;

  @override
  State<MemoryMatchPage> createState() => _MemoryMatchPageState();
}

class _MemoryMatchPageState extends State<MemoryMatchPage> {
  late Timer timer;
  late Game game;
  late Duration duration;

  @override
  void initState() {
    super.initState();
    game = Game(widget.gameLevel);
    duration = const Duration();
    startTimer();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return; // Check if widget is still in the tree
      setState(() {
        final seconds = duration.inSeconds + 1;
        duration = Duration(seconds: seconds);
      });
      if (game.isGameOver) {
        timer.cancel();
        // _showGameOverDialog();
        GoRouter.of(context)
            .go('/play/won', extra: {'score': duration.inSeconds});
      }
    });
  }

  pauseTimer() {
    timer.cancel();
  }

  void _resetGame() {
    game.resetGame();
    setState(() {
      timer.cancel();
      duration = const Duration();
      startTimer();
    });
  }

  // void _showGameOverDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text("Game Over!"),
  //       content: Text("You finished Level ${widget.gameLevel} in ${duration.inSeconds} seconds."),
  //       actions: [
  //         TextButton(
  //           onPressed: () => GoRouter.of(context).go('/'),
  //           child: const Text("Go to Home"),
  //         ),
  //         TextButton(
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //             _resetGame();
  //           },
  //           child: const Text("Restart Level"),
  //         ),
  //         TextButton(
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //             GoRouter.of(context).go('/level/${widget.gameLevel + 1}');
  //           },
  //           child: const Text("Next Level"),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assets/images/logo.png",
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: GameTimer(time: duration),
            ),
            Expanded(
              flex: 3,
              child: GridView.count(
                crossAxisCount: game.gridSize,
                children: List.generate(
                  game.cards.length,
                  (index) {
                    return MemoryCard(
                      card: game.cards[index],
                      index: index,
                      onCardPressed: game.onCardPressed,
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 48.0),
              child: RestartGame(
                isGameOver: game.isGameOver,
                pauseGame: () => pauseTimer(),
                restartGame: () => _resetGame(),
                continueGame: () => startTimer(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
