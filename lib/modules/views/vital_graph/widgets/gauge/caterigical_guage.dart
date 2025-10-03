import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/modules/views/vital_graph/helper/vital_graph_status.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CategoricalGauge extends StatelessWidget {
  final String vitalName;
  final String currentStatus; // e.g., "Medium"

  const CategoricalGauge({
    super.key,
    required this.vitalName,
    required this.currentStatus,
  });

  @override
  Widget build(BuildContext context) {
    final categories = VitalGraphStatus().categoricalVitals[vitalName] ?? [];
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
}
