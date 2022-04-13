import 'package:flutter/material.dart';

class ScreenUtils {
  static double width(BuildContext context, {double ratio = 1}) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * ratio;
  }

  static double height(BuildContext context, {double ratio = 1}) {
    double screenWidth = MediaQuery.of(context).size.height;
    return screenWidth * ratio;
  }
}
