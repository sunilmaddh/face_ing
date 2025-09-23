import 'package:flutter/material.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaugeWithBadges extends StatelessWidget {
  const GaugeWithBadges({
    super.key,
    this.rangeList,
    required this.vitalValue,
    this.maxValue,
    this.statusLabels,
  });

  /// Example for numeric mode → [20, 40, 60]
  final List<int>? rangeList;

  /// Vital value could be `"75"` or `"high"`
  final String vitalValue;

  /// Maximum value (only needed for numeric mode)
  final double? maxValue;

  /// Example for string mode → ["low","normal","mild","medium","high"]
  final List<String>? statusLabels;

  @override
  Widget build(BuildContext context) {
    final bool isNumeric = double.tryParse(vitalValue) != null;

    // Generate gauge ranges
    final List<_RangeData> gaugeList =
        isNumeric
            ? _generateNumericRanges(rangeList ?? [], maxValue ?? 100)
            : _generateStatusRanges(statusLabels ?? []);

    // Pointer value (numeric = number, string = segment index midpoint)
    final double pointerValue =
        isNumeric
            ? double.parse(vitalValue)
            : _mapStatusToIndex(vitalValue, statusLabels ?? []);

    // Effective max value for gauge
    final double effectiveMax =
        isNumeric ? (maxValue ?? 100) : (statusLabels?.length.toDouble() ?? 1);

    return Scaffold(
      body: Center(
        child: SfRadialGauge(
          enableLoadingAnimation: true,
          axes: <RadialAxis>[
            RadialAxis(
              showFirstLabel: false,
              minimum: 0,
              maximum: effectiveMax,
              startAngle: 115,
              endAngle: 425,
              showTicks: false,
              showLabels: false,
              radiusFactor: 0.60,
              axisLineStyle: const AxisLineStyle(
                thickness: 15,
                cornerStyle: CornerStyle.bothFlat,
                color: Color(0xFFDFE2EC),
              ),
              ranges:
                  gaugeList
                      .map(
                        (r) => GaugeRange(
                          startValue: r.start,
                          endValue: r.end,
                          color: r.color,
                        ),
                      )
                      .toList(),
              pointers: <GaugePointer>[
                MarkerPointer(
                  value: pointerValue,
                  color: Colors.white,
                  markerType: MarkerType.circle,
                  markerHeight: 10,
                  markerWidth: 10,
                  enableAnimation: true,
                ),
              ],
              annotations:
                  gaugeList
                      .map(
                        (r) => GaugeAnnotation(
                          widget: _buildBadge(r.label),
                          angle: _valueToAngle(
                            (r.start + r.end) / 2,
                            0,
                            effectiveMax,
                            115,
                            425,
                          ),
                          positionFactor: 1.4,
                        ),
                      )
                      .toList(),
            ),
          ],
        ),
      ),
    );
  }

  /// Numeric ranges from API list
  List<_RangeData> _generateNumericRanges(List<int> apiData, double maxValue) {
    final List<_RangeData> ranges = [];
    double start = 0;
    for (int i = 0; i < apiData.length; i++) {
      double end = apiData[i].toDouble();
      ranges.add(
        _RangeData(
          "${start.toInt()} - ${end.toInt()}",
          start,
          end,
          _pickColor(i),
        ),
      );
      start = end;
    }
    if (start < maxValue) {
      ranges.add(
        _RangeData(
          "${start.toInt()} - ${maxValue.toInt()}",
          start,
          maxValue,
          Colors.green,
        ),
      );
    }
    return ranges;
  }

  /// String status ranges (divide gauge equally)
  List<_RangeData> _generateStatusRanges(List<String> labels) {
    final List<_RangeData> ranges = [];
    final double step = 1; // each status = 1 unit
    double start = 0;
    for (int i = 0; i < labels.length; i++) {
      double end = start + step;
      ranges.add(_RangeData(labels[i], start, end, _pickColor(i)));
      start = end;
    }
    return ranges;
  }

  /// Map status string → segment midpoint
  double _mapStatusToIndex(String status, List<String> labels) {
    final index = labels.indexWhere(
      (e) => e.toLowerCase() == status.toLowerCase(),
    );
    if (index == -1) return 0;
    return index + 0.5; // midpoint of that segment
  }

  /// Pick color for segments
  Color _pickColor(int index) {
    switch (index) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.green;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.amber;
      default:
        return Colors.red;
    }
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

class _RangeData {
  final String label;
  final double start;
  final double end;
  final Color color;
  _RangeData(this.label, this.start, this.end, this.color);
}
