import 'package:flutter/material.dart';

class LinearProgressWithDot extends StatelessWidget {
  final double progress; // 0.0 - 1.0
  final double width;
  final double strokeWidth;
  final Color progressColor;
  final Color backgroundColor;

  const LinearProgressWithDot({
    super.key,
    required this.progress,
    this.width = 300,
    this.strokeWidth = 12,
    this.progressColor = Colors.blue,
    this.backgroundColor = const Color(0xFFE0E0E0),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: strokeWidth * 3,
      child: CustomPaint(
        painter: _LinearPainter(
          progress,
          strokeWidth,
          progressColor,
          backgroundColor,
        ),
      ),
    );
  }
}

class _LinearPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color progressColor;
  final Color backgroundColor;

  _LinearPainter(
    this.progress,
    this.strokeWidth,
    this.progressColor,
    this.backgroundColor,
  );

  @override
  void paint(Canvas canvas, Size size) {
    double centerY = size.height / 2;

    Paint background =
        Paint()
          ..color = backgroundColor
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    Paint progressPaint =
        Paint()
          ..color = progressColor
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    // Background line
    canvas.drawLine(
      Offset(0, centerY),
      Offset(size.width, centerY),
      background,
    );

    // Progress line
    double progressX = size.width * progress;

    canvas.drawLine(
      Offset(0, centerY),
      Offset(progressX, centerY),
      progressPaint,
    );

    // Outer border dot (same color as progress)
    Paint borderPaint = Paint()..color = progressColor;
    canvas.drawCircle(
      Offset(progressX, centerY),
      strokeWidth / 1.2,
      borderPaint,
    );

    // Inner white dot
    Paint innerPaint = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(progressX, centerY), strokeWidth / 2, innerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
