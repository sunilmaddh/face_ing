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

  double _getMinY(List<FlSpot> spots) {
    if (spots.isEmpty) return 0;
    final minValue = spots.map((s) => s.y).reduce((a, b) => a < b ? a : b);
    return minValue > 0 ? 0 : minValue;
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

  LineChartData _buildChartData(List<FlSpot> spots, double minY, double maxY) {
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
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: AppColors.primary,
          barWidth: 2,
          dotData: FlDotData(show: true),
        ),
      ],

      // 👇 This is the trick: always show tooltips at every dot
      showingTooltipIndicators: [
        for (int i = 0; i < spots.length; i++)
          ShowingTooltipIndicators([
            LineBarSpot(LineChartBarData(spots: spots), 0, spots[i]),
          ]),
      ],

      lineTouchData: LineTouchData(
        enabled: false, // disable user touch, we want "always show"
        touchTooltipData: LineTouchTooltipData(
          // tooltipBgColor: Colors.transparent,
          showOnTopOfTheChartBoxArea: true,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 0,
          fitInsideHorizontally: true,
          fitInsideVertically: true,
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((spot) {
              final item = vitalValues[spot.spotIndex];
              var vitalGraphColor = VitalColorHelper(
                vitalName: vitalName,
                vitalStatus: item.status.toString(),
                isLowGood: stringToBool(item.isTypeVital.toString()),
              );

              return LineTooltipItem(
                spot.y.toInt().toString(),
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
    final spots = _generateSpots();
    final minY = _getMinY(spots);
    final maxY = _getMaxY(spots);

    return SizedBox(
      width: double.infinity,
      height: AppDimensions.height(350),
      child: Padding(
        padding: AppDimensions.symmetric(horizontal: 10, vertical: 10),
        child: Center(
          child: SizedBox(
            width: 400,
            height: 200,
            child: LineChart(_buildChartData(spots, minY, maxY)),
          ),
        ),
      ),
    );
  }

  bool stringToBool(String value) => value.toLowerCase() == 'true';
}
