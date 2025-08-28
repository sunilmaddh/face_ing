import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';

class VitalGraphWidget extends StatefulWidget {
  VitalGraphWidget({
    super.key,
    required this.leftTitle,
    required this.bottomTitles,
    required this.vitalValue,
  });
  final Color leftBarColor = AppColors.primary;
  final Color rightBarColor = AppColors.borderColor;
  final List<String> leftTitle;
  final List<String> bottomTitles;
  final List<String> vitalValue;
  // final BarChartGroupData showingBarGroups;
  // final Widget leftTitles;
  // final Widget bottomTitles;

  // final Color avgColor =
  //     AppColors.contentColorOrange.avg(AppColors.contentColorRed);
  @override
  State<StatefulWidget> createState() => VitalGraphWidgetState();
}

class VitalGraphWidgetState extends State<VitalGraphWidget> {
  final double width = 20;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;
  int touchedGroupIndex = 5;

  @override
  void initState() {
    super.initState();
    storeBarCharData();
  }

  storeBarCharData() {
    final items = <BarChartGroupData>[];
    for (int i = 0; i <= 4; i++) {
      final barGroup1 = makeGroupData(0, i.toDouble());
      items.add(barGroup1);
    }
    rawBarGroups = items;
    showingBarGroups = rawBarGroups;
  }

  List<Widget> tabWidget = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(8.0),
      color: AppColors.historyCardColor,
      child: CommonCard(
        widget: AspectRatio(
          aspectRatio: 1.6,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: AppDimensions.width(320.0),
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 20,
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return BarTooltipItem(
                            rod.toY.toStringAsFixed(
                              0,
                            ), // Display the bar's value
                            TextStyle(color: Colors.white, fontSize: 12),
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
                          getTitlesWidget: bottomTitles,
                          reservedSize: 42,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          interval: 1,
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

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '1K';
    } else if (value == 10) {
      text = '5K';
    } else if (value == 19) {
      text = '10K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      meta: meta,
      space: 4,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    // final titles = <String>['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final titles = <String>[
      "10.00AM",
      "10.05AM",
      "10.30AM",
      "10.45AM",
      "10.00AM",
    ];
    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      meta: meta,
      space: 1, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1) {
    return BarChartGroupData(
      barsSpace: 10,
      x: x,
      barRods: List.generate(1, (v) {
        return BarChartRodData(
          toY: y1,
          color: widget.leftBarColor,
          width: width,
        );
      }),
      // [

      //   BarChartRodData(toY: y2, color: widget.rightBarColor, width: width),
      //   BarChartRodData(toY: y2, color: widget.rightBarColor, width: width),
      //   BarChartRodData(toY: y2, color: widget.rightBarColor, width: width),
      // ],
    );
  }
}
