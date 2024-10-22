import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../shared.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.initialValue,
    this.maxLength,
    this.maxLines,
    this.obscureText = false,
    this.canChange = false,
    this.enabled,
    this.isNotRequired = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  final TextEditingController? controller;
  final bool obscureText;
  final bool canChange;
  final bool? enabled;
  final bool isNotRequired;
  final String? hintText;
  final String? labelText;
  final String? initialValue;
  final int? maxLength;
  final int? maxLines;
  final TextInputType keyboardType;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return TextFormField(
      autocorrect: false,
      initialValue: initialValue,
      enabled: enabled,
      controller: controller,
      obscureText: obscureText,
      onTapOutside: (event) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      onChanged: onChanged,
      cursorColor: Colors.black,
      cursorErrorColor: const Color(0xFFC1251A),
      style: GoogleFonts.outfit(
        fontWeight: FontWeight.w500,
        fontSize:
            AppAdaptability.isDesktop(context) ? width * 0.012 : width * 0.024,
        color: Colors.black,
      ),
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: GoogleFonts.outfit(
          fontWeight: FontWeight.normal,
          fontSize: AppAdaptability.isDesktop(context)
              ? width * 0.012
              : width * 0.022,
          color: Colors.black,
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.outfit(
          color: Colors.grey.shade700,
          fontWeight: FontWeight.normal,
          fontSize: AppAdaptability.isDesktop(context)
              ? width * 0.012
              : width * 0.024,
        ),
        disabledBorder: InputBorder.none,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: const Color(0xFFC1251A),
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
        errorStyle: GoogleFonts.outfit(
          color: const Color(0xFFC1251A),
          fontWeight: FontWeight.normal,
          fontSize:
              AppAdaptability.isDesktop(context) ? width * 0.01 : width * 0.02,
        ),
      ),
      validator: isNotRequired
          ? null
          : (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez remplir ce champ !';
              }
              return null;
            },
    );
  }
}
