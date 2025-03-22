import 'dart:math'; // ✅ Import Random for randomizing text
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../settings/settings.dart';
import '../style/my_button.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';
import '../style/confetti.dart';

class WinGameScreen extends StatefulWidget {
  final int score;

  const WinGameScreen({
    super.key,
    required this.score,
  });

  @override
  _WinGameScreenState createState() => _WinGameScreenState();
}

class _WinGameScreenState extends State<WinGameScreen> {
  bool _showConfetti = false;
  late String _winningText; // ✅ Variable to store randomized text
  late String _playerName; // ✅ Variable to store player name

  final List<String> _winningMessages = [
    "You won",
    "Great",
    "Incredible",
    "Awesome",
    "Fantastic",
    "Unstoppable",
    "Legendary",
    "You did it",
    "Victory",
    "Champion",
  ];

  @override
  void initState() {
    super.initState();

    // ✅ Select a random winning message
    _winningText = _winningMessages[Random().nextInt(_winningMessages.length)];

    // ✅ Get player name from settings
    _playerName = context.read<SettingsController>().playerName.value;

    // ✅ Play celebration sound when the screen loads
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        context.read<AudioController>().playSfx(SfxType.congrats);
      }
    });

    // ✅ Start celebration animation
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _showConfetti = true;
        });
      }
    });

    // ✅ Stop confetti after 4 seconds
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          _showConfetti = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    return Scaffold(
      backgroundColor: palette.backgroundPlaySession,
      body: Stack(
        children: [
          ResponsiveScreen(
            squarishMainArea: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    "$_winningText, $_playerName!", // ✅ Show personalized name
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Permanent Marker',
                      fontSize: 50,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    "Your Time: ${widget.score} seconds", // ✅ Display score
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            rectangularMenuArea: MyButton(
              onPressed: () {
                GoRouter.of(context).go('/play');
              },
              child: const Text('Play more'),
            ),
          ),

          // ✅ Confetti animation overlay
          if (_showConfetti)
            Positioned.fill(
              child: IgnorePointer(
                child: Confetti(isStopped: !_showConfetti),
              ),
            ),
        ],
      ),
    );
  }
}
