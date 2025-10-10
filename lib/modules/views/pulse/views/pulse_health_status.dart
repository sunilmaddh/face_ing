import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/pulse/helper/pulse_helper.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class PulseHealthStatus extends StatelessWidget {
  const PulseHealthStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      radius: 12,
      isBorder: true,

      widget: SizedBox(
        width: Get.width,
        child: Padding(
          padding: AppDimensions.symmetric(vertical: 20),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 40,
            runSpacing: 40,
            children:
                PulseHelper.pulseStatus
                    .map(
                      (value) => Column(
                        children: [
                          CommonText.text(
                            value["value"],
                            fontSize: AppDimensions.font(13),
                            fontWeight: FontWeight.w700,
                            color: Color(0xff616161),
                          ),
                          8.verticalSpace,
                          SvgPicture.asset(value["image"]),
                        ],
                      ),
                    )
                    .toList(),
          ),
        ),
      ),
    );
  }
}
