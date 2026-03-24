// ignore_for_file: deprecated_member_use

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/data/models/pulse_survey_model.dart';
import 'package:ntt_data/modules/views/landing/pulse/helper/pulse_helper.dart';
import 'package:ntt_data/modules/views/vital_graph/widgets/line_chart/custom_line_chart_widget.dart';

class PulseLineChartWidget extends StatefulWidget {
  const PulseLineChartWidget({
    super.key,
    required this.bottomTitles,
    required this.vitalValues,
    required this.height,
  });

  final List<String> bottomTitles;
  final List<PulseSurveyList> vitalValues;
  final double height;

  @override
  State<PulseLineChartWidget> createState() => _PulseLineChartWidgetState();
}

class _PulseLineChartWidgetState extends State<PulseLineChartWidget> {
  int? touchedIndex;

  List<FlSpot> getSpots() {
    final List<FlSpot> spots = [];

    double lastValue = 0; // If you prefer last-known-value → use this

    for (int i = 0; i < widget.vitalValues.length; i++) {
      final value = widget.vitalValues[i].value;

      double y;

      if (value == null || value.trim().isEmpty) {
        // OPTION A: missing → show 0
        y = 0;

        // OPTION B: missing → repeat last known value
        // y = lastValue;
      } else {
        final parsed = double.tryParse(value);
        y = parsed ?? 0;
        lastValue = y;
      }

      spots.add(FlSpot(i.toDouble(), y));
    }

    return spots;
  }

  double getMinY(List<FlSpot> spots) {
    if (spots.isEmpty) return 0;
    return spots.map((s) => s.y).reduce((a, b) => a < b ? a : b);
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

    return Text(
      widget.bottomTitles[index],
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
    if (minY == maxY) maxY = minY + 3;

    return SizedBox(
      width: double.infinity,
      height: AppDimensions.height(widget.height),
      child: Padding(
        padding: AppDimensions.symmetric(horizontal: 15.w),
        child: LineChart(
          LineChartData(
            minY: minY,
            maxY: maxY,
            minX: 0,
            maxX: (widget.bottomTitles.length - 1).toDouble(),
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: _buildBottomTitle,
                ),
              ),
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),

            /// ================= LINE GRAPH ====================
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: false,
                color: AppColors.primary,
                barWidth: 2,
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
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    final item = widget.vitalValues[spot.x.toInt()];
                    final hasValue =
                        item.value != null && item.value!.trim().isNotEmpty;

                    final dotColor =
                        hasValue
                            ? PulseHelper().getColor(item.status ?? "Good")
                            : Colors.grey; // Missing days → grey dot

                    return _ValueDotPainter(
                      spot,
                      textColor: dotColor,
                      showText: hasValue, // Text only for measured values
                    );
                  },
                ),
              ),
            ],

            /// ================= TOUCH HANDLING ====================
            lineTouchData: LineTouchData(
              touchCallback: (event, response) {
                if (!event.isInterestedForInteractions ||
                    response == null ||
                    response.lineBarSpots == null) {
                  setState(() => touchedIndex = null);
                  return;
                }
                setState(() {
                  touchedIndex = response.lineBarSpots!.first.x.toInt();
                });
              },
              getTouchedSpotIndicator: (barData, indicators) {
                return indicators.map((index) {
                  final spot = barData.spots[index];
                  final item = widget.vitalValues[spot.x.toInt()];
                  final color = PulseHelper().getColor(item.status ?? "Good");

                  return TouchedSpotIndicatorData(
                    FlLine(color: AppColors.primary, strokeWidth: 2),
                    FlDotData(
                      show: true,
                      getDotPainter: (s, p, d, i) {
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
                getTooltipItems: (spots) {
                  return spots.map((spot) {
                    return LineTooltipItem(
                      formatDouble(spot.y).toString(),
                      TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }).toList();
                },
                getTooltipColor: (s) => Colors.transparent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// ============================================================
/// DOT + VALUE PAINTER
/// ============================================================
class _ValueDotPainter extends FlDotPainter {
  final FlSpot spot;
  final Color textColor;
  final double radius;
  final bool showText;

  _ValueDotPainter(
    this.spot, {
    required this.textColor,
    this.radius = 4,
    this.showText = true,
  });

  @override
  void draw(Canvas canvas, FlSpot spot, Offset offsetInCanvas) {
    final paint = Paint()..color = textColor;
    canvas.drawCircle(offsetInCanvas, radius, paint);

    if (!showText) return;

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

    final offset = Offset(
      offsetInCanvas.dx - textPainter.width / 2,
      offsetInCanvas.dy - textPainter.height - 4,
    );

    textPainter.paint(canvas, offset);
  }

  @override
  Size getSize(FlSpot spot) => const Size(0, 0);

  @override
  Color get mainColor => textColor;

  @override
  FlDotPainter lerp(a, b, t) => this;

  /// REQUIRED for new FLChart versions
  @override
  List<Object?> get props => [spot.x, spot.y, textColor, radius, showText];
}
