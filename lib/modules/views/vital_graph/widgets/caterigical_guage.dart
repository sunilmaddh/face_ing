import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CategoricalGauge extends StatelessWidget {
  final String vitalName;
  final String currentStatus; // e.g., "Medium"

  CategoricalGauge({
    super.key,
    required this.vitalName,
    required this.currentStatus,
  });

  @override
  Widget build(BuildContext context) {
    final categories = categoricalVitals[vitalName] ?? [];
    if (categories.isEmpty) {
      return Center(child: Text("No data for $vitalName"));
    }

    final segmentCount = categories.length;
    final segmentSize = 100 / segmentCount;

    // ✅ Find current status index (case-insensitive)
    int currentIndex = categories.indexWhere(
      (c) =>
          c.status.toLowerCase().trim() == currentStatus.toLowerCase().trim(),
    );
    if (currentIndex == -1) currentIndex = 0;

    // ✅ Pointer color based on matched status
    final GaugeCategory? currentCategory =
        currentIndex >= 0 && currentIndex < categories.length
            ? categories[currentIndex]
            : null;

    return SfRadialGauge(
      axes: [
        RadialAxis(
          radiusFactor: 0.7,
          minimum: 0,
          maximum: 100,
          showTicks: false,
          showLabels: false,
          axisLineStyle: const AxisLineStyle(
            thickness: 15,
            cornerStyle: CornerStyle.bothFlat,
          ),
          ranges: List.generate(segmentCount, (i) {
            return GaugeRange(
              startValue: i * segmentSize,
              endValue: (i + 1) * segmentSize,
              color: categories[i].color,
            );
          }),
          pointers: [
            MarkerPointer(
              value: currentIndex * segmentSize + segmentSize / 2,
              markerType: MarkerType.circle,
              markerHeight: 15,
              markerWidth: 15,
              color: currentCategory?.color ?? AppColors.primary,
              borderColor: AppColors.btntext,
              borderWidth: 2,
              enableAnimation: true,
              animationDuration: 1000,
              animationType: AnimationType.ease,
            ),
          ],
        ),
      ],
    );
  }

  final Map<String, List<GaugeCategory>> categoricalVitals = {
    "High HbA1c Risk": [
      GaugeCategory(status: "Low", color: Color(0xff1BC76D)),
      GaugeCategory(status: "Medium", color: Color(0xffEEC000)),
      GaugeCategory(status: "High", color: Color(0xffFA704E)),
    ],
    "High Fasting Glucose Risk": [
      GaugeCategory(status: "Low", color: Color(0xff1BC76D)),
      GaugeCategory(status: "High", color: Color(0xffFA704E)),
    ],
    "High Total Cholesterol Risk": [
      GaugeCategory(status: "Low", color: Color(0xff1BC76D)),
      GaugeCategory(status: "Medium", color: Color(0xffEEC000)),
      GaugeCategory(status: "High", color: Color(0xffFA704E)),
    ],
    "Low Hemoglobin Risk": [
      GaugeCategory(status: "Low", color: Color(0xff1BC76D)),
      GaugeCategory(status: "High", color: Color(0xffFA704E)),
    ],
    "Stress Level": [
      GaugeCategory(status: "Low", color: Color(0xff1BC76D)),
      GaugeCategory(status: "Normal", color: Color(0xff9ED042)),
      GaugeCategory(status: "Mild", color: Color(0xffEEC000)),
      GaugeCategory(status: "High", color: Color(0xffED9A33)),
      GaugeCategory(status: "Very High", color: Color(0xffFA704E)),
    ],
    "High Blood Pressure Risk": [
      GaugeCategory(status: "Low", color: Color(0xff1BC76D)),
      GaugeCategory(status: "Medium", color: Color(0xffEEC000)),
      GaugeCategory(status: "High", color: Color(0xffFA704E)),
    ],
    "Recovery Ability (PNS Zone)": [
      GaugeCategory(status: "Low", color: Color(0xffFA704E)),
      GaugeCategory(status: "Normal", color: Color(0xffEEC000)),
      GaugeCategory(status: "High", color: Color(0xff1BC76D)),
    ],
    "Stress Response (SNS Zone)": [
      GaugeCategory(status: "Low", color: Color(0xff1BC76D)),
      GaugeCategory(status: "Normal", color: Color(0xffEEC000)),
      GaugeCategory(status: "High", color: Color(0xffFA704E)),
    ],
  };
}

class GaugeCategory {
  final String status; // e.g., "Low", "Medium", "High"
  final Color color;

  GaugeCategory({required this.status, required this.color});
}
