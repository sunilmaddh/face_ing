import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/extentions.dart';
import 'package:ntt_data/modules/vital_graph/models/vital_graph_response_model.dart';
import 'package:ntt_data/modules/vital_graph/helper/vital_color_helper.dart';

class VitalGraphEmptyWidget extends StatefulWidget {
  const VitalGraphEmptyWidget({
    super.key,
    required this.leftTitle,
    required this.bottomTitles,
    required this.vitalValue,
    required this.vitalName,
  });

  final Color leftBarColor = AppColors.primary;
  final Color rightBarColor = AppColors.borderColor;
  final List<String> leftTitle;
  final List<String> bottomTitles;
  final List<HealthList> vitalValue;
  final String vitalName;

  @override
  State<VitalGraphEmptyWidget> createState() => _VitalGraphWidgetStringState();
}

class _VitalGraphWidgetStringState extends State<VitalGraphEmptyWidget> {
  final double width = 10;

  late List<BarChartGroupData> showingBarGroups;

  /// Define levels (ordered)
  final List<String> yLevels = [
    "low",
    "medium",
    "mild",
    "normal",
    "high",
    "very high",
  ];

  late Map<String, int> stringToIndex;

  @override
  void initState() {
    super.initState();
    // Map strings → numbers starting from 5
    stringToIndex = {
      for (int i = 0; i < widget.leftTitle.length; i++)
        widget.leftTitle[i]: i + 2,
    };
    storeBarChartData();
  }

  void storeBarChartData() {
    final items = <BarChartGroupData>[];

    for (int i = 0; i < widget.bottomTitles.length; i++) {
      String strValue =
          (i < widget.vitalValue.length)
              ? widget.vitalValue[i].value?.toLowerCase() ?? ""
              : "";

      double value = stringToIndex[strValue]?.toDouble() ?? 0;

      // Use your VitalColorHelper if needed
      Color color = AppColors.primary;
      if (i < widget.vitalValue.length) {
        var isTypeVital = AppMethods.stringToBool(
          widget.vitalValue[i].isTypeVital.toString(),
        );
        var vitalGraphColor = VitalColorHelper(
          vitalName: widget.vitalName,
          vitalStatus: widget.vitalValue[i].value.toString(),
          isLowGood: isTypeVital,
        );
        color = vitalGraphColor.getColor();
      }

      final barGroup = makeGroupData(i, value, color);
      items.add(barGroup);
    }

    showingBarGroups = items;
  }

  /// 🔹 Calculate maxY based on string levels (last value in mapping)
  double getMaxY() => (stringToIndex.values.last + 1).toDouble();
  String getLabel(double numericValue) {
    int index = numericValue.toInt();

    if (index >= 0 && index < widget.bottomTitles.length) {
      if (widget.bottomTitles[index] == "1") {
        return widget.bottomTitles[index];
      } else if (widget.bottomTitles[index] == "5") {
        return widget.bottomTitles[index];
      } else if (widget.bottomTitles[index] == "10") {
        return widget.bottomTitles[index];
      } else if (widget.bottomTitles[index] == "15") {
        return widget.bottomTitles[index];
      } else if (widget.bottomTitles[index] == "20") {
        return widget.bottomTitles[index];
      } else if (widget.bottomTitles[index] == "25") {
        return widget.bottomTitles[index];
      } else if (widget.bottomTitles[index] == "30") {
        return widget.bottomTitles[index];
      } else {
        return '';
      }
    }

    return "";
  }

  @override
  Widget build(BuildContext context) {
    final maxY = getMaxY();

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: AppDimensions.width(1000.0),
        height: 200,
        child: BarChart(
          BarChartData(
            baselineY: 0,
            maxY: maxY,
            alignment: BarChartAlignment.spaceAround,
            barTouchData: BarTouchData(
              enabled: true,
              touchTooltipData: BarTouchTooltipData(
                fitInsideVertically: true,
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  String label =
                      stringToIndex.entries
                          .firstWhere(
                            (entry) => entry.value == rod.toY.toInt(),
                            orElse: () => const MapEntry("", 0),
                          )
                          .key;
                  return BarTooltipItem(
                    label.isNotEmpty
                        ? label.toFirstCaps()
                        : rod.toY.toStringAsFixed(1),
                    const TextStyle(color: Colors.white, fontSize: 12),
                  );
                },
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 5,
                  reservedSize: 42,
                  getTitlesWidget: bottomTitles,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 55,
                  interval: 1,
                  getTitlesWidget: leftTitles,
                ),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border(
                left: BorderSide(width: 1.0, color: AppColors.searchColor),
                bottom: BorderSide(width: 1.0, color: AppColors.searchColor),
              ),
            ),
            barGroups: showingBarGroups,
            gridData: const FlGridData(show: false, drawVerticalLine: false),
          ),
        ),
      ),
    );
  }

  /// 🔹 Left Y-axis labels (strings instead of numbers)
  Widget leftTitles(double value, TitleMeta meta) {
    String? label =
        stringToIndex.entries
            .firstWhere(
              (entry) => entry.value == value.toInt(),
              orElse: () => const MapEntry("", 0),
            )
            .key;

    return Text(
      textAlign: TextAlign.start,
      label.isNotEmpty ? label.toFirstCaps() : "",
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.searchColor,
      ),
    );
  }

  /// 🔹 Bottom X-axis labels
  Widget bottomTitles(double value, TitleMeta meta) {
    if (value.toInt() < widget.bottomTitles.length) {
      return SideTitleWidget(
        meta: meta,
        space: 2,
        child: Text(
          getLabel(value),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.searchColor,
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  /// 🔹 Build each bar
  BarChartGroupData makeGroupData(int x, double y1, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: color,
          width: width,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          borderSide: BorderSide(color: AppColors.borderColor),
        ),
      ],
    );
  }
}
