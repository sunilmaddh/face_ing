// ignore_for_file: deprecated_member_use

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/data/models/pulse_survey_model.dart';
import 'package:ntt_data/modules/views/pulse/helper/pulse_helper.dart';

class PulseLineChartWidget extends StatefulWidget {
  const PulseLineChartWidget({
    super.key,

    required this.bottomTitles,
    required this.vitalValues,
  });

  final List<String> bottomTitles;
  final List<PulseSurveyList> vitalValues;

  @override
  State<PulseLineChartWidget> createState() => _PulseLineChartWidgetState();
}

class _PulseLineChartWidgetState extends State<PulseLineChartWidget> {
  int? touchedIndex;

  /// ✅ Generate FlSpots for only valid (scanned) days
  List<FlSpot> getSpots() {
    final List<FlSpot> spots = [];

    for (int i = 0; i < widget.vitalValues.length; i++) {
      final value = widget.vitalValues[i].value;

      // Skip invalid or empty entries
      if (value == null || value.trim().isEmpty) continue;

      final parsedValue = double.tryParse(value);

      // Skip non-numeric entries
      if (parsedValue == null) continue;

      // Use index as X value (sequential days)
      spots.add(FlSpot(i.toDouble(), parsedValue));
    }

    return spots;
  }

  double getMinY(List<FlSpot> spots) {
    if (spots.isEmpty) return 0;
    double minY = spots.map((s) => s.y).reduce((a, b) => a < b ? a : b);
    return minY > 0 ? 0 : minY;
  }

  double getMaxY(List<FlSpot> spots) {
    if (spots.isEmpty) return 1;
    return spots.map((s) => s.y).reduce((a, b) => a > b ? a : b);
  }

  Widget _buildBottomTitle(double value, TitleMeta meta) {
    int index = value.toInt();

    if (index < 0 || index >= widget.bottomTitles.length) {
      return const SizedBox.shrink();
    }

    String label = widget.bottomTitles[index];

    return Text(
      label,
      style: const TextStyle(fontSize: 12, color: AppColors.searchColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    final spots = getSpots();

    if (spots.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: AppDimensions.height(120.h),
        child: const Center(child: Text("No data available")),
      );
    }

    double minY = getMinY(spots);
    double maxY = getMaxY(spots);
    if (minY == maxY) maxY = minY + 1;

    return SizedBox(
      width: double.infinity,
      height: AppDimensions.height(120.h),
      child: Padding(
        padding: AppDimensions.symmetric(horizontal: 15.w, vertical: 0.h),
        child: LineChart(
          curve: Curves.easeInCirc,
          duration: const Duration(milliseconds: 1200),
          LineChartData(
            minY: minY,
            minX: 0,
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
                ),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                color: AppColors.primary,
                barWidth: 2,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    final item = widget.vitalValues[spot.x.toInt()];
                    final color = PulseHelper().getColor(item.status ?? "Good");
                    if (touchedIndex == spot.x.toInt()) {
                      return FlDotCirclePainter(
                        radius: 1,
                        color: color,
                        strokeWidth: 1,
                      );
                    }
                    return _ValueDotPainter(spot, textColor: color);
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
            lineTouchData: LineTouchData(
              handleBuiltInTouches: true,
              touchCallback: (event, response) {
                if (!event.isInterestedForInteractions ||
                    response == null ||
                    response.lineBarSpots == null) {
                  setState(() => touchedIndex = null);
                  return;
                }
                setState(() {
                  for (var data in response.lineBarSpots!) {
                    touchedIndex = data.x.toInt();
                    return;
                  }
                });
              },
              getTouchedSpotIndicator: (barData, indicators) {
                return indicators.map((index) {
                  return TouchedSpotIndicatorData(
                    FlLine(color: AppColors.primary, strokeWidth: 2),
                    FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        final item = widget.vitalValues[spot.x.toInt()];
                        final color = PulseHelper().getColor(
                          item.status ?? "Good",
                        );
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
                    final item = widget.vitalValues[spot.x.toInt()];
                    final color = PulseHelper().getColor(item.status ?? "Good");

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

/// Permanent dot + value painter
class _ValueDotPainter extends FlDotPainter {
  final FlSpot spot;
  final Color textColor;
  final double radius;
  final EdgeInsets padding;

  _ValueDotPainter(
    this.spot, {
    required this.textColor,
    this.radius = 4,
    this.padding = const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
  });

  @override
  void draw(Canvas canvas, FlSpot spot, Offset offsetInCanvas) {
    // Draw circle
    final paint = Paint()..color = textColor;
    canvas.drawCircle(offsetInCanvas, radius, paint);

    // Draw value above dot
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

    final textOffset = Offset(
      offsetInCanvas.dx - textPainter.width / 2,
      offsetInCanvas.dy - textPainter.height - 4,
    );

    textPainter.paint(canvas, textOffset);
  }

  @override
  Size getSize(FlSpot spot) => const Size(0, 0);

  @override
  Color get mainColor => textColor;

  @override
  List<Object?> get props => [spot, textColor];

  @override
  FlDotPainter lerp(FlDotPainter a, FlDotPainter b, double t) => this;
}

dynamic formatDouble(double value) {
  if (value % 1 == 0) return value.toInt();
  return value;
}
