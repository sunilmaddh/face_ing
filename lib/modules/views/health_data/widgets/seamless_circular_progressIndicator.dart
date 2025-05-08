import 'package:flutter/material.dart';
import 'dart:math';

class SeamlessCircularProgressIndicator extends StatefulWidget {
  final int progress; // Current progress value
  final int maxProgress;
  final int age;
  final Color borderColor;
  final Color drawArcColor;
  final double size;
  final double baseStrokeWidth;

  const SeamlessCircularProgressIndicator({
    super.key,
    required this.progress,
    this.maxProgress = 100,
    required this.age,
    required this.borderColor,
    required this.drawArcColor,
    this.size = 100,
    this.baseStrokeWidth = 8,
  });

  @override
  State<SeamlessCircularProgressIndicator> createState() =>
      _SeamlessCircularProgressIndicatorState();
}

class _SeamlessCircularProgressIndicatorState
    extends State<SeamlessCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  late Animation<double> _ageAnimation;

  @override
  void initState() {
    super.initState();

    final normalizedProgress = (widget.progress / widget.maxProgress).clamp(
      0.0,
      1.0,
    );

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0,
      end: normalizedProgress,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _ageAnimation = Tween<double>(
      begin: 0,
      end: normalizedProgress * widget.age,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final strokeWidth =
              widget.baseStrokeWidth + (_progressAnimation.value * 8);
          return Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(widget.size, widget.size),
                painter: _CirclePainter(
                  progress: _progressAnimation.value,
                  strokeWidth: strokeWidth,
                  borderColor: widget.borderColor,
                  drawArcColor: widget.drawArcColor,
                ),
              ),
              Text(
                "${widget.age.toInt()}",
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color borderColor;
  final Color drawArcColor;

  _CirclePainter({
    required this.progress,
    required this.strokeWidth,
    required this.borderColor,
    required this.drawArcColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final Paint backgroundPaint =
        Paint()
          ..color = borderColor
          ..strokeWidth = strokeWidth - 2
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.butt;

    final Paint foregroundPaint =
        Paint()
          ..color = drawArcColor
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.butt;

    // Draw full circle background
    canvas.drawArc(rect, 0, 2 * pi, false, backgroundPaint);

    // Draw progress arc
    final sweepAngle = 2 * pi * progress;
    canvas.drawArc(rect, -pi / 2, sweepAngle, false, foregroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
