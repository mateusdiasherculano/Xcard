import 'dart:math';

import "package:flutter/material.dart";

class CirclePainter extends CustomPainter {
  // Color lineColor;
  Color completeColor;
  double completePercent;
  double width;
  CirclePainter(
      {this.completeColor = Colors.black,
      this.completePercent = 1,
      this.width = 1});
  @override
  void paint(Canvas canvas, Size size) {
    Paint complete = new Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Offset center = new Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2.5, size.height / 2);

    double arcAngle = 2 * pi * (completePercent / 100);
    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius), 0,
        arcAngle, false, complete);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
