import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/screen_utils.dart';
import 'package:ntt_data/modules/views/profile/controller/profile_controller.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';

// ignore: must_be_immutable
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
        decoration: BoxDecoration(
          color: AppColors.historyCardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: ScreenUtils.screenWidth,
          height: ScreenUtils.screenHeight,
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.btntext,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Obx(
              () =>
                  _profileComtroller.isVitalDescriptionLoading.isTrue
                      ? SizedBox(
                        height: ScreenUtils.screenHeight,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                      )
                      : _profileComtroller.vitalDesc.isNotEmpty
                      ? Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: HtmlWidget(_profileComtroller.vitalDesc.value),
                      )
                      : SizedBox(
                        height: ScreenUtils.screenHeight,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Image.asset(
                            AppAssets.noDataImage,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
            ),
          ),
        ),
      ),
    );
  }
}
