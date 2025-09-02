import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/extentions.dart';
import 'package:ntt_data/data/models/vital_graph_response_model.dart';
import 'package:ntt_data/modules/views/vital_graph/controller/vital_graph_controller.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

import '../core/constants/app_colors.dart';
import 'package:intl/intl.dart';

class VitalPieChart extends StatefulWidget {
  const VitalPieChart({
    super.key,
    required this.vitalValue,
    required this.controller,
  });

  final List<HealthList> vitalValue;
  final VitalGraphController controller;

  @override
  State<VitalPieChart> createState() => _VitalPieChartState();
}

class _VitalPieChartState extends State<VitalPieChart> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: PieChart(
              curve: Curves.fastLinearToSlowEaseIn,
              PieChartData(
                titleSunbeamLayout: true,
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      widget.controller.touchedIndex.value = -1;
                      return;
                    }
                    widget.controller.touchedIndex.value =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  },
                ),
                borderData: FlBorderData(show: true),
                sectionsSpace: 2,
                centerSpaceRadius: 30,
                sections: showingSections(widget.vitalValue),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(List<HealthList> vitalValue) {
    return List.generate(widget.vitalValue.length, (i) {
      widget.controller.isTouched.value =
          i == widget.controller.touchedIndex.value;
      widget.controller.fontSize.value =
          widget.controller.isTouched.value
              ? AppDimensions.font(18.0)
              : AppDimensions.font(16.0);
      widget.controller.radius.value =
          widget.controller.isTouched.value ? 130.0 : 120.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      return PieChartSectionData(
        showTitle: true,
        color: getStatusColor(vitalValue[i].value.toString().toString()),
        value: 50,
        title: vitalValue[i].value?.toFirstCaps(),
        radius: widget.controller.radius.value,
        titleStyle: TextStyle(
          fontSize: widget.controller.fontSize.value,
          fontWeight: FontWeight.bold,
          color: AppColors.btntext,
          shadows: shadows,
        ),
        badgeWidget:
            widget.controller.isTouched.isTrue
                ? CommonText.text(
                  dateFormate(vitalValue[i].scannedDate.toString()),
                )
                : SizedBox.shrink(),
        badgePositionPercentageOffset: 0.99,
        titlePositionPercentageOffset: 0.70,
      );
    });
  }

  String dateFormate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    String formattedDate = DateFormat("dd MMM hh:mm a").format(parsedDate);
    return formattedDate;
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
