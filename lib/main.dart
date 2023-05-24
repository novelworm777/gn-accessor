import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

void main() {
  // disable status bar and navigation bar on mobile phone
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  // run the app
  runApp(const GNAccessor());
}

class GNAccessor extends StatelessWidget {
  const GNAccessor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GN Accessor',
      home: MyPainter(),
    );
  }
}

// reference https://blog.codemagic.io/flutter-custom-painter/
class MyPainter extends StatelessWidget {
  const MyPainter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        // painter: CirclePainterDrawCircle(), // paint before child
        foregroundPainter: TrianglePainter(), // paint after child
        child: Container(),
      ),
    );
  }
}

// draw a line with offset
class LinePainterOffset extends CustomPainter {
  // This method is called whenever the object needs to be repainted.
  @override
  void paint(Canvas canvas, Size size) {
    // paintbrush
    var paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;

    Offset startingPoint = Offset(0, size.height / 2);
    Offset endingPoint = Offset(size.width, size.height / 2);

    canvas.drawLine(startingPoint, endingPoint, paint);
  }

  // This method is called when a new instance of the class is provided.
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // no need to redraw
    return false;
  }
}

// draw a line with path
class LinePainterPath extends CustomPainter {
  // This method is called whenever the object needs to be repainted.
  @override
  void paint(Canvas canvas, Size size) {
    // paintbrush
    var paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 7
      ..style = PaintingStyle.stroke // required to use path
      ..strokeCap = StrokeCap.round;

    var path = Path()
      ..moveTo(0, size.height / 2)
      ..lineTo(size.width, size.height / 2);

    canvas.drawPath(path, paint);
  }

  // This method is called when a new instance of the class is provided.
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // no need to redraw
    return false;
  }
}

// draw a circle with draw circle
class CirclePainterDrawCircle extends CustomPainter {
  // This method is called whenever the object needs to be repainted.
  @override
  void paint(Canvas canvas, Size size) {
    // paintbrush
    var paint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 7
      ..style = PaintingStyle.stroke // add to be a line
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = 100;

    canvas.drawCircle(center, radius, paint);
  }

  // This method is called when a new instance of the class is provided.
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // no need to redraw
    return false;
  }
}

// draw a circle with path
class CirclePainterPath extends CustomPainter {
  // This method is called whenever the object needs to be repainted.
  @override
  void paint(Canvas canvas, Size size) {
    // paintbrush
    var paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 7
      // ..style = PaintingStyle.stroke // add to be a line
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = 100;
    var path = Path()
      ..addOval(Rect.fromCircle(
        center: center,
        radius: radius,
      ));

    canvas.drawPath(path, paint);
  }

  // This method is called when a new instance of the class is provided.
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // no need to redraw
    return false;
  }
}

// draw a square
class SquarePainter extends CustomPainter {
  // This method is called whenever the object needs to be repainted.
  @override
  void paint(Canvas canvas, Size size) {
    // paintbrush
    var paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 7
      // ..style = PaintingStyle.stroke // add to be a line
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = 100;
    var path = getSquarePath(center, radius, 4);

    canvas.drawPath(path, paint);
  }

  // This method is called when a new instance of the class is provided.
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // no need to redraw
    return false;
  }
}

// draw a triangle
class TrianglePainter extends CustomPainter {
  // This method is called whenever the object needs to be repainted.
  @override
  void paint(Canvas canvas, Size size) {
    // paintbrush
    var paint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 7
      // ..style = PaintingStyle.stroke // add to be a line
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = 100;
    var path = getSquarePath(center, radius, 3);

    canvas.drawPath(path, paint);
  }

  // This method is called when a new instance of the class is provided.
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // no need to redraw
    return false;
  }
}

Path getSquarePath(Offset center, double radius, int sides) {
  var angle = (math.pi * 2) / sides;
  Offset startingPoint = Offset(radius * math.cos(0.0), radius * math.sin(0.0));

  var path = Path();
  path.moveTo(startingPoint.dx + center.dx, startingPoint.dy + center.dy);
  for (int i = 1; i <= sides; i++) {
    double x = radius * math.cos(angle * i) + center.dx;
    double y = radius * math.sin(angle * i) + center.dy;
    path.lineTo(x, y);
  }
  path.close();

  return path;
}
