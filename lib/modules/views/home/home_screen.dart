import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/common_assets.dart';
import 'package:ntt_data/modules/views/binah/controllers/measurement_controller.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/auth/controllers/auth_controller.dart';
import 'package:ntt_data/modules/views/geust/controller/geust_controller.dart';
import 'package:ntt_data/modules/views/home/controllers/home_controller.dart';
import 'package:ntt_data/modules/views/home/face_drawer.dart';
import 'package:ntt_data/modules/views/home/halper/home_halper.dart';
import 'package:ntt_data/modules/views/home/widgets/daily_advice_card_widget.dart';
import 'package:ntt_data/modules/views/home/widgets/menu_card.dart';
import 'package:ntt_data/modules/views/home/widgets/wellness_card.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = Get.find<MeasurementController>();
  final gcontroller = Get.find<GeustController>();
  final authController = Get.find<AuthController>();
  final homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.getWellnessScore();
    authController.initializedData();
  }

  @override
  Widget build(BuildContext context) {
    homeController.wellnessScore.value =
        double.tryParse(
          homeController.wellnessModel.value.wellnessIndex ?? '',
        ) ??
        0.0;
    return Scaffold(
      key: _scaffoldKey,

      drawer: FaceDrawer(),
      body: Stack(
        children: [
          Positioned.fill(
            top: AppDimensions.height(70),
            child: SvgPicture.asset(AppAssets.homeBg, fit: BoxFit.cover),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => _scaffoldKey.currentState!.openDrawer(),
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

                  Padding(
                    padding: AppDimensions.symmetric(horizontal: 16),
                    child: CommonCard(
                      widget: Padding(
                        padding: AppDimensions.symmetric(
                          horizontal: 15,
                          vertical: 15,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    // AppNavigation.to(
                                    //   AppRoutes.pulseSurveyScreen,
                                    // );
                                  },
                                  child: MenuCard(
                                    menuTitle: "Pulse Survey",
                                    image: AppAssets.pulseServe,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    // AppNavigation.to(AppRoutes.voiceScreen);
                                  },
                                  child: MenuCard(
                                    menuTitle: "Voice Scan",
                                    image: AppAssets.voiceScan,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: AppDimensions.height(15)),
                            CommonCard(
                              color: AppColors.homeCardColor,
                              widget: SizedBox(
                                height: AppDimensions.height(71),
                                width: Get.width,
                                child: Padding(
                                  padding: AppDimensions.symmetric(vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CommonText.text(
                                            "Blood Pressure",
                                            fontFamily: "DM Sans",
                                            fontSize: AppDimensions.font(14),
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.primary,
                                          ),

                                          SizedBox(
                                            height: AppDimensions.height(5),
                                          ),

                                          SvgPicture.asset(
                                            AppAssets.bHeartAssets,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CommonText.text(
                                            homeController
                                                .wellnessModel
                                                .value
                                                .bloodPressure
                                                .toString(),
                                            fontFamily: "DM Sans",
                                            fontSize: AppDimensions.font(24),
                                            fontWeight: FontWeight.w700,
                                            color: HomeHalper().getBloodColor(
                                              homeController
                                                  .wellnessModel
                                                  .value
                                                  .bloodPressureStatus
                                                  .toString(),
                                            ),
                                          ),
                                          CommonText.text(
                                            "bpm",
                                            fontFamily: "DM Sans",
                                            fontSize: AppDimensions.font(14),
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.blackColor,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

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
