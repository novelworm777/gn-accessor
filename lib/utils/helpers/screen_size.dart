import 'package:flutter/widgets.dart';

/// Utility class to get width and height of screen.
class ScreenSize {
  /// Get this screen's width by its [ratio].
  static double width(BuildContext context, {double ratio = 1}) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * ratio;
  }

  /// Get this screen's height by its [ratio].
  static double height(BuildContext context, {double ratio = 1}) {
    double screenWidth = MediaQuery.of(context).size.height;
    return screenWidth * ratio;
  }
}
