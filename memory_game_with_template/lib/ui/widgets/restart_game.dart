import 'dart:async';

import 'package:flutter/material.dart';
import '../widgets/game_controls_bottomsheet.dart';

import '../pages/start_up_page.dart';
import 'game_button.dart';



class RestartGame extends StatelessWidget {
  const RestartGame({
    Key? key,
    required this.isGameOver,
    required this.pauseGame,
    required this.restartGame,
    required this.continueGame,
    }) : super(key:key)
 ;

  final VoidCallback pauseGame;
  final VoidCallback restartGame;
  final VoidCallback continueGame;
  final bool isGameOver;

  Future<void> showGameControls(BuildContext context) async {
    pauseGame();
    var value = await showModalBottomSheet<bool>(
      isScrollControlled: true,
      elevation: 5,
      context: context,
      builder: (sheetContext) {
        return const GameControlsBottomSheet();
      },
    );

    value ??= false;

    if (value) {
      restartGame();
    } else {
      continueGame();
    }
  }

  void navigateback(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) {
      return const StartUpPage();
    }), (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    if(isGameOver){
      return GameButton(
        onPressed: (){
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context){
            return const StartUpPage();  
            })
          );
        },
        title: 'TRY AGAIN',
        color: Colors.amber[700]!,);
    }
    else {
      return GameButton(
        title: 'PAUSE',
        onPressed: ()=> showGameControls(context),
        color: Colors.amber[700]!);
    }
  }
}