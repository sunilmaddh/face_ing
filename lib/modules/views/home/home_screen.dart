import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/modules/views/binah/controllers/measurement_controller.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/auth/controllers/auth_controller.dart';
import 'package:ntt_data/modules/views/geust/controller/geust_controller.dart';
import 'package:ntt_data/modules/views/home/face_drawer.dart';
import 'package:ntt_data/core/utils/common_assets.dart';
import 'package:ntt_data/modules/views/home/widgets/circle_card_widget.dart';
import 'package:ntt_data/modules/views/home/widgets/menu_card.dart';
import 'package:ntt_data/modules/views/home/widgets/wellness_card.dart';
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
            top: AppDimensions.height(90),
            child: SvgPicture.asset(
              AppAssets.homeBg, // Your SVG path
              fit: BoxFit.cover, // Fill the container
            ),
          ),
          SafeArea(
            child: Padding(
              padding: AppDimensions.symmetric(horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Top AppBar Row
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        // Drawer Icon
                        InkWell(
                          onTap: () {
                            _scaffoldKey.currentState!.openDrawer();
                          },
                          child: CommonAssets.svgAsset(
                            AppAssets.person,
                            width: AppDimensions.width(40),
                            height: AppDimensions.height(40),
                          ),
                        ),
                        const Spacer(),
                        // Logo in center
                        CommonAssets.svgAsset(AppAssets.logo),
                        const Spacer(flex: 2),
                      ],
                    ),
                  ),
                  SizedBox(height: AppDimensions.height(30)),
                  WellnessCard(guageValue: 7),
                  SizedBox(height: AppDimensions.height(30)),
                  CommonCard(
                    widget: SizedBox(
                      width: Get.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          15.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              MenuCard(
                                menuTitle: "Pulse Survey",
                                image: AppAssets.pulseServe,
                              ),
                              15.horizontalSpace,
                              MenuCard(
                                menuTitle: "Voice Scan",
                                image: AppAssets.voiceScan,
                              ),
                            ],
                          ),
                          Padding(
                            padding: AppDimensions.symmetric(
                              horizontal: 15.0,
                              vertical: 15.0,
                            ),
                            child: CommonCard(
                              color: AppColors.homeCardColor,
                              widget: SizedBox(
                                height: AppDimensions.height(71),
                                width: Get.width,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
