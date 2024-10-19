import 'package:clean_city/shared/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppButton extends StatelessWidget {
  const CustomAppButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        alignment: Alignment.center,
        overlayColor: WidgetStatePropertyAll(
          Colors.grey.shade400,
        ),
        backgroundColor: WidgetStatePropertyAll(
          Colors.grey.shade500,
        ),
        fixedSize: WidgetStatePropertyAll(
          AppAdaptability.isDesktop(context)
              ? Size(width * 0.17, width * 0.035)
              : Size(width * 0.3, width * 0.07),
        ),
        foregroundColor: WidgetStatePropertyAll(
          Colors.black,
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.outfit(
          fontWeight: FontWeight.bold,
          letterSpacing: 1.3,
        ),
      ),
    );
  }
}
