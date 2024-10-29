import 'package:clean_city/shared/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppButton extends StatelessWidget {
  const CustomAppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.customWidth,
    this.customHeight,
  });

  final VoidCallback onPressed;
  final String text;
  final double? customWidth, customHeight;

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
              ? Size(customWidth ?? width * 0.17, customHeight ?? width * 0.035)
              : Size(customWidth ?? width * 0.3, customHeight ?? 40),
        ),
        foregroundColor: WidgetStatePropertyAll(
          Colors.black,
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.outfit(
          fontWeight: FontWeight.w500,
          letterSpacing: 1.3,
          fontSize: 16,
        ),
      ),
    );
  }
}
