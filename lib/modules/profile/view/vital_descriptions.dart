import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/base/base_view.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/profile/controller/profile_controller.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';

class VitalDescriptions extends BaseView<ProfileController> {
  VitalDescriptions({super.key});

  final String vitalKey = Get.arguments[AppConstents.vitalKey] ?? "";

  @override
  bool get useDefaultLoader => false;

  @override
  void onInit(ProfileController controller) {
    controller.getVitalDescryption(vitalKey: vitalKey);
  }

  @override
  Widget buildView(BuildContext context, ProfileController controller) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppConstents.vitalSignsDescriptionTitle,
        onTop: Get.back,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.historyCardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: AppDimensions.screenWidth,
          height: AppDimensions.screenHeight,
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.btntext,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Obx(() {
              if (controller.isVitalDescriptionLoading.isTrue) {
                return SizedBox(
                  height: AppDimensions.screenHeight,
                  child: const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                );
              }

              if (controller.vitalDesc.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: HtmlWidget(controller.vitalDesc.value),
                );
              }

              return SizedBox(
                height: AppDimensions.screenHeight,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    AppAssets.noDataImage,
                    alignment: Alignment.center,
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
