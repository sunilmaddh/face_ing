import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PulseGraph extends StatelessWidget {
  final List<String> xLabels;
  final List<double?> yValues;

  const PulseGraph({super.key, required this.xLabels, required this.yValues});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: (xLabels.length - 1).toDouble(),
          minY: _minY,
          maxY: _maxY,

          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            drawHorizontalLine: true,
            horizontalInterval: 1,
            verticalInterval: 1,
            getDrawingHorizontalLine:
                (value) =>
                    FlLine(color: Colors.grey.shade300, strokeWidth: 0.5),
            getDrawingVerticalLine:
                (value) =>
                    FlLine(color: Colors.grey.shade200, strokeWidth: 0.5),
          ),

          borderData: FlBorderData(
            show: true,
            border: Border(
              left: BorderSide(color: Colors.blue.shade200, width: 1),
              bottom: BorderSide(color: Colors.blue.shade200, width: 1),
              right: BorderSide(color: Colors.transparent),
              top: BorderSide(color: Colors.transparent),
            ),
          ),

          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                reservedSize: 32,
                getTitlesWidget: _buildBottomTitle,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 36,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  // Show only 0
                  if (value == 0) {
                    return SideTitleWidget(
                      meta: meta,
                      space: 6,
                      child: const Text("0", style: TextStyle(fontSize: 10)),
                    );
                  }
                  return const SizedBox.shrink(); // hide all others
                },
              ),
            ),
          ),

          // ------------------------
          // BLUE GRAPH STYLE
          // ------------------------
          lineBarsData: [
            LineChartBarData(
              spots: _spots,
              isCurved: false,
              barWidth: 3,
              color: Colors.blue,
              isStrokeCapRound: false,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, bar, index) {
                  if (spot.y.isNaN) {
                    return FlDotCirclePainter(radius: 0); // hide dot on empty
                  }
                  return FlDotCirclePainter(
                    radius: 4,
                    color: Colors.blue,
                    strokeWidth: 1,
                    strokeColor: Colors.white,
                  );
                },
              ),

              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(0.3),
                    Colors.blue.withOpacity(0.05),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------
  // Convert values → NaN for missing
  // ------------------------------------------------
  List<FlSpot> get _spots {
    return List.generate(yValues.length, (i) {
      final v = yValues[i];
      return v == null
          ? FlSpot(i.toDouble(), double.nan) // no straight line
          : FlSpot(i.toDouble(), v);
    });
  }

  Widget _buildBottomTitle(double value, TitleMeta meta) {
    final index = value.toInt();
    if (index < 0 || index >= xLabels.length) return const SizedBox.shrink();

    return SideTitleWidget(
      meta: meta,
      space: 6,
      child: Text(xLabels[index], style: const TextStyle(fontSize: 10)),
    );
  }

  Widget _buildLeftTitle(double value, TitleMeta meta) {
    return SideTitleWidget(
      meta: meta,
      space: 6,
      child: Text(
        value.toInt().toString(),
        style: const TextStyle(fontSize: 10),
      ),
    );
  }

  double get _minY {
    final nonNull = yValues.whereType<double>().toList();
    if (nonNull.isEmpty) return 0;
    return nonNull.reduce((a, b) => a < b ? a : b) - 1;
  }

  double get _maxY {
    final nonNull = yValues.whereType<double>().toList();
    if (nonNull.isEmpty) return 10;
    return nonNull.reduce((a, b) => a > b ? a : b) + 1;
  }
}
