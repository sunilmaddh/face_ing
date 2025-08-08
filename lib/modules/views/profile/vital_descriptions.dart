import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
// ignore: unused_import
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/screen_utils.dart';
import 'package:ntt_data/modules/views/profile/controller/profile_controller.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';

class VitalDescriptions extends StatelessWidget {
  VitalDescriptions({super.key});
  String vitalKey = Get.arguments["vitalKey"] ?? "";
  final _profileComtroller = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    _profileComtroller.getVitalDescryption(vitalKey: vitalKey);
    return Scaffold(
      appBar: CustomAppBar(
        title: "Vital Signs Description",
        onTop: () {
          Get.back();
        },
      ),
      body: Container(
        // margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.historyCardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: ScreenUtils.screenWidth,
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.btntext,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              // padding: const EdgeInsets.all(16),
              children: [
                Obx(
                  () =>
                      _profileComtroller.isVitalDescriptionLoading.isFalse
                          ? Flexible(
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            ),
                          )
                          : _profileComtroller
                              .vitalDescriptionModel
                              .value
                              .vitalDesc!
                              .isNotEmpty
                          ? Html(
                            data:
                                _profileComtroller
                                    .vitalDescriptionModel
                                    .value
                                    .vitalDesc,
                          )
                          : Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Image.asset(
                                AppAssets.noDataImage,
                                alignment: Alignment.center,
                              ),
                            ),
                          ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
