import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class PulseSurveyAnalyzingScreen extends StatefulWidget {
  const PulseSurveyAnalyzingScreen({super.key});

  @override
  State<PulseSurveyAnalyzingScreen> createState() =>
      _PulseSurveyAnalyzingScreenState();
}

class _PulseSurveyAnalyzingScreenState
    extends State<PulseSurveyAnalyzingScreen> {
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();

    _navigationTimer = Timer(const Duration(seconds: 5), () {
      if (!mounted) return;
      AppNavigation.off(AppRoutes.pulseScreen);
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(AppAssets.pulseAnlyzing),
          ),
        ),
        child: Column(
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
              child: const LoadingIndicator(
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
