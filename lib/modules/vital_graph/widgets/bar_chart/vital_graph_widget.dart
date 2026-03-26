import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/vital_graph/models/vital_graph_response_model.dart';
import 'package:ntt_data/modules/vital_graph/helper/vital_color_helper.dart';

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
    List<int> intList =
        widget.leftTitle.map((e) => double.parse(e).round()).toList();

    List<String> backToString = intList.map((e) => e.toString()).toList();
    numericLeftValues =
        backToString.map((e) => double.tryParse(e) ?? 0).toList();

    if (numericLeftValues.isEmpty) {
      minY = 0;
      maxY = 10;
      return;
    }

    numericLeftValues.sort();

    minY = 0;

    double positiveMax = numericLeftValues
        .where((v) => v > 0)
        .fold<double>(
          0,
          (previousValue, element) =>
              element > previousValue ? element : previousValue,
        );
    maxY = positiveMax;

    // Add 10% padding
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

        bool isTypeVital =
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
          barRods: [
            BarChartRodData(
              fromY: value < 0 ? 0 : 0,
              toY: value,
              color: color,
              width: barWidth,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              borderSide: BorderSide(color: AppColors.borderColor),
            ),
          ],
        ),
      );
    }
  }

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
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(8.0),
      clipBehavior: Clip.none, // allow negative bars to overflow
      child: SizedBox(
        width: AppDimensions.width(1000.0),
        height: 200,
        child: BarChart(
          BarChartData(
            minY: minY,
            maxY: maxY,
            alignment: BarChartAlignment.spaceAround,
            barTouchData: BarTouchData(
              handleBuiltInTouches: true,
              touchExtraThreshold: EdgeInsets.only(
                top: 0,
                bottom: 50,
                left: 0,
                right: 0,
              ),
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

  Widget leftTitles(double value, TitleMeta meta) {
    for (int i = 0; i < numericLeftValues.length; i++) {
      if ((numericLeftValues[i] - value).abs() < 0.001) {
        var v = double.tryParse(widget.leftTitle[i]) ?? 0;
        var value = v.toInt();
        return SideTitleWidget(
          meta: meta,
          space: 4,
          child: Text(
            value.toString(),
            style: const TextStyle(
              color: AppColors.searchColor,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        );
      }
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
            color: AppColors.searchColor,
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
