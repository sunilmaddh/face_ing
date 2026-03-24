import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/data/models/pulse_survey_model.dart';
import 'package:ntt_data/modules/views/landing/pulse/helper/pulse_helper.dart';
import 'package:ntt_data/modules/views/landing/pulse/widget/pulse_Line_chart_widget.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';

class PulseLineChart extends StatelessWidget {
  const PulseLineChart({
    super.key,
    required this.pulseServeyModel,
    this.isShowHome = false,
    this.height = 120.0,
  });

  final PulseSurveyModel pulseServeyModel;
  final bool isShowHome;
  final double height;

  @override
  Widget build(BuildContext context) {
    final pulsList = PulseHelper().normalizeHealthData(
      pulseServeyModel.xAxis!,
      pulseServeyModel.result!,
    );
    return CommonCard(
      radius: 12,
      isBorder: true,
      widget: SizedBox(
        width: Get.width,
        child: Padding(
          padding: AppDimensions.symmetric(vertical: 30.h, horizontal: 15.w),
          child: Column(
            children: [
              PulseLineChartWidget(
                height: height,
                bottomTitles: pulseServeyModel.xAxis!,
                vitalValues: pulsList,
              ),
              10.verticalSpace,
              isShowHome == false
                  ? Wrap(
                    alignment: WrapAlignment.start,
                    direction: Axis.horizontal,
                    spacing: 10,
                    runSpacing: 3,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runAlignment: WrapAlignment.center,
                    children:
                        pulseServeyModel.statusList != null
                            ? pulseServeyModel.statusList!.map((v) {
                              final color = PulseHelper().getColor(v);
                              return SizedBox(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(
                                      radius: 5.5,
                                      backgroundColor: color,
                                    ),
                                    4.horizontalSpace,

                                    Text(
                                      v,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: color,
                                        fontFamily: "Mulish",
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList()
                            : [],
                  )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
