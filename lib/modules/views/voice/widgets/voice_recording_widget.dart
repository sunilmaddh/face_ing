import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class VoiceRecordingWidget extends StatelessWidget {
  const VoiceRecordingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LottieBuilder.asset(
          AppAssets.voiceProgress,
          height: AppDimensions.height(40),
          width: AppDimensions.width(151),
          delegates: LottieDelegates(
            values: [
              ValueDelegate.color(
                const ['**'], // applies to all layers
                value: AppColors.primary, // your new color
              ),
            ],
          ),
        ),
        10.verticalSpace,
        CommonText.text(
          "00:00:00",
          fontSize: AppDimensions.font(12),
          fontWeight: FontWeight.w400,
          color: Color(0xff717171),
        ),
        80.verticalSpace,
        CommonText.text(
          "I am good so",
          fontSize: AppDimensions.font(30),
          fontWeight: FontWeight.w700,
          color: Color(0xff7B7777),
        ),
        30.verticalSpace,
      ],
    );
  }
}
