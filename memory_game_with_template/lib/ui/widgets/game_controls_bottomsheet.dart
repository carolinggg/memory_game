import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../pages/start_up_page.dart';
import 'game_button.dart';

class GameControlsBottomSheet extends StatelessWidget {
  const GameControlsBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'PAUSE',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          GameButton(
            onPressed: () => Navigator.of(context).pop(false),
            title: 'CONTINUE',
            color: continueButtonColor,
            width: 200,
          ),
          const SizedBox(height: 10),
          GameButton(
            onPressed: () => Navigator.of(context).pop(true),
            title: 'RESTART',
            color: restartButtonColor,
            width: 200,
          ),
          const SizedBox(height: 10),
          GameButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const StartUpPage();
                  },
                ),
              );
            },
            title: 'QUIT',
            color: quitButtonColor,
            width: 200,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}