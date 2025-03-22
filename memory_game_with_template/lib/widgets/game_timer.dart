import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../style/palette.dart';

class GameTimer extends StatelessWidget {
  final Duration time;
  const GameTimer({Key? key, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    return Card(
      margin: const EdgeInsets.all(40),
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: palette.blue,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            const Expanded(
              flex: 1,
              child: Icon(
                Icons.timer,
                color: Colors.white,
                size: 40,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                time.toString().split('.').first.padLeft(8, "0"),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
