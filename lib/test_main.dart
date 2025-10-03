import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/modules/views/vital_graph/controller/vital_graph_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppConstents.deviceSize,
      minTextAdapt: true,
      ensureScreenSize: true,
      child: GetMaterialApp(
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        title: 'Face.ing',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(backgroundColor: AppColors.btntext),
        ),
        home: MyWidget(),

        routingCallback: (routing) {
          if (Get.isSnackbarOpen) {
            Get.closeCurrentSnackbar();
          }
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class MyWidget extends StatelessWidget {
  MyWidget({super.key});

  final _controller = Get.put(VitalGraphController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Center(child: CallGraphWidget())));
  }
}

class CallGraphWidget extends StatelessWidget {
  const CallGraphWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(width: double.infinity, height: 120, child: SizedBox()),

      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Row(
      //       children: [
      //         Expanded(
      //           child: CommonGraphCard(
      //             widget: SizedBox(
      //               height: 120,
      //               child: Expanded(
      //                 child: Container(
      //                   alignment: Alignment.center,
      //                   height: 120,
      //                   child: CustomLineChartWidget(),
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),

      //         10.verticalSpace,
      //         Expanded(
      //           child: SizedBox(
      //             width: 155,
      //             child: CommonGraphCard(
      //               widget: Flexible(
      //                 child: Container(
      //                   alignment: Alignment.center,
      //                   height: 155,
      //                   child: GaugeWithBadges(),
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),

      //     CommonGraphCard(
      //       widget: Flexible(
      //         child: Container(
      //           alignment: Alignment.center,
      //           height: 155,
      //           child: GaugeWithBadges(),
      //         ),
      //       ),
      //     ),
      //     CommonGraphCard(
      //       widget: Flexible(child: Expanded(child: CustomLineChartWidget())),
      //     ),
      //   ],
      // ),
    );
  }
}

// class CommonGraphCard extends StatelessWidget {
//   const CommonGraphCard({
//     super.key,
//     required this.widget,
//     required this.vitalName,
//     required this.avg,
//     required this.unit,
//     // required this.statusList,
//     // required this.isVitalType,
//   });
//   final Widget widget;
//   final String vitalName;
//   final String avg;
//   final String unit;
//   // final List<String> statusList;
//   // final String isVitalType;
//   @override
//   Widget build(BuildContext context) {
//     return CommonCard(
//       isBorder: true,
//       radius: 12.0,
//       widget: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//         child: Stack(
//           children: [
//             // statusList != null
//             //     ? Align(
//             //       alignment: Alignment.bottomCenter,
//             //       child: Padding(
//             //         padding: AppDimensions.symmetric(vertical: 5),
//             //         child: Row(
//             //           mainAxisSize: MainAxisSize.min,
//             //           crossAxisAlignment: CrossAxisAlignment.start,
//             //           mainAxisAlignment: MainAxisAlignment.spaceAround,
//             //           children:
//             //               List.generate(statusList.length, (index) {
//             //                 var vitalGraphColor = VitalColorHelper(
//             //                   vitalName: vitalName,
//             //                   vitalStatus: statusList[index],
//             //                   isLowGood: stringToBool(isVitalType),
//             //                 );
//             //                 return Expanded(
//             //                   flex: 8,
//             //                   child: Text(
//             //                     textAlign: TextAlign.center,
//             //                     maxLines: 2,
//             //                     statusList[index],
//             //                     style: TextStyle(
//             //                       color: vitalGraphColor.getColor(),
//             //                     ),
//             //                   ),
//             //                 );
//             //               }).toList(),
//             //         ),
//             //       ),
//             //     )
//             //     : SizedBox.shrink(),
//             Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Row(
//                   children: [
//                     Flexible(
//                       flex: 2,
//                       child: Container(
//                         padding: EdgeInsets.all(6.0),
//                         // margin: EdgeInsets.symmetric(horizontal: 15),
//                         width: 37.85,
//                         height: 37.85,
//                         decoration: BoxDecoration(
//                           color: Color(0xffFBF0F3),
//                           borderRadius: BorderRadius.circular(12.0),
//                         ),
//                         child: SvgPicture.asset(
//                           "assets/images/svg/pulse_graph.svg",
//                         ),
//                       ),
//                     ),
//                     8.horizontalSpace,
//                     Flexible(
//                       flex: 7,
//                       child: CommonText.text(
//                         maxLines: 2,
//                         vitalName,
//                         fontSize: 13,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: "Mulish",
//                         color: Color(0xff616161),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 0),
//                   child: Row(
//                     children: [
//                       CommonText.text(
//                         "Avg.",
//                         fontSize: 13,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: "Mulish",
//                         color: Color(0xff818181),
//                       ),
//                       SizedBox(width: 10),
//                       RichText(
//                         text: TextSpan(
//                           text: avg,
//                           style: TextStyle(
//                             color: Color(0xff4ADE80),
//                             fontSize: 19,
//                             fontWeight: FontWeight.w700,
//                             fontFamily: "Mulish",
//                           ),
//                           children: [
//                             TextSpan(
//                               text: unit,
//                               style: TextStyle(
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w600,
//                                 fontFamily: "Mulish",
//                                 color: Color(0xff616161),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   margin: AppDimensions.all(8.0),
//                   alignment: Alignment.center,
//                   child: widget,
//                 ),
//                 // Padding(
//                 //   padding: AppDimensions.symmetric(vertical: 5),
//                 //   child: Wrap(
//                 //     spacing: 5,
//                 //     runSpacing: 5,
//                 //     children:
//                 //         List.generate(statusList.length, (index) {
//                 //           print(
//                 //             "statusList length = ${statusList.length}, accessing index = $index",
//                 //           );

