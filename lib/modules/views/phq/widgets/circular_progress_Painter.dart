import 'dart:math';
import 'package:flutter/material.dart';

class CircularProgressWithDot extends StatelessWidget {
  final double progress; // 0.0 - 1.0
  final double size;
  final double strokeWidth;
  final Color progressColor;
  final Color backgroundColor;

  const CircularProgressWithDot({
    super.key,
    required this.progress,
    this.size = 200,
    this.strokeWidth = 12,
    this.progressColor = Colors.blue,
    this.backgroundColor = const Color(0xFFE0E0E0),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CustomPaint(
        painter: _CirclePainter(
          progress,
          strokeWidth,
          progressColor,
          backgroundColor,
        ),
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color progressColor;
  final Color backgroundColor;

  _CirclePainter(
    this.progress,
    this.strokeWidth,
    this.progressColor,
    this.backgroundColor,
  );

  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.width / 2 - strokeWidth;
    Offset center = Offset(size.width / 2, size.height / 2);

    Paint background =
        Paint()
          ..color = backgroundColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth;

    Paint progressPaint =
        Paint()
          ..color = progressColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    Rect rect = Rect.fromCircle(center: center, radius: radius);

    // Background circle
    canvas.drawArc(rect, 0, 2 * pi, false, background);

    // Progress arc
    double sweepAngle = 2 * pi * progress;
    canvas.drawArc(rect, -pi / 2, sweepAngle, false, progressPaint);

    // Dot position
    double angle = -pi / 2 + sweepAngle;

    double x = center.dx + radius * cos(angle);
    double y = center.dy + radius * sin(angle);

    // Outer border (same color as progress)
    Paint borderPaint = Paint()..color = progressColor;
    canvas.drawCircle(Offset(x, y), strokeWidth / 1.2, borderPaint);

    // Inner white circle
    Paint innerPaint = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(x, y), strokeWidth / 2, innerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
