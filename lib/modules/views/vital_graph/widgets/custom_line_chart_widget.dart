import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';

class CustomLineChartWidget extends StatefulWidget {
  const CustomLineChartWidget({super.key});

  @override
  State<CustomLineChartWidget> createState() => _CustomLineChartWidgetState();
}

class _CustomLineChartWidgetState extends State<CustomLineChartWidget> {
  List<Color> gradientColors = [
    Color(0xffD0FBFF).withOpacity(0.60),
    Color(0xffDDF2F4).withOpacity(0.0),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 200, child: Center(child: LineChart(mainData())));
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('1', style: style);
      case 2:
        text = const Text('2', style: style);
        break;
      case 4:
        text = const Text('3', style: style);
        break;
      case 6:
        text = const Text('4', style: style);
        break;
      case 8:
        text = const Text('5', style: style);
        break;
      // case 9:
      //   text = const Text('6', style: style);
      //   break;
      // case 11:
      //   text = const Text('7', style: style);
      //   break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(meta: meta, child: text);
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 20,
          ),
        ),
      ),
      borderData: FlBorderData(show: true, border: Border()),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            // FlSpot(9.5, 5),
            // FlSpot(11, 2),
          ],
          isCurved: true,
          color: Color(0xff5175A8),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          isStepLineChart: false,
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: gradientColors,
            ),
          ),
        ),
      ],
    );
  }
}
