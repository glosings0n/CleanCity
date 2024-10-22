import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../shared.dart';

class MyAppBar extends StatelessWidget {
  final bool isOnAdmin;
  const MyAppBar({super.key, this.isOnAdmin = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            if (isOnAdmin) Navigator.pushReplacementNamed(context, "/");
          },
          child: TextLogo(),
        ),
        GestureDetector(
          onTap: () {
            if (!isOnAdmin) Navigator.pushNamed(context, "/admin");
          },
          child: Row(
            children: [
              Text(
                "ELIKYA",
                style: GoogleFonts.londrinaShadow(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontSize: 25,
                ),
              ),
              const Gap(10),
              SizedBox(
                height: 30,
                width: 30,
                child: Image.asset(AppImages.logo),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

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
            fontSize: 25,
          ),
        ),
        Text(
          "CITY",
          style: GoogleFonts.londrinaSketch(
            letterSpacing: 1.5,
            fontSize: 25,
          ),
        ),
      ],
    );
  }
}
