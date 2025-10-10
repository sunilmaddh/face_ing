import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/data/models/vital_graph_response_model.dart';
import 'package:ntt_data/modules/views/pulse/helper/pulse_helper.dart';
import 'package:ntt_data/modules/views/vital_graph/widgets/line_chart/custom_line_chart_widget.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';

class PulseLineChart extends StatelessWidget {
  const PulseLineChart({super.key, required this.healthList});

  final List<HealthList> healthList;

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      radius: 12,
      isBorder: true,
      widget: SizedBox(
        width: Get.width,
        child: Padding(
          padding: AppDimensions.symmetric(vertical: 30, horizontal: 15),
          child: Column(
            children: [
              CustomLineChartWidget(
                leftTitles: PulseHelper.lineChart["xValues"],
                bottomTitles: PulseHelper.lineChart["xValues"],
                vitalValues: healthList,
                vitalName: PulseHelper.lineChart["vitalName"],
              ),
              10.verticalSpace,
              Padding(
                padding: AppDimensions.only(bottom: 10),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  direction: Axis.horizontal,
                  spacing: 10,
                  runSpacing: 3,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runAlignment: WrapAlignment.center,
                  children:
                      PulseHelper.statusList != null
                          ? PulseHelper.statusList.map((v) {
                            return SizedBox(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    radius: 5.5,
                                    backgroundColor: v.color,
                                  ),
                                  4.horizontalSpace,

                                  Text(
                                    v.status,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: v.color,
                                      fontFamily: "Mulish",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList()
                          : [],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
