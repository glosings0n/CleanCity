import 'dart:async';

// import 'package:gap/gap.dart';
import 'package:clean_city/shared/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

void myCustomSnackBar({
  context,
  text,
  bool error = false,
}) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    canSizeOverlay: true,
    builder: (context) => Align(
      alignment: Alignment.topRight,
      child: mySnackBar(context, text, error),
    ),
  );
  overlay.insert(overlayEntry);

  Timer(const Duration(milliseconds: 2500), () {
    overlayEntry.remove();
  });
}

Widget mySnackBar(BuildContext context, String text, bool error) {
  final bckColor = error ? const Color(0xFFC1251A) : const Color(0xFF09A40E);
  final width = MediaQuery.sizeOf(context).width;
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(horizontal: 10),
    margin: EdgeInsets.only(
      top: 10,
      right: 15,
      left: AppAdaptability.isDesktop(context) ? width * 0.8 : width * 0.7,
    ),
    height: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      color: bckColor,
    ),
    child: SizedBox(
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            child: Icon(
              error
                  ? HugeIcons.strokeRoundedCancelCircle
                  : HugeIcons.strokeRoundedCheckmarkCircle02,
            ),
          ),
          Positioned(
            left: 30,
            child: Text(
              text,
              style: Theme.of(context).textTheme.labelLarge,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
        ],
      ),
    ),
  );
}
