import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/modules/views/vital_graph/helper/vital_graph_status.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class VitalGauge extends StatelessWidget {
  final String vitalName;
  final double value;

  VitalGauge({super.key, required this.vitalName, required this.value});

  Color color = Colors.black;

  @override
  Widget build(BuildContext context) {
    final ranges = VitalGraphStatus().vitalConditions[vitalName] ?? [];
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
