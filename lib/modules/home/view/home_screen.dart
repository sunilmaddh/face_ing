import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ntt_data/core/base/base_view.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/common_assets.dart';
import 'package:ntt_data/modules/home/controller/home_controller.dart';
import 'package:ntt_data/modules/home/widget/daily_advice_card_widget.dart';
import 'package:ntt_data/modules/home/widget/menu_card_widget.dart';
import 'package:ntt_data/modules/home/widget/wellness_card.dart';
import 'package:ntt_data/modules/landing/controller/landing_controller.dart';
import 'package:ntt_data/modules/landing/view/face_drawer.dart';
import 'package:ntt_data/modules/phq/controllers/assessment_controller.dart';
import 'package:ntt_data/modules/profile/controller/profile_controller.dart';
import 'package:ntt_data/modules/pulse/controller/pulse_survey_controller.dart';

class HomeScreen extends BaseView<HomeController> {
  const HomeScreen({super.key});

  @override
  void onInit(HomeController controller) {
    final profileController = Get.find<ProfileController>();
    final pulseController = Get.find<PulseSurveyController>();
    final assessmentController = Get.find<AssessmentController>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await profileController.initializeData();
      await controller.getWellnessScore();
      await pulseController.fetchPulseSurvey();
      await assessmentController.getSession();
    });
  }

  @override
  Widget buildView(BuildContext context, HomeController controller) {
    final landingController = Get.find<LandingController>();

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: FaceDrawer(),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: LottieBuilder.asset(
              AppAssets.homeLottie,
              fit: BoxFit.cover,
              repeat: true,
              reverse: false,
              animate: true,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 200.h),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            landingController.scaffoldKey.currentState
                                ?.openDrawer();
                          },
                          child: CommonAssets.svgAsset(
                            AppAssets.person,
                            width: AppDimensions.width(40),
                            height: AppDimensions.height(40),
                          ),
                        ),
                        const Spacer(),
                        CommonAssets.svgAsset(AppAssets.logo),
                        const Spacer(flex: 2),
                      ],
                    ),
                  ),
                  SizedBox(height: AppDimensions.height(10)),
                  Obx(
                    () => WellnessCard(
                      guageValue: controller.wellnessScore.value,
                      wellnessDiff:
                          controller
                              .wellnessModel
                              .value
                              ?.wellnessIndexValueDiff ??
                          "",
                      status:
                          controller.wellnessModel.value?.wellnessIndexstatus ??
                          "",
                      wellnessPosNeg:
                          controller
                              .wellnessModel
                              .value
                              ?.wellnessIndexPosOrNeg ??
                          "",
                    ),
                  ),
                  SizedBox(height: AppDimensions.height(15)),
                  MenuCardWidget(),
                  SizedBox(height: AppDimensions.height(15)),
                  const DailyAdviceCardWidget(),
                  SizedBox(height: AppDimensions.height(15)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
