import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/constants/app_text_styles.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:ntt_data/widgets/bar/graph_tab_bar_widget.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppConstents.deviceSize,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Face.ing',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(backgroundColor: AppColors.btntext),
        ),
        home: VitalGraphHistory(),

        // getPages: AppPages.getPages,
      ),
    );
  }
}

class VitaHistoryScreen extends StatelessWidget {
  const VitaHistoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      padding: AppDimensions.symmetric(horizontal: 20),
      color: AppColors.btntext,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [VitalGraphFirstCard()],
      ),
    );
  }
}

class VitalGraphHistory extends StatelessWidget {
  const VitalGraphHistory({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onTop: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AppNavigation.back();
          });
        },
        title: "Vital History",
      ),
      backgroundColor: AppColors.historyCardColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          color: AppColors.btntext,
          child: Column(
            children: [
              FirstLineVitalHistory(),
              20.verticalSpace,
              VitalGraphFirstCard(),
              30.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class VitalGraphFirstCard extends StatelessWidget {
  VitalGraphFirstCard({super.key});
  List<Widget> tabWidget = [];

  @override
  Widget build(BuildContext context) {
    tabWidget = <Widget>[
      _buildWidget(
        AppMethods().tabWellnessWidgets,
        AppMethods().tabBarWellnessWidget,
      ),
      _buildWidget(
        AppMethods().tabVitalSignWidgets,
        AppMethods().tabBarVitalSignWidget,
      ),
      _buildWidget(
        AppMethods().tabBBTWidgets,
        AppMethods().tabBarBloodlessWidget,
      ),
      _buildWidget(AppMethods().tabRiskWidgets, AppMethods().tabBarRiskWidget),
      _buildWidget(
        AppMethods().tabStressWidgets,
        AppMethods().tabBarStressWidget,
      ),
      _buildWidget(AppMethods().tabHRBWidgets, AppMethods().tabBaAHRVWidget),
      _buildWidget(AppMethods().tabAHRVWidgets, AppMethods().tabBaAHRVWidget),
    ];
    return SizedBox(
      height: 500,
      child: Expanded(
        child: GraphTabBarWidget(
          isNotRadius: false,
          tabWidgets: AppMethods().tabGraphWidgets,
          tabBarWidgets: tabWidget,
        ),
      ),
    );
  }

  _buildWidget(List<Widget> tabWidget, List<Widget> tabBarWidget) {
    return Expanded(
      child: Container(
        color: AppColors.historyCardColor,
        child: GraphTabBarWidget(
          tabWidgets: tabWidget,
          tabBarWidgets: tabBarWidget,
          isNotRadius: true,
        ),
      ),
    );
  }
}

DateTime firstDate = DateTime(2025);
DateTime lastDate = DateTime.now();
final List<String> items = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];

class FirstLineVitalHistory extends StatelessWidget {
  const FirstLineVitalHistory({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppDimensions.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonText.text(
            fontFamily: AppTextStyles.fontFamilyGilroy,
            fontSize: AppDimensions.font(12),
            fontWeight: FontWeight.w400,
            AppConstents.selectVital,
          ),
          Row(
            children: [
              CustomDropdown(),

              IconButton(
                onPressed: () async {
                  showDialog<CustomDateRangePicker>(
                    context: context,
                    builder:
                        (context) => CustomDateRangePicker(
                          primaryColor: AppColors.primary,
                          backgroundColor: AppColors.btntext,
                          onApplyClick: (v, v2) {},
                          minimumDate: firstDate,
                          onCancelClick: () {},
                          maximumDate: lastDate,
                          initialStartDate: DateTime.now(),
                        ),
                  );
                },
                icon: Icon(Icons.date_range),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BarChartSample3 extends StatefulWidget {
  const BarChartSample3({super.key});
  final Color leftBarColor = AppColors.primary;
  final Color rightBarColor = AppColors.borderColor;
  // final Color avgColor =
  //     AppColors.contentColorOrange.avg(AppColors.contentColorRed);
  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 8, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    // final barGroup3 = makeGroupData(2, 18, 5);
    // final barGroup4 = makeGroupData(3, 20, 16);
    // final barGroup5 = makeGroupData(4, 17, 6);
    // final barGroup6 = makeGroupData(5, 19, 1.5);
    // final barGroup7 = makeGroupData(6, 1, 1.5);

    final items = [
      barGroup1,
      barGroup2,
      // barGroup3,
      // barGroup4,
      // barGroup5,
      // barGroup6,
      // barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  List<Widget> tabWidget = [];
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 38),
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: 20,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: ((group) {
                        return Colors.grey;
                      }),
                      getTooltipItem: (a, b, c, d) => null,
                    ),
                    touchCallback: (FlTouchEvent event, response) {
                      if (response == null || response.spot == null) {
                        setState(() {
                          touchedGroupIndex = -1;
                          showingBarGroups = List.of(rawBarGroups);
                        });
                        return;
                      }

                      touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                      setState(() {
                        if (!event.isInterestedForInteractions) {
                          touchedGroupIndex = -1;
                          showingBarGroups = List.of(rawBarGroups);
                          return;
                        }
                        showingBarGroups = List.of(rawBarGroups);
                        if (touchedGroupIndex != -1) {
                          var sum = 0.0;
                          for (final rod
                              in showingBarGroups[touchedGroupIndex].barRods) {
                            sum += rod.toY;
                          }
                          final avg =
                              sum /
                              showingBarGroups[touchedGroupIndex]
                                  .barRods
                                  .length;

                          showingBarGroups[touchedGroupIndex] =
                              showingBarGroups[touchedGroupIndex].copyWith(
                                // barRods: showingBarGroups[touchedGroupIndex]
                                //     .barRods
                                //     .map((rod) {
                                //   return rod.copyWith(
                                //       toY: avg, color: widget.avgColor);
                                // }).toList(),
                              );
                        }
                      });
                    },
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
                  borderData: FlBorderData(show: false),
                  barGroups: showingBarGroups,
                  gridData: const FlGridData(show: false),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
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
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    // final titles = <String>['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final titles = <String>["10.00AM", "10.05AM", "10.30AM", "10.45AM"];
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
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(toY: y1, color: widget.leftBarColor, width: width),
        BarChartRodData(toY: y2, color: widget.rightBarColor, width: width),
      ],
    );
  }

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withValues(alpha: 0.4),
        ),
        const SizedBox(width: space),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withValues(alpha: 0.8),
        ),
        const SizedBox(width: space),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withValues(alpha: 1),
        ),
        const SizedBox(width: space),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withValues(alpha: 0.8),
        ),
        const SizedBox(width: space),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withValues(alpha: 0.4),
        ),
      ],
    );
  }
}

