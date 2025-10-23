import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/landing/landing_controller.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class PulseSurveyAnalyzingScreen extends StatelessWidget {
  PulseSurveyAnalyzingScreen({super.key});
  final _controller = Get.find<LandingController>();
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () {
      _controller.onTabTapped(3);
    });
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(AppAssets.pulseAnlyzing),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            SvgPicture.asset(AppAssets.success),
            30.verticalSpace,
            CommonText.text(
              AppConstents.allDone,
              fontSize: AppDimensions.font(22),
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
            10.verticalSpace,
            CommonText.text(
              AppConstents.analyzingYourPulseSurvey,
              fontSize: AppDimensions.font(16),
              fontWeight: FontWeight.w400,
              color: AppColors.conDiscription,
            ),
            40.verticalSpace,
            SizedBox(
              width: AppDimensions.width(60),
              height: AppDimensions.height(60),
              child: LoadingIndicator(
                strokeWidth: 1,
                colors: [AppColors.primary],
                indicatorType: Indicator.lineSpinFadeLoader,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
