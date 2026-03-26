import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/extentions.dart';
import 'package:ntt_data/modules/vital_graph/models/vital_graph_response_model.dart';
import 'package:ntt_data/modules/vital_graph/helper/vital_color_helper.dart';

/// Mapper class to convert string values to numeric for chart (X axis)
class StringToNumericMapper {
  final List<String> values;
  final bool isXAxis;

  StringToNumericMapper({required this.values, this.isXAxis = false});

  double getValue(String str) {
    str = str.toLowerCase();
    final map = <String, double>{};
    for (int i = 0; i < values.length; i++) {
      map[values[i]] = i.toDouble();
    }
    return map[str] ?? 0.0;
  }

  /// Get string label from numeric value
  String getLabel(double numericValue) {
    int index = numericValue.toInt();
    if (index < 0 || index >= values.length) return "";
    return values[index];
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

  /// Generate one spot for each date.
  /// ❗ If no measurement → fix Y at 0 (bottom).
  List<FlSpot> _generateSpots() {
    List<FlSpot> spots = [];
    const double noDataY = 0; // bottom line

    for (int i = 0; i < widget.bottomTitles.length; i++) {
      HealthList? item =
          i < widget.vitalValues.length ? widget.vitalValues[i] : null;

      double y;

      if (item != null &&
          item.value != null &&
          item.value!.isNotEmpty &&
          stringToIndex.containsKey(item.value!.toLowerCase())) {
        y = stringToIndex[item.value!.toLowerCase()]!.toDouble();
      } else {
        // 🔻 no measurement → always bottom
        y = noDataY;
      }

      spots.add(FlSpot(i.toDouble(), y));
    }

    return spots;
  }

  /// Build X-axis titles (BOTTOM)
  Widget _buildBottomTitle(double value, TitleMeta meta) {
    final xMapper = StringToNumericMapper(
      values: widget.bottomTitles,
      isXAxis: true,
    );

    String label = xMapper.getLabel(value);

    return SideTitleWidget(
      meta: meta,
      space: 4,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.searchColor,
        ),
      ),
    );
  }

  /// Build Y-axis titles (LEFT)
  Widget _buildLeftTitle(double value, TitleMeta meta) {
    String? label =
        stringToIndex.entries
            .firstWhere(
              (entry) => entry.value == value.toInt(),
              orElse: () => const MapEntry("", 0),
            )
            .key;

    return SideTitleWidget(
      meta: meta,
      space: 4,
      child: SizedBox(
        height: 40, // ⬅ FIXED HEIGHT → all labels stay same baseline
        child: Align(
          alignment: Alignment.centerRight, // perfect vertical centering
          child: Text(
            label.isNotEmpty ? label.toFirstCaps() : "",
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 12,
              height: 1.0, // removes padding
              color: AppColors.searchColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.vitalValues.toString());
    final spots = _generateSpots();

    return Padding(
      padding: AppDimensions.symmetric(horizontal: 10, vertical: 10),
      child: SizedBox(
        width: double.infinity,
        height: AppDimensions.height(200),
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(
              getTouchedSpotIndicator: (barData, indicators) {
                return indicators.map((index) {
                  final spot = barData.spots[index];
                  final int xIndex = spot.x.toInt();

                  final bool hasValue =
                      xIndex < widget.vitalValues.length &&
                      widget.vitalValues[xIndex].value != null &&
                      widget.vitalValues[xIndex].value!.isNotEmpty;

                  return TouchedSpotIndicatorData(
                    FlLine(color: AppColors.primary, strokeWidth: 2),
                    FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        if (!hasValue) {
                          // 🔘 No measurement → hollow dot at bottom
                          return FlDotCirclePainter(
                            radius: 6,
                            color: Colors.white,
                            strokeWidth: 2,
                            strokeColor: Colors.grey,
                          );
                        }

                        final item = widget.vitalValues[xIndex];
                        final color =
                            VitalColorHelper(
                              vitalName: widget.vitalName,
                              vitalStatus: item.value.toString(),
                              isLowGood: AppMethods.stringToBool(
                                item.isTypeVital.toString(),
                              ),
                            ).getColor();

                        return FlDotCirclePainter(
                          radius: 6,
                          color: color,
                          strokeWidth: 1,
                          strokeColor: AppColors.btntext,
                        );
                      },
                    ),
                  );
                }).toList();
              },
              touchTooltipData: LineTouchTooltipData(
                fitInsideVertically: true,
                showOnTopOfTheChartBoxArea: true,
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map((spot) {
                    final xIndex = spot.x.toInt();
                    final bool hasValue =
                        xIndex < widget.vitalValues.length &&
                        widget.vitalValues[xIndex].value != null &&
                        widget.vitalValues[xIndex].value!.isNotEmpty;

                    if (!hasValue) {
                      return LineTooltipItem(
                        "No data",
                        const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }

                    final item = widget.vitalValues[xIndex];
                    final color =
                        VitalColorHelper(
                          vitalName: widget.vitalName,
                          vitalStatus: item.value.toString(),
                          isLowGood: AppMethods.stringToBool(
                            item.isTypeVital.toString(),
                          ),
                        ).getColor();

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
                      TextStyle(color: color, fontWeight: FontWeight.bold),
                    );
                  }).toList();
                },
                getTooltipColor: (touchedSpot) => Colors.transparent,
              ),
            ),

            /// SCALING
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
                  reservedSize: 50,
                  getTitlesWidget: _buildLeftTitle,
                ),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),

            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: false, // straight line
                barWidth: 2,
                color: AppColors.primary,

                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    final xIndex = spot.x.toInt();

                    final bool hasValue =
                        xIndex < widget.vitalValues.length &&
                        widget.vitalValues[xIndex].value != null &&
                        widget.vitalValues[xIndex].value!.isNotEmpty;

                    if (!hasValue) {
                      // hollow grey dot at bottom
                      return FlDotCirclePainter(
                        radius: 4,
                        color: Colors.white,
                        strokeWidth: 1.5,
                        strokeColor: Colors.grey.shade300,
                      );
                    }

                    final item = widget.vitalValues[xIndex];

                    final vitalGraphColor =
                        VitalColorHelper(
                          vitalName: widget.vitalName,
                          vitalStatus: item.value.toString(),
                          isLowGood: AppMethods.stringToBool(
                            item.isTypeVital.toString(),
                          ),
                        ).getColor();

                    return FlDotCirclePainter(
                      radius: 4,
                      color: vitalGraphColor,
                      strokeWidth: 1.5,
                      strokeColor: vitalGraphColor,
                    );
                  },
                ),

                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xffD0FBFF),
                      const Color(0xffDDF2F4).withOpacity(0.2),
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
}
