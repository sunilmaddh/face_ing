import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class VoiceTopWidget extends StatelessWidget {
  const VoiceTopWidget({super.key, required this.onTop});
  final VoidCallback onTop;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CommonText.text(
          "Top to start recording",
          fontSize: AppDimensions.font(14),
          fontWeight: FontWeight.w500,
          color: Color(0xff717171),
        ),
        30.verticalSpace,
        InkWell(
          onTap: onTop,
          child: LottieBuilder.asset(
            AppAssets.voiceLottie,
            height: AppDimensions.height(120),
            width: AppDimensions.width(120),
          ),
        ),
        10.verticalSpace,
        CommonText.text(
          "00:00:00",
          fontSize: AppDimensions.font(12),
          fontWeight: FontWeight.w400,
          color: Color(0xff717171),
        ),
      ],
    );
  }
}
