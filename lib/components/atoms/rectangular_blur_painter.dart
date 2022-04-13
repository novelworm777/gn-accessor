import 'package:flutter/material.dart';

class RectangleBlurPainter extends CustomPainter {
  RectangleBlurPainter(
      {required this.width,
      required this.height,
      required this.blurSigma,
      required this.colour});

  final double width;
  final double height;
  final double blurSigma;
  final Color colour;

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = Paint()
      ..color = colour
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurSigma);
    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawRect(
        Rect.fromCenter(center: center, width: width, height: height), line);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
