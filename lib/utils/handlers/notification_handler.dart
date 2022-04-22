import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gn_accessor/utils/screen_utils.dart';

import '../../components/atoms/rectangular_blur_painter.dart';

class NotificationHandler {
  static void init(bool mounted, {int seconds = 1, VoidCallback? callback}) {
    Future.delayed(Duration(seconds: seconds), callback);
  }

  static Visibility notify(
    BuildContext context,
    String? message, {
    bool isVisible = true,
    Color? backgroundColour,
    Color? fontColour,
  }) {
    return Visibility(
      visible: isVisible,
      child: Center(
        child: CustomPaint(
          painter: RectangleBlurPainter(
            width: ScreenUtils.width(context, ratio: 1.4),
            height: 90,
            blurSigma: 7.0,
            colour: backgroundColour ?? Colors.white,
          ),
          child: Text(
            message.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PoorStory',
              fontSize: 17.0,
              color: fontColour ?? Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  static void notify2(
    BuildContext context,
    String message, {
    Color? backgroundColour,
    Color? fontColour,
    int seconds = 1,
  }) async {
    var notificationAlert = Center(
      child: CustomPaint(
        painter: RectangleBlurPainter(
          width: ScreenUtils.width(context, ratio: 1.1),
          height: 90,
          blurSigma: 7.0,
          colour: backgroundColour ?? Colors.white,
        ),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'PoorStory',
            fontSize: 17.0,
            color: fontColour ?? Colors.black,
          ),
        ),
      ),
    );

    SmartDialog.show(widget: notificationAlert, isLoadingTemp: false);
    await Future.delayed(Duration(seconds: seconds));
    SmartDialog.dismiss();
  }
}
