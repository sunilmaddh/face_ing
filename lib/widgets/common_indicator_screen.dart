import 'package:flutter/material.dart';
import 'dart:math';

class StressIndicator extends StatefulWidget {
  const StressIndicator({
    super.key,
    required this.stressLevel,
    this.size = const Size(200, 100),
    this.duration = const Duration(seconds: 2),
  });

  final double stressLevel; // 0 to 100
  final Size size;
  final Duration duration;

  @override
  State<StressIndicator> createState() => _StressIndicatorState();
}

class _StressIndicatorState extends State<StressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _animationIndicator;

  final double circleLevel = 100; // Always full 100%

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    _animation = Tween<double>(
      begin: 0,
      end: circleLevel,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _animationIndicator = Tween<double>(
      begin: 0,
      end: widget.stressLevel,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant StressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.stressLevel != widget.stressLevel) {
      _animationIndicator = Tween<double>(
        begin: _animationIndicator.value,
        end: widget.stressLevel,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: StressPainter(_animation.value, _animationIndicator.value),
          size: widget.size,
        );
      },
    );
  }
}

// 🎨 Custom Painter
class StressPainter extends CustomPainter {
  final double circleLevel;
  final double stressLevel;

  StressPainter(this.circleLevel, this.stressLevel);

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height);
    final Rect arcRect = Rect.fromCircle(center: center, radius: radius);

    final Paint sectionPaint =
        Paint()
          ..strokeWidth = 20
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.butt;

    double startAngle = pi;

    // Section 1: Green (0-40%)
    double greenSweep = pi * (min(circleLevel, 40) / 100);
    if (greenSweep > 0) {
      sectionPaint.color = Colors.green;
      canvas.drawArc(arcRect, startAngle, greenSweep, false, sectionPaint);
      startAngle += greenSweep;
    }

    // Section 2: Orange (40-70%)
    if (circleLevel > 40) {
      double orangeSweep = pi * ((min(circleLevel, 70) - 40) / 100);
      if (orangeSweep > 0) {
        sectionPaint.color = Colors.orange;
        canvas.drawArc(arcRect, startAngle, orangeSweep, false, sectionPaint);
        startAngle += orangeSweep;
      }
    }

    // Section 3: Red (70-100%)
    if (circleLevel > 70) {
      double redSweep = pi * ((circleLevel - 70) / 100);
      if (redSweep > 0) {
        sectionPaint.color = Colors.red;
        canvas.drawArc(arcRect, startAngle, redSweep, false, sectionPaint);
        startAngle += redSweep;
      }
    }

    drawIndicator(canvas, center, radius, stressLevel);
  }

  void drawIndicator(
    Canvas canvas,
    Offset center,
    double radius,
    double level,
  ) {
    double angle = pi + (pi * (level / 100));

    final double indicatorRadius = radius - 10;
    final Offset indicatorPosition = Offset(
      center.dx + indicatorRadius * cos(angle),
      center.dy + indicatorRadius * sin(angle),
    );

    final double lineLength = 20;

    final Offset lineStart = Offset(
      indicatorPosition.dx - (lineLength / 2) * cos(angle),
      indicatorPosition.dy - (lineLength / 2) * sin(angle),
    );

    final Offset lineEnd = Offset(
      indicatorPosition.dx + (lineLength / 2) * cos(angle),
      indicatorPosition.dy + (lineLength / 2) * sin(angle),
    );

    final Paint indicatorPaint =
        Paint()
          ..color = Colors.black
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke;

    canvas.drawLine(lineStart, lineEnd, indicatorPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
