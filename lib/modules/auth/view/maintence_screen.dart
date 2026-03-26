import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class MaintenceScreen extends StatelessWidget {
  const MaintenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.historyCardColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          LottieBuilder.asset(
            width: AppDimensions.width(500),
            height: AppDimensions.width(300),
            AppAssets.maintence,
          ),
          20.verticalSpace,
          CommonText.text(
            "Coming Soon.......",
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
            fontSize: AppDimensions.font(30),
          ),
        ],
      ),
    );
  }
}
