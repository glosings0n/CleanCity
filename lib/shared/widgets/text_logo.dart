import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextLogo extends StatelessWidget {
  const TextLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "CLEAN",
          style: GoogleFonts.londrinaSolid(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            fontSize: 20,
          ),
        ),
        Text(
          "CITY",
          style: GoogleFonts.londrinaSketch(
            letterSpacing: 1.5,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
