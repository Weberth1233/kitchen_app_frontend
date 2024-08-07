import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;
  final Widget? tablet;

  const Responsive({
    super.key,
    required this.mobile,
    required this.desktop,
    this.tablet,
  });

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  }

  static bool isTablet(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return size >= 800 && size < 1200;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }

  static double maxWidthScreen(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1260) {
          return desktop;
        } else if (constraints.maxWidth >= 800) {
          Widget? resTablet = tablet;
          if (resTablet != null) {
            return resTablet;
          }
          return mobile;
        } else {
          return mobile;
        }
      },
    );
  }
}
