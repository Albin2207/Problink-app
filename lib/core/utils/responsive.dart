import 'package:flutter/material.dart';

class Responsive {
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static bool isMobile(BuildContext context) {
    return screenWidth(context) < 600;
  }

  static bool isTablet(BuildContext context) {
    return screenWidth(context) >= 600 && screenWidth(context) < 1200;
  }

  static bool isDesktop(BuildContext context) {
    return screenWidth(context) >= 1200;
  }

  // Responsive padding
  static double padding(BuildContext context) {
    if (isMobile(context)) {
      return 16.0;
    } else if (isTablet(context)) {
      return 24.0;
    } else {
      return 32.0;
    }
  }

  // Responsive horizontal padding
  static double horizontalPadding(BuildContext context) {
    if (isMobile(context)) {
      return 24.0;
    } else if (isTablet(context)) {
      return screenWidth(context) * 0.1;
    } else {
      return screenWidth(context) * 0.15;
    }
  }

  // Responsive font size
  static double fontSize(BuildContext context, double baseSize) {
    if (isMobile(context)) {
      return baseSize;
    } else if (isTablet(context)) {
      return baseSize * 1.1;
    } else {
      return baseSize * 1.2;
    }
  }

  // Responsive spacing
  static double spacing(BuildContext context, double baseSpacing) {
    if (isMobile(context)) {
      return baseSpacing;
    } else if (isTablet(context)) {
      return baseSpacing * 1.2;
    } else {
      return baseSpacing * 1.5;
    }
  }

  // Max width constraint for content
  static double maxContentWidth(BuildContext context) {
    if (isMobile(context)) {
      return double.infinity;
    } else if (isTablet(context)) {
      return 600;
    } else {
      return 800;
    }
  }
}

