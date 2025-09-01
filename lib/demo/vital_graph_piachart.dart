import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ntt_data/core/utils/extentions.dart';
import 'package:ntt_data/data/models/vital_graph_response_model.dart';

import '../core/constants/app_colors.dart';

class VitalPieChart extends StatefulWidget {
  const VitalPieChart({super.key, required this.vitalValue});

  final List<HealthList> vitalValue;

  @override
  State<VitalPieChart> createState() => _VitalPieChartState();
}

class _VitalPieChartState extends State<VitalPieChart> {
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Row(
        children: <Widget>[
          const SizedBox(height: 18),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1.2,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex =
                            pieTouchResponse
                                .touchedSection!
                                .touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 1,
                  centerSpaceRadius: 80,
                  sections: showingSections(widget.vitalValue),
                ),
              ),
            ),
          ),

          const SizedBox(width: 28),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(List<HealthList> vitalValue) {
    return List.generate(widget.vitalValue.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 100.0 : 80.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      return PieChartSectionData(
        showTitle: true,
        color: getStatusColor(vitalValue[i].value.toString().toString()),
        value: 50,
        title: vitalValue[i].value?.toFirstCaps(),
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: AppColors.btntext,
          shadows: shadows,
        ),
      );
    });
  }

  Color getStatusColor(String level) {
    switch (level.toLowerCase()) {
      case "high":
      case "normal":
        return const Color(0xFF1BC76D);
      case "medium":
        return const Color(0xFFEEC000);
      case "low":
        return const Color(0xFFFA704E);
      default:
        return Colors.grey;
    }
  }
}
