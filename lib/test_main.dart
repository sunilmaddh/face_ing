import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GaugeDemo(),
      // StatusGaugeList(
      //   statuses: ["High", "Low", "Normal", "Medium", "Extreme"],
      // ),
    );
  }
}

class GaugeDemo extends StatelessWidget {
  const GaugeDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final statuses = ["Extreme", "High", "Normal", "Medium", "Low"];

    return Scaffold(
      appBar: AppBar(title: const Text("Half Circle Gauge")),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children:
              statuses
                  .map(
                    (status) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: StatusGaugeChart(status: status),
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }
}

class StatusGaugeChart extends StatelessWidget {
  final String status;

  const StatusGaugeChart({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    double value = _mapStatusToValue("High");

    return SizedBox(
      height: 250,
      child: SfRadialGauge(
        axes: [
          RadialAxis(
            minimum: 0,
            maximum: 100,
            startAngle: 180, // Half circle start
            endAngle: 0, // Half circle end
            showTicks: false,
            showLabels: false,
            axisLineStyle: const AxisLineStyle(
              thickness: 30,
              cornerStyle: CornerStyle.bothCurve,
            ),
            ranges: [
              GaugeRange(
                startValue: 0,
                endValue: 20,
                color: Colors.red,
                label: 'Extreme',
                sizeUnit: GaugeSizeUnit.factor,
                startWidth: 0.3,
                endWidth: 0.3,
              ),
              GaugeRange(
                startValue: 20,
                endValue: 40,
                color: Colors.orange,
                label: 'High',
                sizeUnit: GaugeSizeUnit.factor,
                startWidth: 0.3,
                endWidth: 0.3,
              ),
              GaugeRange(
                startValue: 40,
                endValue: 60,
                color: Colors.green,
                label: 'Normal',
                sizeUnit: GaugeSizeUnit.factor,
                startWidth: 0.3,
                endWidth: 0.3,
              ),
              GaugeRange(
                startValue: 60,
                endValue: 80,
                color: Colors.blue,
                label: 'Medium',
                sizeUnit: GaugeSizeUnit.factor,
                startWidth: 0.3,
                endWidth: 0.3,
              ),
              GaugeRange(
                startValue: 80,
                endValue: 100,
                color: Colors.purple,
                label: 'Low',
                sizeUnit: GaugeSizeUnit.factor,
                startWidth: 0.3,
                endWidth: 0.3,
              ),
            ],
            pointers: [
              NeedlePointer(
                value: value,
                needleLength: 0.8,
                needleStartWidth: 0,
                needleEndWidth: 5,
                knobStyle: const KnobStyle(
                  knobRadius: 0.06,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Map status to a gauge value
  double _mapStatusToValue(String status) {
    switch (status.toLowerCase()) {
      case 'extreme':
        return 10;
      case 'high':
        return 30;
      case 'normal':
        return 50;
      case 'medium':
        return 70;
      case 'low':
        return 90;
      default:
        return 50;
    }
  }
}

class StatusGauge extends StatelessWidget {
  final String status; // high, low, normal, medium, extreme

  const StatusGauge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220, // width for each chart card
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Status: $status",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          AspectRatio(
            aspectRatio: 2, // half circle
            child: PieChart(
              PieChartData(
                startDegreeOffset: 180,
                sectionsSpace: 2,
                centerSpaceRadius: 0,
                sections: _buildSections(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildSections() {
    final sections = <Map<String, dynamic>>[
      {"label": "High", "color": Colors.red},
      {"label": "Medium", "color": Colors.orange},
      {"label": "Normal", "color": Colors.green},
      {"label": "Low", "color": Colors.blue},
      {"label": "Extreme", "color": Colors.purple},
    ];

    return sections.map((item) {
      final isActive =
          item["label"].toString().toLowerCase() == status.toLowerCase();
      return PieChartSectionData(
        color: isActive ? item["color"] : Colors.grey.shade300,
        value: 20, // equal slices
        radius: isActive ? 110 : 90,
        title: item["label"],
        titleStyle: TextStyle(
          fontSize: isActive ? 14 : 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }
}

class StatusGaugeList extends StatelessWidget {
  final List<String> statuses;

  const StatusGaugeList({super.key, required this.statuses});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(16),
      child: Row(
        children:
            statuses
                .map(
                  (status) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: StatusGauge(status: status),
                  ),
                )
                .toList(),
      ),
    );
  }
}

// class StatusGauge extends StatelessWidget {
//   final String status; // high, low, normal, medium, extreme

//   const StatusGauge({super.key, required this.status});

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 2,
//       child: PieChart(
//         PieChartData(
//           startDegreeOffset: 180,
//           sectionsSpace: 2,
//           centerSpaceRadius: 0,
//           sections: _buildSections(),
//         ),
//       ),
//     );
//   }

//   List<PieChartSectionData> _buildSections() {
//     final sections = <Map<String, dynamic>>[
//       {"label": "High", "color": Colors.red},
//       {"label": "Medium", "color": Colors.orange},
//       {"label": "Normal", "color": Colors.green},
//       {"label": "Low", "color": Colors.blue},
//       {"label": "Extreme", "color": Colors.purple},
//     ];

//     return sections.map((item) {
//       final isActive =
//           item["label"].toString().toLowerCase() == status.toLowerCase();
//       return PieChartSectionData(
//         color:
//             isActive
//                 ? item["color"]
//                 : Colors.grey.shade300, // highlight selected
//         value: 20, // equal division (180°/5)
//         radius: isActive ? 110 : 90, // highlight active with bigger radius
//         title: item["label"],
//         titleStyle: TextStyle(
//           fontSize: isActive ? 14 : 12,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ),
//       );
//     }).toList();
//   }
// }

class HalfCirclePieChart extends StatelessWidget {
  const HalfCirclePieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2, // wider to look like half circle
      child: PieChart(
        PieChartData(
          startDegreeOffset: 180, // Start from bottom
          sectionsSpace: 2,
          centerSpaceRadius: 0, // No donut hole
          sections: _sections(),
        ),
      ),
    );
  }

  List<PieChartSectionData> _sections() {
    // total value must add up to 100 (but only 180° will be shown)
    return [
      PieChartSectionData(
        color: Colors.red,
        value: 20,
        title: 'High',
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.orange,
        value: 20,
        title: 'Medium',
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.green,
        value: 20,
        title: 'Normal',
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.blue,
        value: 20,
        title: 'Low',
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.purple,
        value: 20,
        title: 'Extreme',
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];
  }
}

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: Row(
        children: <Widget>[
          const SizedBox(height: 18),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex =
                            pieTouchResponse
                                .touchedSection!
                                .touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Indicator(
              //   color: AppColors.contentColorBlue,
              //   text: 'First',
              //   isSquare: true,
              // ),
              // SizedBox(height: 4),
              // Indicator(
              //   color: AppColors.contentColorYellow,
              //   text: 'Second',
              //   isSquare: true,
              // ),
              // SizedBox(height: 4),
              // Indicator(
              //   color: AppColors.contentColorPurple,
              //   text: 'Third',
              //   isSquare: true,
              // ),
              // SizedBox(height: 4),
              // Indicator(
              //   color: AppColors.contentColorGreen,
              //   text: 'Fourth',
              //   isSquare: true,
              // ),
              SizedBox(height: 18),
            ],
          ),
          const SizedBox(width: 28),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColors.camreraPreviewColor,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.error,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.camreraPreviewColor,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: AppColors.powerBy,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.backArrowColor,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: AppColors.guestIconColor,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.camreraPreviewColor,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}

class HalfPieChart extends StatelessWidget {
  const HalfPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2, // Wider for half-circle
      child: PieChart(
        PieChartData(
          startDegreeOffset: 180, // Start from bottom
          sectionsSpace: 2,
          centerSpaceRadius: 60, // Inner hole for donut
          sections: showingSections(),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return [
      PieChartSectionData(
        color: Colors.green,
        value: 40,
        title: '40%',
        radius: 80,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.orange,
        value: 30,
        title: '30%',
        radius: 80,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: 30,
        title: '30%',
        radius: 80,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];
  }
}
