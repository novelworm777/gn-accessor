import 'package:flutter/material.dart';

class DiamondUnderline extends CustomPainter {
  final Color colour;

  DiamondUnderline({required this.colour});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = colour
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    var diamondSize = 13.0;
    var path = Path()
      ..moveTo(0.0, size.height - diamondSize / 2)
      ..lineTo(size.width - diamondSize, size.height - diamondSize / 2)
      ..lineTo(size.width - diamondSize / 2, size.height - diamondSize)
      ..lineTo(size.width, size.height - diamondSize / 2)
      ..lineTo(size.width - diamondSize / 2, size.height)
      ..lineTo(size.width - diamondSize, size.height - diamondSize / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
