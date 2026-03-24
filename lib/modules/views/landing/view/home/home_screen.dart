import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ntt_data/core/utils/common_assets.dart';
import 'package:ntt_data/modules/views/binah/controllers/measurement_controller.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/auth/controllers/auth_controller.dart';
import 'package:ntt_data/modules/views/geust/controller/geust_controller.dart';
import 'package:ntt_data/modules/views/landing/controller/home_controller.dart';
import 'package:ntt_data/modules/views/landing/view/face_drawer.dart';
import 'package:ntt_data/modules/views/landing/widgets/home_widget/daily_advice_card_widget.dart';
import 'package:ntt_data/modules/views/landing/widgets/home_widget/menu_card_widget.dart';
import 'package:ntt_data/modules/views/landing/widgets/home_widget/wellness_card.dart';
import 'package:ntt_data/modules/views/landing/controller/landing_controller.dart';
import 'package:ntt_data/modules/views/phq/controllers/assessment_controller.dart';
import 'package:ntt_data/modules/views/landing/pulse/controller/pulse_survey_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // final controller = Get.find<MeasurementController>();
  final gcontroller = Get.find<GeustController>();
  final authController = Get.find<AuthController>();
  final homeController = Get.find<HomeController>();
  final landingController = Get.find<LandingController>();
  final pulseController = Get.find<PulseSurveyController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController.getWellnessScore();
      pulseController.fetchPulseSurvey();
      AssessmentController.instance.getSession();
    });
    authController.initializedData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: FaceDrawer(),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: LottieBuilder.asset(
              fit: BoxFit.cover,
              AppAssets.homeLottie,
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
                          onTap:
                              () =>
                                  landingController.scaffoldKey.currentState!
                                      .openDrawer(),
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

                  SizedBox(height: AppDimensions.height(10.h)),

                  Obx(
                    () => WellnessCard(
                      guageValue: homeController.wellnessScore.value,
                      wellnessDiff:
                          homeController
                              .wellnessModel
                              .value
                              .wellnessIndexValueDiff
                              .toString(),
                      status:
                          homeController.wellnessModel.value.wellnessIndexstatus
                              .toString(),
                      wellnessPosNeg:
                          homeController
                              .wellnessModel
                              .value
                              .wellnessIndexPosOrNeg
                              .toString(),
                    ),
                  ),

                  SizedBox(height: AppDimensions.height(15.h)),
                  MenuCardWidget(),
                  SizedBox(height: AppDimensions.height(15.h)),
                  DailyAdviceCardWidget(),
                  SizedBox(height: AppDimensions.height(15.h)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
