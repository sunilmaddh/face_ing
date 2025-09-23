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
  // final String status;
  // final String isVitalType;

  List<FlSpot> _generateSpots() {
    return List.generate(vitalValues.length, (index) {
      final x = index.toDouble();
      final y = double.tryParse(vitalValues[index].value ?? "0.0") ?? 0.0;
      return FlSpot(x, y);
    });
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
          color: Color(0xffE0E0E0),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  // 🔹 Left titles (Y-Axis)
  Widget _buildLeftTitle(double value, TitleMeta meta) {
    int index = value.toInt();
    if (index >= 0 && index < leftTitles.length) {
      var resValue = double.tryParse(leftTitles[index]);
      return Text(
        leftTitles[index],
        // resValue!.toStringAsFixed(1),
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      );
    }
    return const SizedBox.shrink();
  }

  LineChartData _buildChartData() {
    final spots = _generateSpots();
    return LineChartData(
      minY: 0,
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
        // Full line without bar area
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: AppColors.primary,
          barWidth: 2,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) {
              final item = vitalValues[index];

              // Call your helper
              var vitalGraphColor = VitalColorHelper(
                vitalName: vitalName,
                vitalStatus: item.status.toString(),
                isLowGood: stringToBool(item.isTypeVital.toString()),
              );

              return FlDotCirclePainter(
                radius: 4,
                color: vitalGraphColor.getColor(),
                strokeWidth: 1.5,
                strokeColor: AppColors.btntext,
              );
            },
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xffD0FBFF).withOpacity(0.6),
                const Color(0xffDDF2F4).withOpacity(0.0),
              ],
            ),
          ),
        ),
      ],
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
