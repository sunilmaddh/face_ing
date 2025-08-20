import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ScalableBarChart extends StatelessWidget {
  const ScalableBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    final data = List.generate(
      30,
      (i) => (i % 10 + 5).toDouble(),
    ); // Example: 30 days data
    final barWidth = 20.0;
    final minBarsWithoutScroll = 7;

    // 👇 Calculate chart width
    final chartWidth =
        data.length > minBarsWithoutScroll
            ? data.length *
                (barWidth + 12) // add padding per bar
            : MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text("Zoomable & Scrollable BarChart")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: InteractiveViewer(
          panEnabled: true,
          scaleEnabled: true,
          minScale: 0.8,
          maxScale: 3,
          child: SizedBox(
            width: chartWidth, // 👈 dynamic width
            child: BarChart(
              BarChartData(
                maxY: 20,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) => Colors.black87,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        "${rod.toY.round()}",
                        const TextStyle(color: Colors.white),
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
                      reservedSize: 42,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "Day ${value.toInt() + 1}",
                            style: const TextStyle(fontSize: 10),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      interval: 2,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(fontSize: 10),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: false),
                barGroups: _buildBarGroups(data, barWidth),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups(List<double> data, double barWidth) {
    return List.generate(data.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: data[index],
            width: barWidth,
            borderRadius: BorderRadius.circular(4),
            color: Colors.blue,
          ),
        ],
      );
    });
  }
}
