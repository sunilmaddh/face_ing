import 'package:flutter/material.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaugeWithBadges extends StatelessWidget {
  const GaugeWithBadges({super.key});

  @override
  Widget build(BuildContext context) {
    // Define ranges dynamically (each with a label + color + start/end values)
    final List<_RangeData> ranges = [
      _RangeData("60", 0, 21.3, Colors.red),
      _RangeData("50", 21.3, 33.3, Colors.amber),
      _RangeData("70", 33.3, 52.0, Colors.black),
      _RangeData("80", 52.0, 66.6, Colors.red),
      _RangeData("90", 66.6, 77.0, Colors.amber),
      _RangeData("100", 77.0, 100, Colors.black),
    ];

    return Scaffold(
      body: Center(
        child: SfRadialGauge(
          enableLoadingAnimation: true,
          axes: <RadialAxis>[
            RadialAxis(
              showFirstLabel: false,
              minimum: 0,
              maximum: 100,
              startAngle: 115, // arc start
              endAngle: 425, // arc end (115 + 310°)
              showTicks: false,
              showLabels: false,
              radiusFactor: 0.60,
              axisLineStyle: const AxisLineStyle(
                thickness: 15,
                cornerStyle: CornerStyle.bothFlat,
                color: Color(0xFFDFE2EC),
              ),
              ranges:
                  ranges
                      .map(
                        (r) => GaugeRange(
                          startValue: r.start,
                          endValue: r.end,
                          color: r.color,
                        ),
                      )
                      .toList(),
              pointers: const <GaugePointer>[],
              annotations:
                  ranges
                      .map(
                        (r) => GaugeAnnotation(
                          widget: _buildBadge(r.label),
                          angle: _valueToAngle(
                            (r.start + r.end) / 2, // midpoint of range
                            0,
                            100,
                            115,
                            425,
                          ),
                          positionFactor: 1.2, // place outside arc
                        ),
                      )
                      .toList(),
            ),
          ],
        ),
      ),
    );
  }

  /// Badge widget
  static Widget _buildBadge(String text) {
    return CommonText.text(
      text,
      fontFamily: "League Spartan",
      color: Color(0xffE0E0E0),
      fontSize: 11,
      fontWeight: FontWeight.w700,
    );
  }

  /// Map gauge value → angle
  static double _valueToAngle(
    double value,
    double min,
    double max,
    double startAngle,
    double endAngle,
  ) {
    final sweepAngle = endAngle - startAngle;
    final factor = (value - min) / (max - min);
    return startAngle + (factor * sweepAngle);
  }
}

/// Helper class for range + label
class _RangeData {
  final String label;
  final double start;
  final double end;
  final Color color;

  _RangeData(this.label, this.start, this.end, this.color);
}
