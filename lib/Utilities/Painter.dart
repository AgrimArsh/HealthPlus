import 'package:flutter/material.dart';
import 'Dark.dart';

class Painter extends CustomPainter {
  Painter({@required this.color, @required this.avatarRadius});

  static const double _margin = 6;
  Color? color;
  double? avatarRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final shapeBounds =
    Rect.fromLTWH(0, 0, size.width, size.height - (avatarRadius as double));

    final centerAvatar =
    Offset(shapeBounds.center.dx, shapeBounds.bottom);
    final avatarRect =
    Rect.fromCircle(center: centerAvatar, radius: avatarRadius as double)
        .inflate(_margin);

    final curvedShapeBounds = Rect.fromLTRB(
      shapeBounds.left,
      shapeBounds.top ,
      shapeBounds.right,
      shapeBounds.bottom,
    );

    _drawCurvedShape(canvas, curvedShapeBounds, avatarRect);
  }


  void _drawCurvedShape(Canvas canvas, Rect bounds, Rect avatarRect) {


    final List<Color> colors = [color!.darker(), color as Color, color!.darker()];
    final stops = [0.0, 0.3, 1.0];
    final gradient = LinearGradient(colors: colors, stops: stops);
    final paint = Paint()..shader = gradient.createShader(bounds);
    final handlePoint = Offset(bounds.left + (bounds.width * 0.3), bounds.top);
    // final handlePoint2 = Offset(bounds.bottomCenter.dx, bounds.bottomCenter.dy+20);

    final curvePath = Path()
      ..moveTo(bounds.bottomLeft.dx, bounds.bottomLeft.dy) //4
      // ..arcTo(avatarBounds, -pi, pi, false) //5
      ..lineTo(bounds.bottomRight.dx, bounds.bottomRight.dy) //6
      ..lineTo(bounds.topRight.dx, bounds.topRight.dy) //7
      ..quadraticBezierTo(handlePoint.dx, handlePoint.dy,
          bounds.topLeft.dx, (bounds.topLeft.dy)+150) //8
      ..lineTo(bounds.bottomLeft.dx, bounds.bottomLeft.dy)
      ..close(); //9


    canvas.drawPath(curvePath, paint);
  }

  @override
  bool shouldRepaint(Painter oldDelegate) {
    return avatarRadius != oldDelegate.avatarRadius ||
        color != oldDelegate.color;
  }
}