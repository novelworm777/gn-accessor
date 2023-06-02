import 'package:flutter/material.dart';

/// Draw a diamond.
class Diamond extends CustomPainter {
  final Color colour;

  Diamond({required this.colour});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = colour
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;

    var path = Path()
      ..moveTo(size.width, size.height / 2)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(0.0, size.height / 2)
      ..lineTo(size.width / 2, 0.0)
      ..lineTo(size.width, size.height / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

/// Draw the top half of a diamond.
class TopHalfDiamond extends CustomPainter {
  final Color colour;

  TopHalfDiamond({required this.colour});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = colour
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;

    var path = Path()
      ..moveTo(0.0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width / 2, 0.0)
      ..lineTo(0.0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

/// Draw the down half of a diamond.
class DownHalfDiamond extends CustomPainter {
  final Color colour;

  DownHalfDiamond({required this.colour});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = colour
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;

    var path = Path()
      ..moveTo(0.0, 0.0)
      ..lineTo(size.width, 0.0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(0.0, 0.0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

/// Draw the left half of a diamond.
class LeftHalfDiamond extends CustomPainter {
  final Color colour;

  LeftHalfDiamond({required this.colour});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = colour
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;

    var path = Path()
      ..moveTo(size.width, size.height)
      ..lineTo(0.0, size.height / 2)
      ..lineTo(size.width, 0.0)
      ..lineTo(size.width, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

/// Draw the right half of a diamond.
class RightHalfDiamond extends CustomPainter {
  final Color colour;

  RightHalfDiamond({required this.colour});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = colour
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;

    var path = Path()
      ..moveTo(0.0, 0.0)
      ..lineTo(0.0, size.height)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(0.0, 0.0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

/// Draw the top left quarter of a diamond.
class TopLeftQuarterDiamond extends CustomPainter {
  final Color colour;

  TopLeftQuarterDiamond({required this.colour});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = colour
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;

    var path = Path()
      ..moveTo(size.width, size.height)
      ..lineTo(0.0, size.height)
      ..lineTo(size.width, 0.0)
      ..lineTo(size.width, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

/// Draw the top right quarter of a diamond.
class TopRightQuarterDiamond extends CustomPainter {
  final Color colour;

  TopRightQuarterDiamond({required this.colour});

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
      ..lineTo(0.0, 0.0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

/// Draw the down left quarter of a diamond.
class DownLeftQuarterDiamond extends CustomPainter {
  final Color colour;

  DownLeftQuarterDiamond({required this.colour});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = colour
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;

    var path = Path()
      ..moveTo(0.0, 0.0)
      ..lineTo(size.width, 0.0)
      ..lineTo(size.width, size.height)
      ..lineTo(0.0, 0.0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

/// Draw the down right quarter of a diamond.
class DownRightQuarterDiamond extends CustomPainter {
  final Color colour;

  DownRightQuarterDiamond({required this.colour});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = colour
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;

    var path = Path()
      ..moveTo(0.0, 0.0)
      ..lineTo(size.width, 0.0)
      ..lineTo(0.0, size.height)
      ..lineTo(0.0, 0.0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

/// Draw a diamond outline.
class DiamondOutline extends CustomPainter {
  final Color colour;

  DiamondOutline({required this.colour});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = colour
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    var path = Path()
      ..moveTo(size.width, size.height / 2)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(0.0, size.height / 2)
      ..lineTo(size.width / 2, 0.0)
      ..lineTo(size.width, size.height / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
