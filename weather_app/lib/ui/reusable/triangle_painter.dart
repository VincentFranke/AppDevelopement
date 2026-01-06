import 'dart:ui';

import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  final Offset pointA;
  final Offset pointB;
  final Offset pointC;
  final Color color;
  final double strokeWidth;
  const TrianglePainter({
    required this.pointA,
    required this.pointB,
    required this.pointC,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(pointA.dx, pointA.dy)
      ..lineTo(pointB.dx, pointB.dy)
      ..lineTo(pointC.dx, pointC.dy)
      ..close();

    // Canvas 0,0 soll unten links sein nicht oben rechts deshalb die unteren zwei Zeilen
    canvas.translate(0, size.height);
    canvas.scale(1, -1);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
