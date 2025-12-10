import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class AiAdviceScreen extends StatelessWidget {
  const AiAdviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: "Daily Advice",
        onTop: () {},
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20.h),
          Center(
            child: Image.asset(
              width: 115.w,
              height: 120.h,
              AppAssets.dailyAdviceAssets,
            ),
          ),
          SizedBox(height: 20.h),
          CommonText.text(
            "Personalized insights for your day.",
            fontFamily: "Manrope",
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: Color(0xff616161).withOpacity(0.50),
          ),
        ],
      ),
    );
  }
}
