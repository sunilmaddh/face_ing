import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/base/base_view.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/helper/globle_halper.dart';
import 'package:ntt_data/modules/profile/controller/profile_controller.dart';
import 'package:ntt_data/modules/profile/widgets/health_details_list_widget.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/bar/custom_tab_bar_view.dart';

class UserHealthDetails extends BaseView<ProfileController> {
  const UserHealthDetails({super.key});

  @override
  Future<void> onInit(ProfileController controller) async {
    controller.isFullStory.value =
        await IndoSharedPreference.instance.getHistoryType();

    if (controller.isFullStory.isTrue) {
      controller.tabWidget.value = [
        HealthDetailsListWidget(
          healthDetailsList: controller.binahHIstoryDetails,
        ),
        HealthDetailsListWidget(healthDetailsList: controller.basicVitalSigns),
        HealthDetailsListWidget(
          healthDetailsList: controller.bloodlessBloodTests,
        ),
        HealthDetailsListWidget(healthDetailsList: controller.risks),
        HealthDetailsListWidget(healthDetailsList: controller.stress),
        HealthDetailsListWidget(
          healthDetailsList: controller.heartRateVariability,
        ),
        HealthDetailsListWidget(
          healthDetailsList: controller.advancedHeartRateVariability,
        ),
      ];
    }
  }

  @override
  Widget buildView(BuildContext context, ProfileController controller) {
    return Scaffold(
      appBar: CustomAppBar(
        onTop: AppNavigation.back,
        title: AppConstents.userHealthReportsTitle,
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.historyCardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Obx(
          () =>
              controller.isFullStory.isTrue
                  ? CustomTabBarView(
                    isNotRadius: false,
                    tabWidgets: GlobleHalper.tabWidgets,
                    tabBarWidgets: controller.tabWidget,
                  )
                  : Padding(
                    padding: AppDimensions.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: HealthDetailsListWidget(
                      healthDetailsList: controller.basicVitalSigns,
                    ),
                  ),
        ),
      ),
    );
  }
}
