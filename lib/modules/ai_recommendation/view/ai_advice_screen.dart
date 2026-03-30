import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/base/base_view.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_strings.dart'; // ✅ added
import 'package:ntt_data/modules/ai_recommendation/controller/ai_advice_controller.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class AiAdviceScreen extends BaseView<AiAdviceController> {
  const AiAdviceScreen({super.key});

  @override
  bool get useDefaultLoader => false;

  @override
  void onReady(AiAdviceController controller) {
    controller.fetchAiRecommendation();
  }

  @override
  Widget buildView(BuildContext context, AiAdviceController controller) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: false,
        isCenterTitle: false,
        title: AppStrings.dailyAdvice, // ✅ updated
        onTop: () {},
      ),
      body: Obx(() {
        final response = controller.aiResponse.value;
        if (response?.resp1 != null && response!.resp1!.isNotEmpty) {
          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              15.w,
              0,
              15.w,
              kBottomNavigationBarHeight +
                  MediaQuery.of(context).padding.bottom +
                  20.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                Image.asset(
                  AppAssets.dailyAdviceAssets,
                  width: 115.w,
                  height: 120.h,
                ),
                SizedBox(height: 10.h),
                CommonText.labelMedium(
                  AppStrings.personalizedInsights, // ✅ updated
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff616161).withAlpha(128),
                ),
                SizedBox(height: 30.h),
                CommonText.titleMedium(
                  response.resp1!,
                  maxLines: 100,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff616161),
                ),
                SizedBox(height: 30.h),
                if (response.resp2 != null && response.resp2!.isNotEmpty)
                  CommonText.titleMedium(
                    response.resp2!,
                    maxLines: 100,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff616161),
                  ),
              ],
            ),
          );
        }

        return Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Image.asset(AppAssets.noDataImage),
          ),
        );
      }),
    );
  }
}