//                 //           var vitalGraphColor = VitalColorHelper(
//                 //             vitalName: vitalName,
//                 //             vitalStatus: statusList[index],
//                 //             isLowGood: stringToBool(isVitalType),
//                 //           );

//                 //           return Container(
//                 //             constraints: const BoxConstraints(
//                 //               minWidth: 60,
//                 //             ), // optional width
//                 //             padding: const EdgeInsets.all(4),
//                 //             child:
//                 //                 index < statusList.length
//                 //                     ? Text(
//                 //                       statusList[index],
//                 //                       textAlign: TextAlign.center,
//                 //                       maxLines: 2
//                 //                       style: TextStyle(
//                 //                         color: vitalGraphColor.getColor(),
//                 //                       ),
//                 //                     )
//                 //                     : SizedBox.shrink(),
//                 //           );
//                 //         }).toList(),
//                 //   ),
//                 // ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   bool stringToBool(String value) {
//     return value.toLowerCase() == 'true';
//   }
// }

// class StatusGaugeChart extends StatelessWidget {
//   final String status;

//   const StatusGaugeChart({super.key, required this.status});

//   @override
//   Widget build(BuildContext context) {
//     // final statuses = [
//     //   {"value": "Extreme", "color": 0xFFFD2213},
//     //   {"value": "High", "color": 0xFF1BC76D},
//     //   {"value": "Medium", "color": 0xFFEEC000},
//     //   {"value": "Normal", "color": 0xFF1BC76D},
//     //   {"value": "Mild", "color": 0xFFEEC000},
//     //   {"value": "Low", "color": 0xFFFA704E},
//     //   // {"value": "Prediabetes", "color": 0xFFEEC000},
//     //   // {"value": "Diabetes", "color": 0xFFFD2213},
//     // ];
//     final statuses = [
//       {"value": "60", "color": 0xFFEEC000, "start": 0, "end": 90},
//       {"value": "150", "color": 0xFF1BC76D, "start": 90, "end": 120},
//       {"value": "200", "color": 0xFFEEC000, "start": 120, "end": 130},
//       {"value": "Normal", "color": 0xFF1BC76D, "start": 130, "end": 140},
//       {"value": "Low", "color": 0xFFFA704E, "start": 140, "end": 180},
//     ];

//     double value = _mapStatusToValue("High", statuses);

