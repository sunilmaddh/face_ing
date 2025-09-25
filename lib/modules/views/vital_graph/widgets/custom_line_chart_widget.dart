import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/data/models/vital_graph_response_model.dart';
import 'package:ntt_data/modules/views/vital_graph/helper/vital_color_helper.dart';

class CustomLineChartWidget extends StatelessWidget {
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

  List<FlSpot> _generateSpots() {
    return List.generate(vitalValues.length, (index) {
      final x = index.toDouble();
      final y = double.tryParse(vitalValues[index].value ?? "0.0") ?? 0.0;
      return FlSpot(x, y);
    });
  }

  /// 🔹 Calculate dynamic minY and maxY
  double _getMinY(List<FlSpot> spots) {
    if (spots.isEmpty) return 0;
    final minValue = spots.map((s) => s.y).reduce((a, b) => a < b ? a : b);
    return minValue > 0 ? 0 : minValue; // keep 0 if all values are positive
  }

  double _getMaxY(List<FlSpot> spots) {
    if (spots.isEmpty) return 0;
    return spots.map((s) => s.y).reduce((a, b) => a > b ? a : b);
  }

  Widget _buildBottomTitle(double value, TitleMeta meta) {
    List<int> xValues =
        bottomTitles.map((x) {
          if (x == "Yesterday") return DateTime.now().day - 1;
          if (x == "Today") return DateTime.now().day;
          return int.tryParse(x) ?? 0;
        }).toList();

    int index = value.toInt();
    if (index >= 0 && index < xValues.length) {
      return Text(
        xValues[index].toString(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.searchColor,
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildLeftTitle(double value, TitleMeta meta) {
    int index = value.toInt();
    if (index >= 0 && index < leftTitles.length) {
      return Text(
        leftTitles[index],
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      );
    }
    return const SizedBox.shrink();
  }

  LineChartData _buildChartData() {
    final spots = _generateSpots();
    final minY = _getMinY(spots);
    final maxY = _getMaxY(spots);

    return LineChartData(
      minY: minY,
      maxY: maxY,
      maxX: (bottomTitles.length - 1).toDouble(),
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
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            interval: 1,
            reservedSize: 30,
            maxIncluded: false,
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
              final item = vitalValues[index];
              var vitalGraphColor = VitalColorHelper(
                vitalName: vitalName,
                vitalStatus: item.status.toString(),
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
            applyCutOffY: true,
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
      // 🔹 Optional: Draw a zero line for clarity
      extraLinesData: ExtraLinesData(
        horizontalLines: [
          if (minY < 0)
            HorizontalLine(
              y: 0,
              color: AppColors.borderColor,
              strokeWidth: 1.5, // thicker for visibility
            ),
        ],
      ),
      lineTouchData: LineTouchData(
        enabled: true, // disable user touch, we want "always show"
        touchTooltipData: LineTouchTooltipData(
          // tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.all(8.0),
          // tooltipMargin: 30,
          showOnTopOfTheChartBoxArea: true,
          // fitInsideHorizontally: true,
          // fitInsideVertically: true,
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((spot) {
              final item = vitalValues[spot.spotIndex];
              var vitalGraphColor = VitalColorHelper(
                vitalName: vitalName,
                vitalStatus: item.status.toString(),
                isLowGood: stringToBool(item.isTypeVital.toString()),
              );

              return LineTooltipItem(
                spot.y.toStringAsFixed(1),
                TextStyle(
                  color: vitalGraphColor.getColor(),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              );
            }).toList();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.height(200),
      child: Padding(
        padding: AppDimensions.symmetric(horizontal: 10, vertical: 10),
        child: Center(child: LineChart(_buildChartData())),
      ),
    );
  }

  bool stringToBool(String value) {
    return value.toLowerCase() == 'true';
  }
}
