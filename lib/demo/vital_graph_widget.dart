import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/data/models/vital_graph_response_model.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';

class VitalGraphWidget extends StatefulWidget {
  const VitalGraphWidget({
    super.key,
    required this.leftTitle,
    required this.bottomTitles,
    required this.vitalValue,
  });

  final Color leftBarColor = AppColors.primary;
  final Color rightBarColor = AppColors.borderColor;
  final List<String> leftTitle;
  final List<String> bottomTitles;
  final List<HealthList> vitalValue;

  @override
  State<VitalGraphWidget> createState() => _VitalGraphWidgetState();
}

class _VitalGraphWidgetState extends State<VitalGraphWidget> {
  final double width = 20;

  late List<BarChartGroupData> showingBarGroups;

  @override
  void initState() {
    super.initState();
    storeBarChartData();
  }

  void storeBarChartData() {
    final items = <BarChartGroupData>[];
    for (int i = 0; i < widget.vitalValue.length; i++) {
      final value = double.tryParse(widget.vitalValue[i].value ?? "0") ?? 0;
      final barGroup = makeGroupData(i, value);
      items.add(barGroup);
    }
    showingBarGroups = items;
  }

  /// 🔹 Calculate maxY dynamically
  double getMaxY() {
    if (widget.vitalValue.isEmpty) return 1;
    final values =
        widget.vitalValue
            .map((e) => double.tryParse(e.value ?? "0") ?? 0)
            .toList();
    final maxVal = values.reduce((a, b) => a > b ? a : b);
    return (maxVal + 1).ceilToDouble(); // add padding
  }

  /// 🔹 Calculate Y-axis interval dynamically
  double getInterval(double maxY) {
    if (maxY <= 5) return 1;
    if (maxY <= 20) return 2;
    if (maxY <= 50) return 5;
    return (maxY / 10).ceilToDouble(); // fallback: ~10 steps
  }

  @override
  Widget build(BuildContext context) {
    final maxY = getMaxY();
    final interval = getInterval(maxY);

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(8.0),
      color: AppColors.historyCardColor,
      child: CommonCard(
        widget: AspectRatio(
          aspectRatio: 1.6,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: AppDimensions.width(400.0),
                child: BarChart(
                  BarChartData(
                    baselineY: 0,
                    maxY: maxY,
                    alignment: BarChartAlignment.spaceAround,
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
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
                          reservedSize: 42,
                          getTitlesWidget: bottomTitles,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          interval: interval,
                          getTitlesWidget: leftTitles,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border(
                        left: BorderSide(
                          width: 1.0,
                          color: AppColors.searchColor,
                        ),
                        bottom: BorderSide(
                          width: 1.0,
                          color: AppColors.searchColor,
                        ),
                      ),
                    ),
                    barGroups: showingBarGroups,
                    gridData: const FlGridData(show: true),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 🔹 Left Y-axis labels
  Widget leftTitles(double value, TitleMeta meta) {
    return SideTitleWidget(
      meta: meta,
      space: 0,
      child: Text(
        value.toInt().toString(),
        style: const TextStyle(
          color: Color(0xff7589a2),
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      ),
    );
  }

  /// 🔹 Bottom X-axis labels
  Widget bottomTitles(double value, TitleMeta meta) {
    if (value.toInt() < widget.bottomTitles.length) {
      return SideTitleWidget(
        meta: meta,
        space: 4,
        child: Text(
          widget.bottomTitles[value.toInt()],
          style: const TextStyle(
            color: Color(0xff7589a2),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  /// 🔹 Build each bar
  BarChartGroupData makeGroupData(int x, double y1) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(toY: y1, color: widget.leftBarColor, width: width),
      ],
    );
  }
}
