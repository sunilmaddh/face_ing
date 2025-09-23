import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/data/models/vital_graph_response_model.dart';
import 'package:ntt_data/modules/views/vital_graph/helper/vital_color_helper.dart';

class VitalGraphWidget extends StatefulWidget {
  const VitalGraphWidget({
    super.key,
    required this.leftTitle,
    required this.bottomTitles,
    required this.vitalValue,
    required this.vitalName,
  });

  final List<String> leftTitle;
  final List<String> bottomTitles;
  final List<HealthList> vitalValue;
  final String vitalName;

  @override
  State<VitalGraphWidget> createState() => _VitalGraphWidgetState();
}

class _VitalGraphWidgetState extends State<VitalGraphWidget> {
  final double barWidth = 10;

  late List<BarChartGroupData> showingBarGroups;

  // Numeric left values
  late List<double> numericLeftValues;
  late double minY;
  late double maxY;

  @override
  void initState() {
    super.initState();
    processLeftAxis();
    storeBarChartData();
  }

  void processLeftAxis() {
    // Convert left labels to double
    numericLeftValues =
        widget.leftTitle.map((e) => double.tryParse(e) ?? 0).toList();

    if (numericLeftValues.isEmpty) {
      minY = 0;
      maxY = 10;
      return;
    }

    numericLeftValues.sort();
    minY = numericLeftValues.first;
    maxY = numericLeftValues.last;

    // Ensure zero is included if minY > 0
    if (minY > 0) minY = 0;

    // Add 10% padding to top
    double range = maxY - minY;
    if (range == 0) range = maxY * 0.1;
    maxY += range * 0.1;
  }

  void storeBarChartData() {
    showingBarGroups = [];

    for (int i = 0; i < widget.bottomTitles.length; i++) {
      double value = 0;
      Color color = AppColors.borderColor;

      if (i < widget.vitalValue.length) {
        value = double.tryParse(widget.vitalValue[i].value ?? "0") ?? 0;

        var isTypeVital =
            widget.vitalValue[i].isTypeVital.toString().toLowerCase() == "true";

        var vitalGraphColor = VitalColorHelper(
          vitalName: widget.vitalName,
          vitalStatus: widget.vitalValue[i].status.toString(),
          isLowGood: isTypeVital,
        );

        color = vitalGraphColor.getColor();
      }

      showingBarGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [BarChartRodData(toY: value, color: color, width: barWidth)],
        ),
      );
    }
  }

  String getLabel(double numericValue) {
    int index = numericValue.toInt();
    if (index >= 0 && index < widget.bottomTitles.length) {
      if (widget.bottomTitles[index].toLowerCase() == "yesterday") {
        return (DateTime.now().day - 1).toString();
      }
      return widget.bottomTitles[index];
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
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
                  tooltipMargin: 8,
                  fitInsideVertically: true,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    return BarTooltipItem(
                      rod.toY.toStringAsFixed(1),
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
                    interval: 1,
                    reservedSize: 30,
                    getTitlesWidget: bottomTitles,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 35,
                    interval: 1,
                    getTitlesWidget: leftTitles,
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border(
                  left: BorderSide(width: 0.5, color: Color(0xffE0E0E0)),
                  bottom: BorderSide(width: 0.5, color: Color(0xffE0E0E0)),
                ),
              ),
              barGroups: showingBarGroups,
              gridData: const FlGridData(show: false, drawVerticalLine: false),
            ),
          ),
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    // Show only if value exactly matches a numericLeftValue
    if (numericLeftValues.contains(value)) {
      int index = numericLeftValues.indexOf(value);
      return SideTitleWidget(
        meta: meta,
        space: 4,
        child: Text(
          widget.leftTitle[index],
          style: const TextStyle(
            color: Color(0xff7589a2),
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

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
            color: Color(0xffE0E0E0),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
