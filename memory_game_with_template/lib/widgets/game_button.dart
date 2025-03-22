import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../style/palette.dart';

class GameButton extends StatelessWidget {
  const GameButton({
    required this.title,
    required this.onPressed,
    required this.color,
    this.height = 40,
    this.width = double.infinity,
    this.fontSize = 18,
    Key? key,
  }) : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final Color color;
  final double height;
  final double width;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          textStyle: GoogleFonts.poppins(fontSize: fontSize),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(height / 2),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: GoogleFonts.poppins(
              fontSize: 18,
              color: palette.trueWhite,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
