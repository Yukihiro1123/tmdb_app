class BreakPoints {
  static const double mobileSize = 600;
  static const double tabletSize = 834;
  static const double desktopSize = 1024;
}

int getColumnCount(double screenWidth) {
  if (screenWidth <= BreakPoints.mobileSize) {
    return 1;
  } else if (screenWidth <= BreakPoints.tabletSize) {
    return 2;
  } else {
    return 3;
  }
}