//     return SizedBox(
//       height: 250,
//       child: SfRadialGauge(
//         axes: [
//           RadialAxis(
//             radiusFactor: 0.60,
//             minimum: 0,
//             maximum: 180,
//             startAngle: 110, // Half circle start
//             endAngle: 70, // Half circle end
//             showTicks: false,
//             showLabels: false,
//             showFirstLabel: true,
//             canScaleToFit: false,
//             canRotateLabels: true,
//             annotations: _gaugeAnnotation(Text("2")),
//             axisLineStyle: const AxisLineStyle(
//               thickness: 10,
//               cornerStyle: CornerStyle.bothCurve,
//             ),
//             ranges:
//                 statuses.map((s) {
//                   return GaugeRange(
//                     startValue: (s["start"] as num).toDouble(),
//                     endValue: (s["end"] as num).toDouble(),
//                     color: Color(s["color"] as int),
//                     label: s["value"].toString(),
//                     labelStyle: GaugeTextStyle(
//                       fontSize: AppDimensions.font(8.0),
//                       color: AppColors.btntext,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     sizeUnit: GaugeSizeUnit.factor,
//                     startWidth: 0.2,
//                     endWidth: 0.2,
//                   );
//                 }).toList(),

//             // List.generate(statuses.length, (i) {
//             //   final double segmentSize = 100 / statuses.length;
//             //   final double start = i * segmentSize;
//             //   final double end = start + segmentSize;

//             //   return GaugeRange(
//             //     startValue: start,
//             //     endValue: end,
//             //     color: Color(statuses[i]["color"] as int),
//             //     label: statuses[i]["value"].toString(),
//             //     labelStyle: GaugeTextStyle(
//             //       fontSize: AppDimensions.font(8.0),
//             //       color: AppColors.btntext,
//             //       fontWeight: FontWeight.w500,
//             //     ),
//             //     sizeUnit: GaugeSizeUnit.factor,
//             //     startWidth: 0.3,
//             //     endWidth: 0.3,
//             //   );
//             // }).toList(),
//             pointers: [
//               // NeedlePointer(
//               //   enableAnimation: true,
//               //   enableDragging: true,
//               //   value: value,
//               //   needleLength: 0.8,
//               //   needleStartWidth: 0,
//               //   needleEndWidth: 5,
//               //   knobStyle: const KnobStyle(
//               //     knobRadius: 0.06,
//               //     color: Colors.black,
//               //   ),
//               // ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   List<GaugeAnnotation> _gaugeAnnotation(Widget widget) {
//     return [GaugeAnnotation(widget: widget, positionFactor: 0.8)];
//   }

//   double _mapStatusToValue(String status, List<Map<String, Object>> statuses) {
//     final int index = statuses.indexWhere(
//       (s) => s["value"].toString().toLowerCase() == status.toLowerCase(),
//     );

//     if (index == -1) return 50; // fallback if not found

//     final double segmentSize = 100 / statuses.length;
//     final double start = index * segmentSize;
//     return start + (segmentSize / 2); // center of the slice
//   }
// }

// class StatusGauge extends StatelessWidget {
//   final String status; // high, low, normal, medium, extreme

//   const StatusGauge({super.key, required this.status});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 220, // width for each chart card
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             "Status: $status",
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 12),
//           AspectRatio(
//             aspectRatio: 2, // half circle
//             child: PieChart(
//               PieChartData(
//                 startDegreeOffset: 90,
//                 sectionsSpace: 2,
//                 centerSpaceRadius: 0,
//                 sections: _buildSections(),
//               ),
//             ),
//           ),
//         ],
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
//         color: isActive ? item["color"] : Colors.grey.shade300,
//         value: 20, // equal slices
//         radius: isActive ? 110 : 90,
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

// class StatusGaugeList extends StatelessWidget {
//   final List<String> statuses;

//   const StatusGaugeList({super.key, required this.statuses});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       padding: const EdgeInsets.all(16),
//       child: Row(
//         children:
//             statuses
//                 .map(
//                   (status) => Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: StatusGauge(status: status),
//                   ),
//                 )
//                 .toList(),
//       ),
//     );
//   }
// }

// // class StatusGauge extends StatelessWidget {
// //   final String status; // high, low, normal, medium, extreme

// //   const StatusGauge({super.key, required this.status});

// //   @override
// //   Widget build(BuildContext context) {
// //     return AspectRatio(
// //       aspectRatio: 2,
// //       child: PieChart(
// //         PieChartData(
// //           startDegreeOffset: 180,
// //           sectionsSpace: 2,
// //           centerSpaceRadius: 0,
// //           sections: _buildSections(),
// //         ),
// //       ),
// //     );
// //   }

// //   List<PieChartSectionData> _buildSections() {
// //     final sections = <Map<String, dynamic>>[
// //       {"label": "High", "color": Colors.red},
// //       {"label": "Medium", "color": Colors.orange},
// //       {"label": "Normal", "color": Colors.green},
// //       {"label": "Low", "color": Colors.blue},
// //       {"label": "Extreme", "color": Colors.purple},
// //     ];

// //     return sections.map((item) {
// //       final isActive =
// //           item["label"].toString().toLowerCase() == status.toLowerCase();
// //       return PieChartSectionData(
// //         color:
// //             isActive
// //                 ? item["color"]
// //                 : Colors.grey.shade300, // highlight selected
// //         value: 20, // equal division (180°/5)
// //         radius: isActive ? 110 : 90, // highlight active with bigger radius
// //         title: item["label"],
// //         titleStyle: TextStyle(
// //           fontSize: isActive ? 14 : 12,
// //           fontWeight: FontWeight.bold,
// //           color: Colors.white,
// //         ),
// //       );
// //     }).toList();
// //   }
// // }

// class HalfCirclePieChart extends StatelessWidget {
//   const HalfCirclePieChart({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 2, // wider to look like half circle
//       child: PieChart(
//         PieChartData(
//           startDegreeOffset: 180, // Start from bottom
//           sectionsSpace: 2,
//           centerSpaceRadius: 0, // No donut hole
//           sections: _sections(),
//         ),
//       ),
//     );
//   }

//   List<PieChartSectionData> _sections() {
//     // total value must add up to 100 (but only 180° will be shown)
//     return [
//       PieChartSectionData(
//         color: Colors.red,
//         value: 20,
//         title: 'High',
//         radius: 100,
//         titleStyle: const TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ),
//       ),
//       PieChartSectionData(
//         color: Colors.orange,
//         value: 20,
//         title: 'Medium',
//         radius: 100,
//         titleStyle: const TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ),
//       ),
//       PieChartSectionData(
//         color: Colors.green,
//         value: 20,
//         title: 'Normal',
//         radius: 100,
//         titleStyle: const TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ),
//       ),
//       PieChartSectionData(
//         color: Colors.blue,
//         value: 20,
//         title: 'Low',
//         radius: 100,
//         titleStyle: const TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ),
//       ),
//       PieChartSectionData(
//         color: Colors.purple,
//         value: 20,
//         title: 'Extreme',
//         radius: 100,
//         titleStyle: const TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ),
//       ),
//     ];
//   }
// }

// class PieChartSample2 extends StatefulWidget {
//   const PieChartSample2({super.key});

//   @override
//   State<StatefulWidget> createState() => PieChart2State();
// }

// class PieChart2State extends State {
//   int touchedIndex = -1;

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1.6,
//       child: Row(
//         children: <Widget>[
//           const SizedBox(height: 18),
//           Expanded(
//             child: AspectRatio(
//               aspectRatio: 1,
//               child: PieChart(
//                 PieChartData(
//                   pieTouchData: PieTouchData(
//                     touchCallback: (FlTouchEvent event, pieTouchResponse) {
//                       setState(() {
//                         if (!event.isInterestedForInteractions ||
//                             pieTouchResponse == null ||
//                             pieTouchResponse.touchedSection == null) {
//                           touchedIndex = -1;
//                           return;
//                         }
//                         touchedIndex =
//                             pieTouchResponse
//                                 .touchedSection!
//                                 .touchedSectionIndex;
//                       });
//                     },
//                   ),
//                   borderData: FlBorderData(show: false),
//                   sectionsSpace: 0,
//                   centerSpaceRadius: 40,
//                   sections: showingSections(),
//                 ),
//               ),
//             ),
//           ),
//           const Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               // Indicator(
//               //   color: AppColors.contentColorBlue,
//               //   text: 'First',
//               //   isSquare: true,
//               // ),
//               // SizedBox(height: 4),
//               // Indicator(
//               //   color: AppColors.contentColorYellow,
//               //   text: 'Second',
//               //   isSquare: true,
//               // ),
//               // SizedBox(height: 4),
//               // Indicator(
//               //   color: AppColors.contentColorPurple,
//               //   text: 'Third',
//               //   isSquare: true,
//               // ),
//               // SizedBox(height: 4),
//               // Indicator(
//               //   color: AppColors.contentColorGreen,
//               //   text: 'Fourth',
//               //   isSquare: true,
//               // ),
//               SizedBox(height: 18),
//             ],
//           ),
//           const SizedBox(width: 28),
//         ],
//       ),
//     );
//   }

//   List<PieChartSectionData> showingSections() {
//     return List.generate(4, (i) {
//       final isTouched = i == touchedIndex;
//       final fontSize = isTouched ? 25.0 : 16.0;
//       final radius = isTouched ? 60.0 : 50.0;
//       const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
//       switch (i) {
//         case 0:
//           return PieChartSectionData(
//             color: AppColors.camreraPreviewColor,
//             value: 40,
//             title: '40%',
//             radius: radius,
//             titleStyle: TextStyle(
//               fontSize: fontSize,
//               fontWeight: FontWeight.bold,
//               color: AppColors.error,
//               shadows: shadows,
//             ),
//           );
//         case 1:
//           return PieChartSectionData(
//             color: AppColors.camreraPreviewColor,
//             value: 30,
//             title: '30%',
//             radius: radius,
//             titleStyle: TextStyle(
//               fontSize: fontSize,
//               fontWeight: FontWeight.bold,
//               color: AppColors.primary,
//               shadows: shadows,
//             ),
//           );
//         case 2:
//           return PieChartSectionData(
//             color: AppColors.powerBy,
//             value: 15,
//             title: '15%',
//             radius: radius,
//             titleStyle: TextStyle(
//               fontSize: fontSize,
//               fontWeight: FontWeight.bold,
//               color: AppColors.backArrowColor,
//               shadows: shadows,
//             ),
//           );
//         case 3:
//           return PieChartSectionData(
//             color: AppColors.guestIconColor,
//             value: 15,
//             title: '15%',
//             radius: radius,
//             titleStyle: TextStyle(
//               fontSize: fontSize,
//               fontWeight: FontWeight.bold,
//               color: AppColors.camreraPreviewColor,
//               shadows: shadows,
//             ),
//           );
//         default:
//           throw Error();
//       }
//     });
//   }
// }

// class HalfPieChart extends StatelessWidget {
//   const HalfPieChart({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 2, // Wider for half-circle
//       child: PieChart(
//         PieChartData(
//           startDegreeOffset: 180, // Start from bottom
//           sectionsSpace: 2,
//           centerSpaceRadius: 60, // Inner hole for donut
//           sections: showingSections(),
//         ),
//       ),
//     );
//   }

//   List<PieChartSectionData> showingSections() {
//     return [
//       PieChartSectionData(
//         color: Colors.green,
//         value: 40,
//         title: '40%',
//         radius: 80,
//         titleStyle: const TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ),
//       ),
//       PieChartSectionData(
//         color: Colors.orange,
//         value: 30,
//         title: '30%',
//         radius: 80,
//         titleStyle: const TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ),
//       ),
//       PieChartSectionData(
//         color: Colors.red,
//         value: 30,
//         title: '30%',
//         radius: 80,
//         titleStyle: const TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ),
//       ),
//     ];
//   }
// }

// class GaugeIndicator extends StatelessWidget {
//   const GaugeIndicator();

//   /// Build method of your widget.
//   @override
//   Widget build(BuildContext context) {
//     // Create animated radial gauge.
//     // All arguments changes will be automatically animated.
//     return Center(
//       child: AnimatedRadialGauge(
//         /// The animation duration.
//         duration: const Duration(seconds: 1),
//         curve: Curves.elasticOut,
//         radius: 70,
//         value: 40,
//         axis: GaugeAxis(
//           min: 0,
//           max: 100,
//           degrees: 310,
//           style: const GaugeAxisStyle(
//             thickness: 15,
//             background: Color(0xFFDFE2EC),
//             segmentSpacing: 4,
//           ),
//           pointer: GaugePointer.circle(radius: 8.0, color: Colors.red),
//           // .needle(
//           //   borderRadius: 16,
//           //   width: 100,
//           //   height: 10,
//           //   color: Colors.black,
//           // ),

//           /// Define the progress bar (optional).
//           progressBar: const GaugeProgressBar.rounded(
//             color: Colors.transparent,
//           ),

//           /// Define axis segments (optional).
//           segments: [
//             const GaugeSegment(
//               from: 0,
//               to: 33.3,
//               color: Colors.red,
//               cornerRadius: Radius.zero,
//             ),
//             const GaugeSegment(
//               from: 33.3,
//               to: 66.6,
//               color: Colors.amber,
//               cornerRadius: Radius.zero,
//             ),
//             const GaugeSegment(
//               from: 66.6,
//               to: 100,
//               color: Colors.black,
//               cornerRadius: Radius.zero,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class GaugeIndicator extends StatelessWidget {
//   const GaugeIndicator({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           /// The gauge
//           AnimatedRadialGauge(
//             duration: const Duration(seconds: 1),
//             curve: Curves.elasticOut,
//             radius: 100,
//             value: 40,
//             axis: GaugeAxis(
//               min: 0,
//               max: 100,
//               degrees: 310,
//               style: const GaugeAxisStyle(
//                 thickness: 15,
//                 background: Color(0xFFDFE2EC),
//                 segmentSpacing: 4,
//               ),
//               pointer: GaugePointer.circle(radius: 8.0, color: Colors.red),
//               progressBar: const GaugeProgressBar.rounded(
//                 color: Colors.transparent,
//               ),
//               segments: [
//                 const GaugeSegment(
//                   from: 0,
//                   to: 33.3,
//                   color: Colors.red,
//                   cornerRadius: Radius.zero,
//                 ),
//                 const GaugeSegment(
//                   from: 33.3,
//                   to: 66.6,
//                   color: Colors.amber,
//                   cornerRadius: Radius.zero,
//                 ),
//                 const GaugeSegment(
//                   from: 66.6,
//                   to: 100,
//                   color: Colors.black,
//                   cornerRadius: Radius.zero,
//                 ),
//               ],
//             ),
//           ),

//           /// Badge for first segment (0–33.3)
//           Positioned(
//             left: 30, // adjust based on segment position
//             bottom: 40,
//             child: Container(
//               padding: const EdgeInsets.all(6),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(color: Colors.red, width: 2),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: const Text(
//                 "Low", // badge text
//                 style: TextStyle(
//                   fontSize: 10,
//                   color: Colors.red,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class GaugeIndicator extends StatelessWidget {
//   const GaugeIndicator({super.key});

//   @override
//   Widget build(BuildContext context) {
//     const double radius = 100; // radius of gauge
//     const double gaugeDegrees = 310; // total arc
//     const double startAngle = (360 - gaugeDegrees) / 2; // center the arc

//     // Segment definitions
//     final List<Map<String, dynamic>> segments = [
//       {"from": 0.0, "to": 33.3, "color": Colors.red, "label": "Medium"},
//       {"from": 33.3, "to": 66.6, "color": Colors.amber, "label": "Medium"},
//       {"from": 66.6, "to": 100.0, "color": Colors.black, "label": "Medium"},
//     ];

//     return Center(
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           /// Gauge
//           AnimatedRadialGauge(
//             duration: const Duration(seconds: 1),
//             curve: Curves.elasticOut,
//             radius: radius,
//             value: 40,
//             axis: GaugeAxis(
//               min: 0,
//               max: 100,
//               degrees: gaugeDegrees,
//               style: const GaugeAxisStyle(
//                 thickness: 15,
//                 background: Color(0xFFDFE2EC),
//                 segmentSpacing: 4,
//               ),
//               pointer: GaugePointer.circle(radius: 8.0, color: Colors.red),
//               progressBar: const GaugeProgressBar.rounded(
//                 color: Colors.transparent,
//               ),
//               segments:
//                   segments
//                       .map(
//                         (s) => GaugeSegment(
//                           from: s["from"],
//                           to: s["to"],
//                           color: s["color"],
//                           cornerRadius: Radius.zero,
//                         ),
//                       )
//                       .toList(),
//             ),
//           ),

//           /// Badges for each segment
//           ...segments.map((s) {
//             final midValue = (s["from"] + s["to"]) / 2;

//             // Convert value to angle (in radians)
//             final angle =
//                 (startAngle + (midValue / 100 * gaugeDegrees)) * pi / 180;

//             // Position outside the gauge radius
//             final double badgeDistance = radius + 30; // 30px outside the arc
//             final double dx = badgeDistance * cos(angle);
//             final double dy = badgeDistance * sin(angle);

//             return Positioned(
//               left: radius + dx,
//               top: radius + dy,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   border: Border.all(color: s["color"], width: 2),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Text(
//                   s["label"],
//                   style: TextStyle(
//                     fontSize: 10,
//                     color: s["color"],
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             );
//           }),
//         ],
//       ),
//     );
//   }
// }

// class GaugeIndicator extends StatelessWidget {
//   const GaugeIndicator({super.key});

//   @override
//   Widget build(BuildContext context) {
//     const double radius = 100.0; // gauge radius
//     const double gaugeDegrees = 310.0; // arc span
//     // startAngle in degrees to center the arc horizontally
//     const double startAngle = (360.0 - gaugeDegrees) / 2.0;

//     const double minValue = 0.0;
//     const double maxValue = 200.0;

//     final segments = [
//       {"from": 0.0, "to": 33.3, "color": Colors.red, "label": "Low"},
//       {"from": 33.3, "to": 66.6, "color": Colors.amber, "label": "Medium"},
//       {"from": 66.6, "to": 100.0, "color": Colors.red, "label": "High"},
//       {"from": 100.0, "to": 150.0, "color": Colors.red, "label": "High"},
//       {"from": 150.0, "to": 200.0, "color": Colors.amber, "label": "Medium"},
//     ];

// // Convert a value -> angle (forward mapping)
// double forwardAngleForValue(double value) {
//   final rel = (value - minValue) / (maxValue - minValue);
//   return (startAngle + rel * gaugeDegrees) % 360.0;
// }

// // We'll test monotonicity of forward mapping across segment midpoints.
// final midValues =
//     segments
//         .map((s) => ((s["from"] as double) + (s["to"] as double)) / 2.0)
//         .toList();
// final relAngles =
//     midValues
//         .map((v) => (forwardAngleForValue(v) - startAngle + 360.0) % 360.0)
//         .toList();

// // If the mapped angles are not increasing along the arc, the gauge likely draws in the opposite direction.
// bool forwardIsMonotonic = true;
// for (var i = 0; i < relAngles.length - 1; i++) {
//   if (relAngles[i] > relAngles[i + 1]) {
//     forwardIsMonotonic = false;
//     break;
//   }
// }

// // angle factory which flips automatically if needed
// double angleRadForValue(double value) {
//   final rel = (value - minValue) / (maxValue - minValue);
//   final angleDeg =
//       forwardIsMonotonic
//           ? (startAngle + rel * gaugeDegrees)
//           : (startAngle + (1.0 - rel) * gaugeDegrees); // flipped mapping
//   return angleDeg * math.pi / 180.0;
// }

// const double padding = 40.0; // extra area so badges don't overflow
// final double size = radius * 2 + padding * 2;

// return Center(
//   child: Stack(
//     alignment: Alignment.center,
//     children: [
//       // Your gauge
//       AnimatedRadialGauge(
//         duration: const Duration(seconds: 1),
//         curve: Curves.elasticOut,
//         radius: radius,
//         value: 40,
//         axis: GaugeAxis(
//           min: minValue,
//           max: maxValue,
//           degrees: gaugeDegrees,
//           style: const GaugeAxisStyle(
//             thickness: 15,
//             background: Color(0xFFDFE2EC),
//             segmentSpacing: 4,
//           ),
//           pointer: GaugePointer.circle(radius: 8.0, color: Colors.red),
//           progressBar: const GaugeProgressBar.rounded(
//             color: Colors.transparent,
//           ),
//           segments:
//               segments
//                   .map(
//                     (s) => GaugeSegment(
//                       from: s["from"] as double,
//                       to: s["to"] as double,
//                       color: s["color"] as Color,
//                       cornerRadius: Radius.zero,
//                     ),
//                   )
//                   .toList(),
//         ),
//       ),

// badges placed with Align + Transform.translate (centered offset)
// ...segments.map((s) {
//   final mid = ((s["from"] as double) + (s["to"] as double)) / 2.0;
//   final angleRad = angleRadForValue(mid);
//   // distance from center: radius + offset (tweak offset to taste)
//   final double badgeDistance = radius + 22.0;
//   final double dx = badgeDistance * math.cos(angleRad);
//   final double dy = badgeDistance * math.sin(angleRad);

//   return Align(
//     alignment: Alignment.center,
//     child: Transform.translate(
//       offset: Offset(dx, dy),
//       child: _badgeForSegment(
//         s["label"] as String,
//         s["color"] as Color,
//       ),
//     ),
//   );
// }).toList(),
//       ],
//     ),
//   );
// }

Widget _badgeForSegment(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: color, width: 2),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 4)],
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.bold),
    ),
  );
}

//}
