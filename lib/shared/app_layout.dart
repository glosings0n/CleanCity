import 'package:flutter/material.dart';

class AppAdaptability extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;
  const AppAdaptability({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  static bool isMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width < 540;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= 540 &&
        MediaQuery.sizeOf(context).width < 800;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= 800;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width > 1280) {
      return desktop;
    } else if (width >= 904 && width < 1280) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}
