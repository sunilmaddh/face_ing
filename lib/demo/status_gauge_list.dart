import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/extentions.dart';
import 'package:ntt_data/data/models/vital_graph_response_model.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:intl/intl.dart';

class StatusList extends StatelessWidget {
  const StatusList({super.key, required this.healthList});

  final List<HealthList> healthList;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children:
          healthList
              .map(
                (item) => StatusGaugeList(
                  statuses: item.value.toString(),
                  scanDate: item.scannedDate.toString(),
                  value: item.value.toString(),
                ),
              )
              .toList(),
    );
  }
}

class StatusGaugeList extends StatelessWidget {
  final String statuses;
  final String scanDate;
  final String value;
  const StatusGaugeList({
    super.key,
    required this.statuses,
    required this.scanDate,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          StatusGaugeChart(status: statuses, scanDate: scanDate, value: value),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class StatusGaugeChart extends StatelessWidget {
  final String status;
  final String scanDate;
  String value;

  StatusGaugeChart({
    super.key,
    required this.status,
    required this.scanDate,
    this.value = "",
  });
  String valued = "";
  @override
  Widget build(BuildContext context) {
    valued = this.value;
    if (this.value.contains("/")) {
      valued = this.value;
    }
    final statuses = [
      {"value": "Extreme", "color": 0xFFFD2213},
      {"value": "High", "color": 0xFF1BC76D},
      {"value": "Medium", "color": 0xFFEEC000},
      {"value": "Normal", "color": 0xFF1BC76D},
      {"value": "Mild", "color": 0xFFEEC000},
      {"value": "Low", "color": 0xFFFA704E},
      {"value": "Prediabetes", "color": 0xFFEEC000},
      {"value": "Diabetes", "color": 0xFFFD2213},
    ];

    final double value = _mapStatusToValue(status, statuses);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
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
                ranges:
                    List.generate(statuses.length, (i) {
                      final double segmentSize = 100 / statuses.length;
                      final double start = i * segmentSize;
                      final double end = start + segmentSize;

                      return GaugeRange(
                        startValue: start,
                        endValue: end,
                        color: Color(statuses[i]["color"] as int),
                        label: statuses[i]["value"].toString(),
                        labelStyle: GaugeTextStyle(
                          fontSize: AppDimensions.font(8.0),
                          color: AppColors.btntext,
                          fontWeight: FontWeight.w500,
                        ),
                        sizeUnit: GaugeSizeUnit.factor,
                        startWidth: 0.3,
                        endWidth: 0.3,
                      );
                    }).toList(),
                pointers: [
                  NeedlePointer(
                    value: value,
                    needleLength: 0.7,
                    needleStartWidth: 0,
                    needleEndWidth: 5,
                    knobStyle: const KnobStyle(
                      knobRadius: 0.06,
                      color: Colors.black,
                    ),
                  ),
                ],
                annotations: [
                  GaugeAnnotation(
                    positionFactor: 0.4,
                    angle: 90,
                    widget: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          valued.toString().toFirstCaps(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          dateFormate(scanDate),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  String dateFormate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    String formattedDate = DateFormat("dd MMM hh:mm a").format(parsedDate);
    return formattedDate;
  }

  /// Dynamically maps status → center of its segment
  double _mapStatusToValue(String status, List<Map<String, Object>> statuses) {
    final int index = statuses.indexWhere(
      (s) => s["value"].toString().toLowerCase() == status.toLowerCase(),
    );

    if (index == -1) return 50; // fallback if not found

    final double segmentSize = 100 / statuses.length;
    final double start = index * segmentSize;
    return start + (segmentSize / 2); // center of the slice
  }
}