class _BarChart extends StatelessWidget {
  const _BarChart();

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: 20,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
      getTooltipColor: (group) => Colors.transparent,
      tooltipPadding: EdgeInsets.zero,
      tooltipMargin: 8,
      getTooltipItem: (
        BarChartGroupData group,
        int groupIndex,
        BarChartRodData rod,
        int rodIndex,
      ) {
        return BarTooltipItem(
          rod.toY.round().toString(),
          const TextStyle(
            color: AppColors.blackColor,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    ),
  );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: AppColors.primary,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Mn';
        break;
      case 1:
        text = 'Te';
        break;
      case 2:
        text = 'Wd';
        break;
      case 3:
        text = 'Tu';
        break;
      case 4:
        text = 'Fr';
        break;
      case 5:
        text = 'St';
        break;
      case 6:
        text = 'Sn';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      meta: meta,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: getTitles,
      ),
    ),
    leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
  );

  FlBorderData get borderData => FlBorderData(show: false);

  LinearGradient get _barsGradient => LinearGradient(
    colors: [AppColors.primary, AppColors.blackColor],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  List<BarChartGroupData> get barGroups => [
    BarChartGroupData(
      x: 0,
      barRods: [BarChartRodData(toY: 8, gradient: _barsGradient)],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 1,
      barRods: [BarChartRodData(toY: 10, gradient: _barsGradient)],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 2,
      barRods: [BarChartRodData(toY: 14, gradient: _barsGradient)],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 3,
      barRods: [BarChartRodData(toY: 15, gradient: _barsGradient)],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 4,
      barRods: [BarChartRodData(toY: 13, gradient: _barsGradient)],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 5,
      barRods: [BarChartRodData(toY: 10, gradient: _barsGradient)],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 6,
      barRods: [BarChartRodData(toY: 16, gradient: _barsGradient)],
      showingTooltipIndicators: [0],
    ),
  ];
}

class VitalGraphWidget extends StatefulWidget {
  const VitalGraphWidget({super.key});
  @override
  State<StatefulWidget> createState() => VitalGraphWidgetState();
}

class VitalGraphWidgetState extends State<VitalGraphWidget> {
  @override
  Widget build(BuildContext context) {
    return CommonCard(
      color: AppColors.btntext,
      widget: const AspectRatio(aspectRatio: 1.6, child: _BarChart()),
    );
  }
}

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({super.key});

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String selectedValue = "Weekly";

  final List<String> items = ["Weekly", "Monthly", "Yearly"];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppDimensions.symmetric(horizontal: 10),
      height: AppDimensions.height(45),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(30),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          icon: Icon(Icons.keyboard_arrow_down_sharp, color: AppColors.btntext),
          dropdownColor: AppColors.primary,
          style: TextStyle(
            fontFamily: AppTextStyles.fontFamilyGilroy,
            fontSize: AppDimensions.font(12),
            fontWeight: FontWeight.w400,
            color: AppColors.btntext,
          ),
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue!;
            });
          },
          items:
              items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: CommonText.text(
                    value,
                    fontFamily: AppTextStyles.fontFamilyGilroy,
                    fontSize: AppDimensions.font(12),
                    fontWeight: FontWeight.w400,
                    color: AppColors.btntext,
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}


// class VitalGraphHistory extends StatelessWidget {
//   const VitalGraphHistory({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.historyCardColor,
//       body: Column(children: [CommonCard(widget: VitalGraphWidget())]),
//     );
//   }
// }




// class GraphWidget extends StatelessWidget {
//   const GraphWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }

