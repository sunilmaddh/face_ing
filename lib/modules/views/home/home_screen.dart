import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ntt_data/core/utils/common_assets.dart';
import 'package:ntt_data/modules/views/binah/controllers/measurement_controller.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/auth/controllers/auth_controller.dart';
import 'package:ntt_data/modules/views/geust/controller/geust_controller.dart';
import 'package:ntt_data/modules/views/home/controllers/home_controller.dart';
import 'package:ntt_data/modules/views/home/face_drawer.dart';
import 'package:ntt_data/modules/views/home/widgets/daily_advice_card_widget.dart';
import 'package:ntt_data/modules/views/home/widgets/menu_card_widget.dart';
import 'package:ntt_data/modules/views/home/widgets/wellness_card.dart';
import 'package:ntt_data/modules/views/landing/landing_controller.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = Get.find<MeasurementController>();
  final gcontroller = Get.find<GeustController>();
  final authController = Get.find<AuthController>();
  final homeController = Get.put(HomeController());
  final landingController = Get.put(LandingController());

  @override
  void initState() {
    super.initState();
    homeController.getWellnessScore();
    authController.initializedData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: landingController.scaffoldKey,
      drawer: FaceDrawer(),
      body: Stack(
        children: [
          Positioned.fill(
            // top: AppDimensions.height(20),
            child: LottieBuilder.asset(
              fit: BoxFit.cover,
              AppAssets.homeLottie,

              repeat: true,
              reverse: false,
              animate: true,
            ),
            // SvgPicture.asset(AppAssets.homeBg, fit: BoxFit.cover),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 16.h),
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

                  SizedBox(height: AppDimensions.height(10)),

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

                  SizedBox(height: AppDimensions.height(15)),

                  MenuCardWidget(),

                  SizedBox(height: AppDimensions.height(15)),
                  DailyAdviceCardWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
