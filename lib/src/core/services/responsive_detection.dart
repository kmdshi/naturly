import 'package:flutter/material.dart';
import 'package:naturly/src/core/utils/constants.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  static bool isMobile(BuildContext context) {
    Constants constants = Constants();
    return MediaQuery.of(context).size.width < constants.mobileBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    Constants constants = Constants();
    return MediaQuery.of(context).size.width >= constants.mobileBreakpoint &&
        MediaQuery.of(context).size.width < constants.tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    Constants constants = Constants();
    return MediaQuery.of(context).size.width >= constants.desktopBreakpoint;
  }

  @override
  Widget build(BuildContext context) {
    Constants constants = Constants();

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < constants.mobileBreakpoint) {
          return mobile;
        } else if (constraints.maxWidth >= constants.mobileBreakpoint &&
            constraints.maxWidth < constants.tabletBreakpoint) {
          return tablet;
        } else {
          return desktop;
        }
      },
    );
  }
}
