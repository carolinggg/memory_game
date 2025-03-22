// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../style/my_button.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';
import '../widgets/game_options.dart';

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    return Scaffold(
      backgroundColor: palette.backgroundMain,
      body: ResponsiveScreen(
        squarishMainArea: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.rotate(
                  angle: -0.1,
                  child: Image.asset(
                    'assets/images/logo.png', // Replace with your image path
                    height: 300, // Adjust size as needed
                  ),
                ),
                GameOptions(),
              ]),
        ),
        //  Column(
        //   children: [
        //     const Padding(
        //       padding: EdgeInsets.all(16),
        //       child: Center(
        //         child: Text(
        //           'Select level',
        //           style:
        //               TextStyle(fontFamily: 'Permanent Marker', fontSize: 30),
        //         ),
        //       ),
        //     ),
        //     const SizedBox(height: 50),
        //     Expanded(
        //       child: ListView(
        //         children: [
        //           for (final level in gameLevels)
        //             ListTile(
        //               enabled: playerProgress.highestLevelReached >=
        //                   level.number - 1,
        //               onTap: () {
        //                 final audioController = context.read<AudioController>();
        //                 audioController.playSfx(SfxType.buttonTap);

        //                 GoRouter.of(context)
        //                     .go('/play/session/${level.number}');
        //               },
        //               leading: Text(level.number.toString()),
        //               title: Text('Level #${level.number}'),
        //             )
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        rectangularMenuArea: MyButton(
            onPressed: () {
              GoRouter.of(context).go('/');
            },
            child: Text(
              'Back',
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}
