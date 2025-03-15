
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../widgets/game_options.dart';

class StartUpPage extends StatelessWidget {
  const StartUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
            Text(gameTitle,
            style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            GameOptions(),
                    ]),
          ),
      ),
    );
  }
}
