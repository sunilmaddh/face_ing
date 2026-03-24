import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/data/models/pulse_survey_model.dart';
import 'package:ntt_data/modules/views/landing/pulse/helper/pulse_helper.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class PulseHealthStatus extends StatelessWidget {
  const PulseHealthStatus({super.key, required this.pulseSurveyADay});
  final List<PulseSurveyADay> pulseSurveyADay;

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      radius: 12,
      isBorder: true,

      widget: Obx(
        () => SizedBox(
          width: Get.width,
          child: Padding(
            padding: AppDimensions.symmetric(horizontal: 3.w, vertical: 10.h),
            child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              spacing: 20,
              runSpacing: 10,
              children:
                  pulseSurveyADay.map((value) {
                    return Column(
                      children: [
                        CommonText.text(
                          value.title.toString(),
                          fontSize: AppDimensions.font(13),
                          fontWeight: FontWeight.w700,
                          color: Color(0xff616161),
                        ),
                        8.verticalSpace,

                        CommonText.text(
                          value.status.toString(),
                          fontSize: AppDimensions.font(13),
                          fontWeight: FontWeight.w700,
                          color: PulseHelper().getColor(
                            value.status.toString(),
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    );
                  }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
