import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/extentions.dart';
import 'package:ntt_data/data/models/vital_graph_response_model.dart';
import 'package:ntt_data/modules/views/vital_graph/helper/vital_color_helper.dart';

// Mapper class to convert string values to numeric for chart
class StringToNumericMapper {
  final List<String> values;
  final bool isXAxis;

  StringToNumericMapper({required this.values, this.isXAxis = false});

  /// Get numeric value for a string
  double getValue(String str) {
    str = str.toLowerCase();
    final map = <String, double>{};
    for (int i = 0; i < values.length; i++) {
      var val = values[i];
      if (isXAxis) {
        if (val.toLowerCase() == "yesterday") {
          val = (DateTime.now().day - 1).toString();
        } else if (val.toLowerCase() == "today") {
          val = DateTime.now().day.toString();
        }
      }
      map[values[i]] = i.toDouble();
    }

    return map[str] ?? 0.0;
  }

  /// Get string label from numeric value
  String getLabel(double numericValue) {
    int index = numericValue.toInt();
    if (index >= 0 && index < values.length) {
      if (isXAxis) {
        if (values[index].toLowerCase() == "yesterday") {
          return (DateTime.now().day - 1).toString();
        } else if (values[index].toLowerCase() == "today") {
          return DateTime.now().day.toString();
        }
      }
      return values[index];
    }
    return "";
  }
}

/// Custom Line Chart Widget
class CustomLineBarChart extends StatefulWidget {
  final List<String> leftTitles;
  final List<String> bottomTitles;
  final List<HealthList> vitalValues;
  final String vitalName;

  const CustomLineBarChart({
    super.key,
    required this.leftTitles,
    required this.bottomTitles,
    required this.vitalValues,
    required this.vitalName,
  });

  @override
  State<CustomLineBarChart> createState() => _CustomLineBarChartState();
}

class _CustomLineBarChartState extends State<CustomLineBarChart> {
  List<FlSpot> _generateSpots() {
    final yMapper = StringToNumericMapper(values: widget.leftTitles);
    return List.generate(widget.vitalValues.length, (index) {
      final x = index.toDouble();
      final yValue = widget.vitalValues[index].value ?? "";
      String strValue =
          (index < widget.vitalValues.length)
              ? widget.vitalValues[index].value?.toLowerCase() ?? ""
              : "";

      double value = stringToIndex[strValue]?.toDouble() ?? 0;
      final y = yMapper.getValue(yValue);
      return FlSpot(x, value);
    });
  }

  /// Build X-axis titles
  Widget _buildBottomTitle(double value, TitleMeta meta) {
    final xMapper = StringToNumericMapper(
      values: widget.bottomTitles,
      isXAxis: true,
    );
    return Text(
      xMapper.getLabel(value),
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.searchColor,
      ),
    );
  }

  /// Build Y-axis titles
  Widget _buildLeftTitle(double value, TitleMeta meta) {
    String? label =
        stringToIndex.entries
            .firstWhere(
              (entry) => entry.value == value.toInt(),
              orElse: () => const MapEntry("", 0),
            )
            .key;

    return Text(
      label.isNotEmpty ? label.toFirstCaps() : "",
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.searchColor,
      ),
    );
  }

  final List<String> yLevels = [
    "low",
    "medium",
    "normal",
    "mild",
    "high",
    "very high",
  ];

  late Map<String, int> stringToIndex;

  @override
  void initState() {
    stringToIndex = {
      for (int i = 0; i < yLevels.length; i++) yLevels[i]: i + 1,
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final spots = _generateSpots();
    return Padding(
      padding: AppDimensions.symmetric(horizontal: 10, vertical: 10),
      child: SizedBox(
        width: double.infinity,
        height: AppDimensions.height(200),
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                fitInsideVertically: true,
                showOnTopOfTheChartBoxArea: true,
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map((spot) {
                    final item = widget.vitalValues[spot.spotIndex];
                    var vitalGraphColor = VitalColorHelper(
                      vitalName: widget.vitalName,
                      vitalStatus: item.status.toString(),
                      isLowGood: stringToBool(item.isTypeVital.toString()),
                    );
                    // Reverse lookup string label for tooltip
                    String label =
                        stringToIndex.entries
                            .firstWhere(
                              (entry) => entry.value.toDouble() == spot.y,
                              orElse: () => const MapEntry("", 0),
                            )
                            .key;
                    return LineTooltipItem(
                      label.isNotEmpty
                          ? label.toFirstCaps()
                          : spot.y.toStringAsFixed(1),
                      TextStyle(
                        color: vitalGraphColor.getColor(),
                        fontSize: 12,
                      ),
                    );
                  }).toList();
                },
              ),
            ),
            minX: 0,
            maxX: (widget.bottomTitles.length - 1).toDouble(),
            minY: 0,
            maxY: 6,
            gridData: FlGridData(show: false),
            borderData: FlBorderData(
              show: true,
              border: const Border(
                left: BorderSide(width: 0.5, color: Color(0xffE0E0E0)),
                bottom: BorderSide(width: 0.5, color: Color(0xffE0E0E0)),
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: _buildBottomTitle,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: _buildLeftTitle,
                  reservedSize: 50,
                ),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                barWidth: 2,
                color: AppColors.primary,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    final item = widget.vitalValues[index];

                    // Call your helper
                    var vitalGraphColor = VitalColorHelper(
                      vitalName: widget.vitalName,
                      vitalStatus: item.value.toString(),
                      isLowGood: stringToBool(item.isTypeVital.toString()),
                    );

                    return FlDotCirclePainter(
                      radius: 4,
                      color: vitalGraphColor.getColor(),
                      strokeWidth: 1,
                      strokeColor: AppColors.backArrowColor,
                    );
                  },
                ),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xffD0FBFF).withOpacity(0.6),
                      const Color(0xffDDF2F4).withOpacity(0.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool stringToBool(String value) {
    return value.toLowerCase() == 'true';
  }
}
