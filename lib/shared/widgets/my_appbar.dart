import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../shared.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextLogo(),
        Row(
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
      ],
    );
  }
}
