import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/binah/measurement_controller.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/storage/storage_helper.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/common_assets.dart';
import 'package:ntt_data/data/repository/services/native_caller_services.dart'
    show NativeCaller;
import 'package:ntt_data/modules/views/auth/auth_controller.dart';
import 'package:ntt_data/modules/views/geust/controller/geust_controller.dart';
import 'package:ntt_data/modules/views/home/face_drawer.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/button/scan_button.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = Get.find<MeasurementController>();
  final gcontroller = Get.find<GeustController>();
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: FaceDrawer(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.width(10.0),
            vertical: AppDimensions.width(30.0),
          ),
          child: ListView(
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
                        AppAssets.faceLogo,
                      ), // Keeps in the center
                    ),
                  ),
                  Expanded(child: SizedBox()), // Balancing the layout
                ],
              ),

              SizedBox(height: AppDimensions.height(30)),
              CommonAssets.svgAsset(AppAssets.scanIllustration),
              SizedBox(height: AppDimensions.height(30)),
              CommonText.text(
                AppConstents.scanDiscri,
                fontSize: AppDimensions.font(18),
                fontWeight: FontWeight.w500,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppDimensions.height(75)),
              Obx(
                () => ScanButton(
                  isLoading: gcontroller.isLoading.value,
                  width: AppDimensions.height(230),

                  onPressed: () async {
                    gcontroller.isLoading.value = true;

                    var result =
                        authController
                            .loginResponseModel
                            .value
                            .commonUserDetailsDao;

                    DateTime parsedDate = DateTime.parse(
                      result!.userDob!.replaceAll("/", "-"),
                    );
                    double age =
                        gcontroller.calculateAge(parsedDate).toDouble();

                    double weight = double.parse(result.userWeight!);
                    double height = double.parse(result.userHeight!);

                    // var userID = await StorageHelper.read("userID");
                    // var accessToken = await StorageHelper.read("access-token");
                    // Map<String, dynamic> data = {
                    //   "userId": userID,
                    //   "token": accessToken,
                    //   "scanType": "user",
                    // };
                    controller.isMeasurementCanceled.value = false;
                    Future.delayed(Duration(seconds: 2), () {
                      gcontroller.isLoading.value = false;

                      debugPrint(
                        "User data $weight ,$height, ${result.userGender},$age",
                      );

                      // NativeCaller.startFaceScan(data);
                      controller
                          .screenInFocus(
                            result.userGender ?? "",
                            age,
                            weight,
                            height,
                          )
                          .whenComplete(() {
                            AppNavigation.to(
                              AppRoutes.mesurementScreen,
                              arguments: {"scanType": "user"},
                            );
                          });
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
