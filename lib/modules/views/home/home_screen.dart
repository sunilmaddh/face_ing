import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/modules/views/binah/controllers/measurement_controller.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/common_assets.dart';
import 'package:ntt_data/modules/views/auth/controllers/auth_controller.dart';
import 'package:ntt_data/modules/views/geust/controller/geust_controller.dart';
import 'package:ntt_data/modules/views/home/face_drawer.dart';
import 'package:ntt_data/modules/views/home/halper/home_halper.dart';
import 'package:ntt_data/widgets/button/scan_button.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

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
    authController.initializedData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: FaceDrawer(),
      body: PopScope(
        canPop: false,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.width(10.0),
              vertical: AppDimensions.width(30.0),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(
                        () => Center(
                          child: ScanButton(
                            isLoading: gcontroller.isHomeLoading.value,
                            width: AppDimensions.width(230),
                            onPressed: () async {
                              HomeHalper().callMeasurement();
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: AppDimensions.height(15)),
                      CommonText.text(
                        "Note: ${AppConstents.notDiscription}",
                        fontSize: AppDimensions.font(12),
                        fontWeight: FontWeight.w500,
                        maxLines: 2,
                        color: Colors.grey,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Column(
                  // physics: NeverScrollableScrollPhysics(),
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: () {
                                _scaffoldKey.currentState!.openDrawer();
                              },
                              child: CommonAssets.svgAsset(
                                AppAssets.homeMenu,
                                width: AppDimensions.width(60),
                                height: AppDimensions.height(60),
                              ),
                            ), // Keeps at the start
                          ),
                        ),
                        Expanded(
                          flex: 2, // More space for centering
                          child: Align(
                            alignment: Alignment.center,
                            child: CommonAssets.svgAsset(
                              AppAssets.logo,
                            ), // Keeps in the center
                          ),
                        ),
                        Expanded(child: SizedBox()), // Balancing the layout
                      ],
                    ),
                    SizedBox(height: AppDimensions.height(30)),
                    CommonAssets.svgAsset(AppAssets.scanIllustration),
                    SizedBox(height: AppDimensions.height(40)),
                    CommonText.text(
                      AppConstents.scanDiscri,
                      fontSize: AppDimensions.font(18),
                      fontWeight: FontWeight.w500,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: AppDimensions.height(40)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
