import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/data/models/vital_graph_response_model.dart';
import 'package:ntt_data/modules/views/pulse/helper/pulse_helper.dart';
import 'package:ntt_data/modules/views/pulse/views/pulse_health_status.dart';
import 'package:ntt_data/modules/views/pulse/widget/pulse_line_chart.dart';
import 'package:ntt_data/modules/views/vital_graph/helper/vital_grapgh_helper.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class PulseScreen extends StatelessWidget {
  const PulseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var healthListJson = PulseHelper.lineChart['healthList'] as List<dynamic>?;

    List<HealthList> healthList =
        healthListJson != null
            ? healthListJson.map((e) => HealthList.fromJson(e)).toList()
            : [];

    var healthLists = VitalGraphHelper().normalizeHealthData(
      PulseHelper.lineChart["xValues"],
      healthList,
    );
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: CustomAppBar(
        title: "Pulse History",
        onTop: () {},
        isCenterTitle: false,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColors.btntext,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  10.verticalSpace,
                  CommonText.text(
                    AppConstents.todayResult,
                    fontSize: AppDimensions.font(14),
                    fontWeight: FontWeight.w700,
                    color: Color(0xff898989),
                  ),
                  CommonText.text(
                    "Great",
                    fontSize: AppDimensions.font(46),
                    fontWeight: FontWeight.w700,
                    color: Colors.green,
                  ),
                  10.verticalSpace,
                ],
              ),
            ),

            Container(
              width: Get.width,
              padding: AppDimensions.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Column(
                children: [
                  PulseHealthStatus(),
                  20.verticalSpace,
                  PulseLineChart(healthList: healthLists),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
