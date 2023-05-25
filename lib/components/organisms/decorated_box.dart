import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../molecules/combined_diamonds.dart';

class DiamondDecoratedBox extends StatelessWidget {
  const DiamondDecoratedBox({
    Key? key,
    required this.child,
    required this.colour,
    required this.height,
    required this.width,
  }) : super(key: key);

  final Widget child;
  final Color colour;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TopLeftBoxCorner(colour: colour),
            CustomPaint(
              painter: _BoxPadding(colour: colour),
              child: SizedBox(
                width: width,
                height: kDiamondBoxCornerHeight + (kDiamondBoxCornerHeight / 2),
              ),
            ),
            TopRightBoxCorner(colour: colour),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomPaint(
              painter: _BoxPadding(colour: colour),
              child: SizedBox(
                width: kDiamondBoxCornerWidth + (kDiamondBoxCornerWidth / 2),
                height: height,
              ),
            ),
            Container(
              width: width,
              height: height,
              color: colour,
              padding: const EdgeInsets.all(13.0),
              child: child,
            ),
            CustomPaint(
              painter: _BoxPadding(colour: colour),
              child: SizedBox(
                width: kDiamondBoxCornerWidth + (kDiamondBoxCornerWidth / 2),
                height: height,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DownLeftBoxCorner(colour: colour),
            CustomPaint(
              painter: _BoxPadding(colour: colour),
              child: SizedBox(
                width: width,
                height: kDiamondBoxCornerHeight + (kDiamondBoxCornerHeight / 2),
              ),
            ),
            DownRightBoxCorner(colour: colour),
          ],
        ),
      ],
    );
  }
}

class _BoxPadding extends CustomPainter {
  final Color colour;

  _BoxPadding({required this.colour});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = colour
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;

    var path = Path()
      ..moveTo(0.0, 0.0)
      ..lineTo(0.0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0.0)
      ..lineTo(0.0, 0.0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
