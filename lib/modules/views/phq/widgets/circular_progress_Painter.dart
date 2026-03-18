import 'dart:math';
import 'package:flutter/material.dart';

class CircularProgressWithDot extends StatefulWidget {
  final double time;
  final double maxDuration;
  final double size;
  final double strokeWidth;
  final Color progressColor;
  final Color backgroundColor;

  const CircularProgressWithDot({
    super.key,
    required this.time,
    this.maxDuration = 60.0,
    this.size = 200,
    this.strokeWidth = 12,
    this.progressColor = Colors.blue,
    this.backgroundColor = const Color(0xFFE0E0E0),
  });

  @override
  State<CircularProgressWithDot> createState() =>
      _CircularProgressWithDotState();
}

class _CircularProgressWithDotState extends State<CircularProgressWithDot> {
  double oldProgress = 0.0;

  double get newProgress {
    return (widget.time / widget.maxDuration).clamp(0.0, 1.00);
  }

  @override
  void didUpdateWidget(covariant CircularProgressWithDot oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldProgress = (oldWidget.time / widget.maxDuration).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: oldProgress, end: newProgress),
      duration: const Duration(milliseconds: 300),
      builder: (context, value, child) {
        return SizedBox(
          height: widget.size,
          width: widget.size,
          child: CustomPaint(
            painter: _CirclePainter(
              value,
              widget.strokeWidth,
              widget.progressColor,
              widget.backgroundColor,
            ),
          ),
        );
      },
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

    // Background
    canvas.drawArc(rect, 0, 2 * pi, false, background);

    // Progress
    double sweepAngle = 2 * pi * progress;
    canvas.drawArc(rect, -pi / 2, sweepAngle, false, progressPaint);

    // Dot
    double angle = -pi / 2 + sweepAngle;

    double x = center.dx + radius * cos(angle);
    double y = center.dy + radius * sin(angle);

    Paint borderPaint = Paint()..color = progressColor;
    canvas.drawCircle(Offset(x, y), strokeWidth / 1.2, borderPaint);

    Paint innerPaint = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(x, y), strokeWidth / 2, innerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
