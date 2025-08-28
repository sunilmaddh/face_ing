import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FrequencyBarChart(),
    );
  }
}

class HighLowMediumGraph extends StatelessWidget {
  const HighLowMediumGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final List<double> data = [20, 40, 70, 90, 55, 30, 10];

    // Define thresholds
    const double lowThreshold = 30;
    const double mediumThreshold = 60;

    return Scaffold(
      appBar: AppBar(title: const Text("High, Medium, Low Graph")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LineChart(
          LineChartData(
            titlesData: FlTitlesData(show: true),
            lineBarsData: [
              LineChartBarData(
                spots:
                    data.asMap().entries.map((e) {
                      final x = e.key.toDouble();
                      final y = e.value;

                      // Color points based on High, Medium, Low
                      Color pointColor;
                      if (y < lowThreshold) {
                        pointColor = Colors.red; // Low
                      } else if (y < mediumThreshold) {
                        pointColor = Colors.orange; // Medium
                      } else {
                        pointColor = Colors.green; // High
                      }

                      return FlSpot(x, y);
                    }).toList(),
                isCurved: true,
                barWidth: 3,
                belowBarData: BarAreaData(show: false),
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, _, __, ___) {
                    Color color;
                    if (spot.y < lowThreshold) {
                      color = Colors.red;
                    } else if (spot.y < mediumThreshold) {
                      color = Colors.orange;
                    } else {
                      color = Colors.green;
                    }
                    return FlDotCirclePainter(
                      radius: 5,
                      color: color,
                      strokeWidth: 2,
                      strokeColor: Colors.black,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HighLowMediumBarChart extends StatelessWidget {
  const HighLowMediumBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data
    final List<double> data = [20, 45, 70, 90, 55, 30, 10];

    // Thresholds
    const double lowThreshold = 30;
    const double mediumThreshold = 60;

    return Scaffold(
      appBar: AppBar(title: const Text("High, Medium, Low Bar Chart")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget:
                      (value, meta) => Text("Day ${value.toInt() + 1}"),
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
            barGroups:
                data.asMap().entries.map((entry) {
                  final x = entry.key;
                  final y = entry.value;

                  // Decide color based on value
                  Color barColor;
                  if (y < lowThreshold) {
                    barColor = Colors.red; // Low
                  } else if (y < mediumThreshold) {
                    barColor = Colors.orange; // Medium
                  } else {
                    barColor = Colors.green; // High
                  }

                  return BarChartGroupData(
                    x: x,
                    barRods: [
                      BarChartRodData(
                        toY: y,
                        color: barColor,
                        width: 18,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ],
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}

class StringValueBarChart extends StatelessWidget {
  const StringValueBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample string data
    final List<String> data = [
      "Low",
      "Medium",
      "High",
      "Low",
      "High",
      "Medium",
    ];

    // Map string values to numeric values
    double mapValue(String val) {
      switch (val) {
        case "Low":
          return 1;
        case "Medium":
          return 2;
        case "High":
          return 3;
        default:
          return 0;
      }
    }

    // Assign colors for each type
    Color mapColor(String val) {
      switch (val) {
        case "Low":
          return Colors.red;
        case "Medium":
          return Colors.orange;
        case "High":
          return Colors.green;
        default:
          return Colors.grey;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text("String Values Bar Chart")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget:
                      (value, meta) => Text("Day ${value.toInt() + 1}"),
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    switch (value.toInt()) {
                      case 1:
                        return const Text("Low");
                      case 2:
                        return const Text("Medium");
                      case 3:
                        return const Text("High");
                    }
                    return const Text("");
                  },
                ),
              ),
            ),
            barGroups:
                data.asMap().entries.map((entry) {
                  final x = entry.key;
                  final y = mapValue(entry.value);
                  final color = mapColor(entry.value);

                  return BarChartGroupData(
                    x: x,
                    barRods: [
                      BarChartRodData(
                        toY: y,
                        color: color,
                        width: 20,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ],
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}

class FrequencyBarChart extends StatelessWidget {
  const FrequencyBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample string data
    final List<String> data = [
      "Low",
      "Medium",
      "High",
      "Low",
      "High",
      "Medium",
      "High",
    ];

    // Count frequency
    final Map<String, int> frequency = {
      "Low": data.where((e) => e == "Low").length,
      "Medium": data.where((e) => e == "Medium").length,
      "High": data.where((e) => e == "High").length,
    };

    // Assign colors
    Color mapColor(String val) {
      switch (val) {
        case "Low":
          return Colors.red;
        case "Medium":
          return Colors.orange;
        case "High":
          return Colors.green;
        default:
          return Colors.grey;
      }
    }

    // Prepare data for bars
    final categories = ["Low", "Medium", "High"];

    return Scaffold(
      appBar: AppBar(title: const Text("Low / Medium / High Frequency")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BarChart(
          BarChartData(
            borderData: FlBorderData(show: false),
            alignment: BarChartAlignment.spaceAround,
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    if (value.toInt() >= 0 &&
                        value.toInt() < categories.length) {
                      return Text(categories[value.toInt()]);
                    }
                    return const Text("");
                  },
                ),
              ),
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
            ),
            barGroups:
                categories.asMap().entries.map((entry) {
                  final x = entry.key;
                  final category = entry.value;
                  final count = frequency[category] ?? 0;
                  final color = mapColor(category);

                  return BarChartGroupData(
                    x: x,
                    barRods: [
                      BarChartRodData(
                        toY: count.toDouble(),
                        color: color,
                        width: 30,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ],
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}
