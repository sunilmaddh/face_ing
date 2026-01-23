import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/modules/views/ai/controller/ai_controller.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class AiAdviceScreen extends StatelessWidget {
  AiAdviceScreen({super.key});
  final _controller = Get.put(AiController());

  @override
  Widget build(BuildContext context) {
    _controller.aIRecamendation();
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: false,
        isCenterTitle: false,
        title: "Daily Advice",
        onTop: () {},
      ),
      body: Obx(() {
        if (_controller.isAlLoading.isTrue) {
          return const Center(child: CircularProgressIndicator());
        }

        final response = _controller.airesponse.value;

        if (response.resp1 != null && response.resp1!.isNotEmpty) {
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
                CommonText.text(
                  "Personalized insights for your day.",
                  fontSize: 12.sp,
                  fontFamily: "Manrope",
                  fontWeight: FontWeight.w700,
                  color: Color(0xff616161).withAlpha(128),
                ),
                SizedBox(height: 30.h),
                CommonText.text(
                  response.resp1!,
                  maxLines: 100,
                  fontFamily: "Manrope",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff616161),
                ),

                SizedBox(height: 30.h),

                if (response.resp2 != null && response.resp2!.isNotEmpty)
                  CommonText.text(
                    response.resp2!,
                    maxLines: 100,
                    fontFamily: "Manrope",
                    fontSize: 16.sp,
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
