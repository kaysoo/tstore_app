import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TCustomCurvedEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    final firstPoint = Offset(0, size.height - 20);
    final lastPoint = Offset(30, size.height - 20);
    path.quadraticBezierTo(
        firstPoint.dx, firstPoint.dy, lastPoint.dx, lastPoint.dy);

    final firstPoint2 = Offset(0, size.height - 20);
    final lastPoint2 = Offset(size.width - 30, size.height - 20);
    path.quadraticBezierTo(
        firstPoint2.dx, firstPoint2.dy, lastPoint2.dx, lastPoint2.dy);

    final firstPoint3 = Offset(size.width, size.height - 20);
    final lastPoint3 = Offset(size.width, size.height);
    path.quadraticBezierTo(
        firstPoint3.dx, firstPoint3.dy, lastPoint3.dx, lastPoint3.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
