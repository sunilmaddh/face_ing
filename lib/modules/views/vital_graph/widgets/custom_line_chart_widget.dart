import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/data/models/vital_graph_response_model.dart';
import 'package:ntt_data/modules/views/vital_graph/helper/vital_color_helper.dart';

class CustomLineChartWidget extends StatefulWidget {
  const CustomLineChartWidget({
    super.key,
    required this.leftTitles,
    required this.bottomTitles,
    required this.vitalValues,
    required this.vitalName,
  });

  final List<String> leftTitles;
  final List<String> bottomTitles;
  final List<HealthList> vitalValues;
  final String vitalName;

  @override
  State<CustomLineChartWidget> createState() => _CustomLineChartWidgetState();
}

class _CustomLineChartWidgetState extends State<CustomLineChartWidget> {
  int? touchedIndex;

  List<FlSpot> get spots => List.generate(widget.vitalValues.length, (i) {
    final y = double.tryParse(widget.vitalValues[i].value ?? "0.0") ?? 0.0;
    return FlSpot(i.toDouble(), y);
  });

  bool stringToBool(String value) => value.toLowerCase() == 'true';

  double getMinY(List<FlSpot> spots) {
    if (spots.isEmpty) return 0;
    double minY = spots.map((s) => s.y).reduce((a, b) => a < b ? a : b);
    if (minY > 0) minY = 0; // keep 0 if all values are positive
    return minY;
  }

  double getMaxY(List<FlSpot> spots) {
    if (spots.isEmpty) return 1;
    double maxY = spots.map((s) => s.y).reduce((a, b) => a > b ? a : b);
    return maxY;
  }

  Widget _buildBottomTitle(double value, TitleMeta meta) {
    int index = value.toInt();
    if (index < 0 || index >= widget.bottomTitles.length)
      return const SizedBox.shrink();
    return Text(
      widget.bottomTitles[index],
      style: const TextStyle(fontSize: 12, color: AppColors.searchColor),
    );
  }

  Widget _buildLeftTitle(double value, TitleMeta meta) {
    int index = value.toInt();
    if (index < 0 || index >= widget.leftTitles.length)
      return const SizedBox.shrink();
    return Text(
      widget.leftTitles[index],
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    final chartSpots = spots;

    if (chartSpots.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: AppDimensions.height(150),
        child: const Center(child: Text("No data available")),
      );
    }

    double minY = getMinY(chartSpots);
    double maxY = getMaxY(chartSpots);

    // Prevent zero range
    if (minY == maxY) maxY = minY + 1;

    return SizedBox(
      width: double.infinity,
      height: AppDimensions.height(150),
      child: Padding(
        padding: AppDimensions.symmetric(horizontal: 10, vertical: 10),
        child: LineChart(
          LineChartData(
            minY: minY,
            maxY: maxY,
            maxX: (widget.bottomTitles.length - 1).toDouble(),
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: _buildBottomTitle,
                ),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                  interval: 1,
                  reservedSize: 30,
                  getTitlesWidget: _buildLeftTitle,
                ),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
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
                spots: chartSpots,
                isCurved: true,
                color: AppColors.primary,
                barWidth: 2,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    final item = widget.vitalValues[index];
                    final color =
                        VitalColorHelper(
                          vitalName: widget.vitalName,
                          vitalStatus: item.status.toString(),
                          isLowGood: stringToBool(item.isTypeVital.toString()),
                        ).getColor();

                    // Hide permanent value if this spot is being touched
                    if (touchedIndex == index) {
                      return FlDotCirclePainter(
                        radius: 0,
                        color: color,
                        strokeWidth: 0,
                      );
                    }

                    return _ValueDotPainter(spot, textColor: color);
                  },
                ),
              ),
            ],
            lineTouchData: LineTouchData(
              handleBuiltInTouches: true,
              touchCallback: (event, response) {
                if (!event.isInterestedForInteractions ||
                    response == null ||
                    response.lineBarSpots == null) {
                  setState(() => touchedIndex = null);
                  return;
                }
                setState(
                  () => touchedIndex = response.lineBarSpots![0].spotIndex,
                );
              },
              getTouchedSpotIndicator: (barData, indicators) {
                return indicators.map((index) {
                  return TouchedSpotIndicatorData(
                    FlLine(color: AppColors.primary, strokeWidth: 2.0),
                    FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        final item = widget.vitalValues[index];
                        final color =
                            VitalColorHelper(
                              vitalName: widget.vitalName,
                              vitalStatus: item.status.toString(),
                              isLowGood: stringToBool(
                                item.isTypeVital.toString(),
                              ),
                            ).getColor();

                        // Hide permanent value if this spot is being touched

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
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map((spot) {
                    final item = widget.vitalValues[spot.spotIndex];
                    final color =
                        VitalColorHelper(
                          vitalName: widget.vitalName,
                          vitalStatus: item.status.toString(),
                          isLowGood: stringToBool(item.isTypeVital.toString()),
                        ).getColor();

                    return LineTooltipItem(
                      formatDouble(spot.y).toString(),
                      TextStyle(color: color, fontWeight: FontWeight.bold),
                    );
                  }).toList();
                },
                getTooltipColor: (touchedSpot) => Colors.transparent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Permanent value painter
class _ValueDotPainter extends FlDotPainter {
  final FlSpot spot;
  final Color textColor;
  final EdgeInsets padding;

  _ValueDotPainter(
    this.spot, {
    required this.textColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
  });

  @override
  void draw(Canvas canvas, FlSpot spot, Offset offsetInCanvas) {
    // Prepare text
    final textPainter = TextPainter(
      text: TextSpan(
        text: formatDouble(spot.y).toString(),
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();

    // Calculate background rect with padding
    final rect = Rect.fromLTWH(
      offsetInCanvas.dx - textPainter.width / 2 - padding.left - 2,
      offsetInCanvas.dy -
          textPainter.height -
          padding.top -
          10, // 4 for spacing above the dot
      textPainter.width + padding.horizontal,
      textPainter.height + padding.vertical,
    );

    // Draw rounded background
    final paint =
        Paint()..color = Colors.transparent; // optional background color
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(4)),
      paint,
    );

    // Draw text
    textPainter.paint(
      canvas,
      Offset(rect.left + padding.left, rect.top + padding.top),
    );
  }

  @override
  Size getSize(FlSpot spot) => const Size(0, 0);

  @override
  // TODO: implement mainColor
  Color get mainColor => throw UnimplementedError();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  @override
  FlDotPainter lerp(FlDotPainter a, FlDotPainter b, double t) {
    // TODO: implement lerp
    throw UnimplementedError();
  }
}

dynamic formatDouble(double value) {
  // If the value has no fractional part, return as int
  if (value % 1 == 0) {
    return value.toInt();
  }
  // Otherwise, return as double
  return value;
}
