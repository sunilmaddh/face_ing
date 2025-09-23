import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class VitalGauge extends StatelessWidget {
  final String vitalName;
  final double value;

  VitalGauge({super.key, required this.vitalName, required this.value});

  Color color = Colors.black;

  @override
  Widget build(BuildContext context) {
    final ranges = vitalConditions[vitalName] ?? [];
    if (ranges.isEmpty) {
      return Center(child: Text("No ranges defined for $vitalName"));
    }

    final minValue = ranges.first.min ?? 0;
    final maxValue = ranges.last.max ?? (ranges.last.min ?? value);

    final currentRange = ranges.firstWhere(
      (r) => (r.min ?? 0) <= value && value <= (r.max ?? maxValue),
      orElse: () => ranges.first,
    );

    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: minValue,
          maximum: maxValue,
          showLabels: false,
          showTicks: false,
          radiusFactor: 0.7,
          axisLineStyle: const AxisLineStyle(
            thickness: 15,
            cornerStyle: CornerStyle.bothFlat,
          ),
          ranges:
              ranges.map((r) {
                return GaugeRange(
                  startValue: r.min ?? minValue,
                  endValue: r.max ?? maxValue,
                  color: r.color,
                );
              }).toList(),
          pointers: <GaugePointer>[
            MarkerPointer(
              value: value,
              color: currentRange.color,
              markerType: MarkerType.circle,
              markerHeight: 15,
              markerWidth: 15,

              borderColor: AppColors.btntext,
              borderWidth: 2,
              enableAnimation: true, // ✅ enable animation
              animationDuration: 1000, // duration in milliseconds
              animationType: AnimationType.ease, // optional easing
            ),
          ],
          // annotations:
          //     ranges
          //         .map(
          //           (r) => GaugeAnnotation(
          //             widget: Text(
          //               r.label,
          //               style: const TextStyle(
          //                 fontSize: 10,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //             angle: 90,
          //             positionFactor: 1.3,
          //           ),
          //         )
          //         .toList(),
        ),
      ],
    );
  }

  final Map<String, List<GaugeCondition>> vitalConditions = {
    "Wellness Score": [
      GaugeCondition(min: 1, max: 4, label: "Low", color: Color(0xffFA704E)),
      GaugeCondition(min: 4, max: 7, label: "Medium", color: Color(0xffEEC000)),
      GaugeCondition(
        min: 7,
        max: 10,
        label: "High (Good)",
        color: Color(0xff1BC76D),
      ),
    ],
    "Breathing Rate": [
      GaugeCondition(
        min: 0,
        max: 12,
        label: "Low (Bad)",
        color: Color(0xffEEC000),
      ),
      GaugeCondition(
        min: 12,
        max: 20,
        label: "Normal (Good)",
        color: Color(0xff1BC76D),
      ),
      GaugeCondition(
        min: 20,
        max: 30,
        label: "High (Bad)",
        color: Color(0xffEEC000),
      ),
    ],
    "Heart Rate": [
      GaugeCondition(min: 0, max: 60, label: "Low", color: Color(0xffEEC000)),
      GaugeCondition(
        min: 60,
        max: 100,
        label: "Normal",
        color: Color(0xff1BC76D),
      ),
      GaugeCondition(
        min: 100,
        max: 160,
        label: "High",
        color: Color(0xffEEC000),
      ),
    ],
    "PRQ": [
      GaugeCondition(min: 0, max: 4, label: "Low", color: Color(0xffEEC000)),
      GaugeCondition(min: 4, max: 5, label: "Normal", color: Color(0xff1BC76D)),
      GaugeCondition(min: 5, max: 10, label: "High", color: Color(0xffEEC000)),
    ],
    "Blood Pressure Systolic": [
      GaugeCondition(min: 0, max: 100, label: "Low", color: Color(0xffEEC000)),
      GaugeCondition(
        min: 100,
        max: 129,
        label: "Normal",
        color: Color(0xff1BC76D),
      ),
      GaugeCondition(
        min: 129,
        max: 140,
        label: "High",
        color: Color(0xffFA704E),
      ),
    ],
    "Blood Pressure Daistolic": [
      GaugeCondition(min: 0, max: 100, label: "Low", color: Color(0xffEEC000)),
      GaugeCondition(
        min: 100,
        max: 129,
        label: "Normal",
        color: Color(0xff1BC76D),
      ),
      GaugeCondition(
        min: 129,
        max: 140,
        label: "High",
        color: Color(0xffFA704E),
      ),
    ],
    "Oxygen Saturation": [
      GaugeCondition(min: 0, max: 95, label: "Low", color: Color(0xffFA704E)),
      GaugeCondition(
        min: 95,
        max: 120,
        label: "Normal",
        color: Color(0xff1BC76D),
      ),
    ],
    "Hemoglobin": [
      GaugeCondition(min: 0, max: 14, label: "Low", color: Color(0xffEEC000)),
      GaugeCondition(
        min: 14,
        max: 18,
        label: "Normal",
        color: Color(0xff1BC76D),
      ),
      GaugeCondition(min: 18, max: 30, label: "High", color: Color(0xffEEC000)),
    ],
    "Hemoglobin A1C": [
      GaugeCondition(
        min: 0,
        max: 5.6,
        label: "Normal",
        color: Color(0xff1BC76D),
      ),
      GaugeCondition(
        min: 5.7,
        max: 6.4,
        label: "Prediabetes risk",
        color: Color(0xffEEC000),
      ),
      GaugeCondition(
        min: 6.5,
        max: 13,
        label: "Diabetes risk",
        color: Color(0xffFA704E),
      ),
    ],
    "ASCVD Risk": [
      GaugeCondition(min: 0, max: 1, label: "Low", color: Color(0xff1BC76D)),
      GaugeCondition(
        min: 1,
        max: 30,
        label: "Normal",
        color: Color(0xffEEC000),
      ),
      GaugeCondition(
        min: 30,
        max: 100,
        label: "High",
        color: Color(0xffFA704E),
      ),
    ],
    "HRV SDNN": [
      GaugeCondition(min: 0, max: 50, label: "Low", color: Color(0xffFA704E)),
      GaugeCondition(
        min: 50,
        max: 100,
        label: "Normal",
        color: Color(0xff1BC76D),
      ),
    ],
    "PNS Index": [
      GaugeCondition(min: -10, max: -1, label: "Low", color: Color(0xffFA704E)),
      GaugeCondition(
        min: -1,
        max: 1,
        label: "Normal",
        color: Color(0xffEEC000),
      ),
      GaugeCondition(min: 1, label: "High", color: Color(0xff1BC76D)),
    ],
    "SNS Index": [
      GaugeCondition(min: -10, max: -1, label: "Low", color: Color(0xff1BC76D)),
      GaugeCondition(
        min: -1,
        max: 1,
        label: "Normal",
        color: Color(0xffEEC000),
      ),
      GaugeCondition(min: 1, max: 10, label: "High", color: Color(0xffFA704E)),
    ],
    "SD1": [
      GaugeCondition(min: 2.5, max: 16, label: "Low", color: Color(0xffFA704E)),
      GaugeCondition(
        min: 16,
        max: 48,
        label: "Normal",
        color: Color(0xffEEC000),
      ),
      GaugeCondition(
        min: 48,
        max: 230,
        label: "High",
        color: Color(0xff1BC76D),
      ),
    ],
    "SD2": [
      GaugeCondition(min: 9, max: 52, label: "Low", color: Color(0xff1BC76D)),
      GaugeCondition(
        min: 52,
        max: 84,
        label: "Normal",
        color: Color(0xffEEC000),
      ),
      GaugeCondition(
        min: 84,
        max: 245,
        label: "High",
        color: Color(0xffFA704E),
      ),
    ],
    "Baevsky Stress Index": [
      GaugeCondition(min: 0, max: 80, label: "Low", color: Color(0xff1BC76D)),
      GaugeCondition(
        min: 81,
        max: 150,
        label: "Normal",
        color: Color(0xffEEC000),
      ),
      GaugeCondition(
        min: 150,
        max: 300,
        label: "Mild",
        color: Color(0xffEEC000),
      ),
      GaugeCondition(
        min: 300,
        max: 600,
        label: "High",
        color: Color(0xffED9A33),
      ),
      GaugeCondition(
        min: 600,
        max: 1000,
        label: "Very High",
        color: Color(0xffFA704E),
      ),
    ],
    "Normalized Stress Index": [
      GaugeCondition(min: 0, max: 29, label: "Low", color: Color(0xff1BC76D)),
      GaugeCondition(
        min: 29,
        max: 40,
        label: "Normal",
        color: Color(0xff9ED042),
      ),
      GaugeCondition(min: 40, max: 67, label: "Mild", color: Color(0xffEEC000)),
      GaugeCondition(min: 67, max: 97, label: "High", color: Color(0xffED9A33)),
      GaugeCondition(
        min: 97,
        max: 100,
        label: "Very High",
        color: Color(0xffFA704E),
      ),
    ],
    "Mean RRi": [
      GaugeCondition(min: 50, max: 600, label: "Low", color: Color(0xffFA704E)),
      GaugeCondition(
        min: 600,
        max: 1000,
        label: "Normal",
        color: Color(0xffEEC000),
      ),
      GaugeCondition(
        min: 1000,
        max: 2000,
        label: "High",
        color: Color(0xff1BC76D),
      ),
    ],
    "RMSSD": [
      GaugeCondition(min: 0, max: 25, label: "Low", color: Color(0xffFA704E)),
      GaugeCondition(
        min: 24,
        max: 43,
        label: "Normal",
        color: Color(0xffEEC000),
      ),
      GaugeCondition(
        min: 43,
        max: 100,
        label: "High",
        color: Color(0xff1BC76D),
      ),
    ],
  };
}

class GaugeCondition {
  final double? min;
  final double? max;
  final String label;
  final Color color;

  GaugeCondition({
    this.min,
    this.max,
    required this.label,
    required this.color,
  });
}
