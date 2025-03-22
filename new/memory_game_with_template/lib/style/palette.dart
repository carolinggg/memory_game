// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

/// A palette of colors to be used in the game.
///
/// The reason we're not going with something like Material Design's
/// `Theme` is simply that this is simpler to work with and yet gives
/// us everything we need for a game.
///
/// Games generally have more radical color palettes than apps. For example,
/// every level of a game can have radically different colors.
/// At the same time, games rarely support dark mode.
///
/// Colors taken from this fun palette:
/// https://lospec.com/palette-list/crayola84
///
/// Colors here are implemented as getters so that hot reloading works.
/// In practice, we could just as easily implement the colors
/// as `static const`. But this way the palette is more malleable:
/// we could allow players to customize colors, for example,
/// or even get the colors from the network.
class Palette {
  Color get yellow => const Color(0xFFFFFF00);
  Color get blue => const Color(0xFF0000FF);
  Color get red => const Color(0xFFFF0000);
  Color get ink => const Color(0xee352b42);
  Color get backgroundMain => const Color.fromARGB(255, 255, 255, 255); //
  Color get backgroundPlaySession => const Color(0xffffebb5);
  Color get backgroundSettings => const Color(0xffffffd1); //
  Color get trueWhite => const Color(0xffffffff);
}
