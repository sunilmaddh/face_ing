import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/common_assets.dart';
import 'package:ntt_data/modules/views/binah/controllers/measurement_controller.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/auth/controllers/auth_controller.dart';
import 'package:ntt_data/modules/views/geust/controller/geust_controller.dart';
import 'package:ntt_data/modules/views/home/face_drawer.dart';
import 'package:ntt_data/modules/views/home/widgets/daily_advice_card_widget.dart';
import 'package:ntt_data/modules/views/home/widgets/menu_card.dart';
import 'package:ntt_data/modules/views/home/widgets/wellness_card.dart';
import 'package:ntt_data/modules/views/profile/controller/profile_controller.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = Get.find<MeasurementController>();
  final gcontroller = Get.find<GeustController>();
  final authController = Get.find<AuthController>();
  final _profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    authController.initializedData();
  }

  @override
  Widget build(BuildContext context) {
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

                  WellnessCard(guageValue: 7),

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
                                    AppNavigation.to(
                                      AppRoutes.pulseSurveyScreen,
                                    );
                                  },
                                  child: MenuCard(
                                    menuTitle: "Pulse Survey",
                                    image: AppAssets.pulseServe,
                                  ),
                                ),
                                MenuCard(
                                  menuTitle: "Voice Scan",
                                  image: AppAssets.voiceScan,
                                ),
                              ],
                            ),
                            SizedBox(height: AppDimensions.height(15)),
                            CommonCard(
                              color: AppColors.homeCardColor,
                              widget: SizedBox(
                                height: AppDimensions.height(71),
                                width: Get.width,
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
