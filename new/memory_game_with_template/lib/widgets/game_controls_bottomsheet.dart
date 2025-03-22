import 'package:basic_template/screens/main_menu_screen.dart';
import 'package:basic_template/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_button.dart';

class GameControlsBottomSheet extends StatelessWidget {
  const GameControlsBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    return Container(
      color: palette.trueWhite,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'PAUSE',
                style: TextStyle(fontSize: 24, color: palette.ink),
              ),
            ),
            const SizedBox(height: 10),
            GameButton(
              onPressed: () => Navigator.of(context).pop(false),
              title: 'CONTINUE',
              color: palette.red,
              width: 200,
            ),
            const SizedBox(height: 10),
            GameButton(
              onPressed: () => Navigator.of(context).pop(true),
              title: 'RESTART',
              color: palette.blue,
              width: 200,
            ),
            const SizedBox(height: 10),
            GameButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const MainMenuScreen();
                    },
                  ),
                );
              },
              title: 'QUIT',
              color: Colors.yellow,
              width: 200,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
