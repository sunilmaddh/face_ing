import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/modules/views/profile/controller/profile_controller.dart';
import 'package:ntt_data/modules/views/profile/widgets/health_details_list_widget.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/bar/custom_tab_bar_view.dart';

// ignore: must_be_immutable
class UserHealthDetails extends StatelessWidget {
  UserHealthDetails({super.key});
  final _controller = Get.find<ProfileController>();

  initiateData() async {
    _controller.isFullStory.value =
        await IndoSharedPreference.instance.getHistoryType();
    if (_controller.isFullStory.isTrue) {
      _controller.tabWidget.value = [
        HealthDetailsListWidget(
          healthDetailsList: _controller.binahHIstoryDetails,
        ),
        HealthDetailsListWidget(healthDetailsList: _controller.basicVitalSigns),
        HealthDetailsListWidget(
          healthDetailsList: _controller.bloodlessBloodTests,
        ),
        HealthDetailsListWidget(healthDetailsList: _controller.risks),
        HealthDetailsListWidget(healthDetailsList: _controller.stress),
        HealthDetailsListWidget(
          healthDetailsList: _controller.heartRateVariability,
        ),
        HealthDetailsListWidget(
          healthDetailsList: _controller.advancedHeartRateVariability,
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    initiateData();
    return Scaffold(
      appBar: CustomAppBar(
        onTop: () {
          AppNavigation.back();
        },
        title: "User Health Reports",
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.historyCardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Obx(
          () =>
              _controller.isFullStory.isTrue
                  ? CustomTabBarView(
                    isNotRadius: false,
                    tabWidgets: AppMethods.tabWidgets,
                    tabBarWidgets: _controller.tabWidget,
                  )
                  : Padding(
                    padding: AppDimensions.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: HealthDetailsListWidget(
                      healthDetailsList: _controller.basicVitalSigns,
                    ),
                  ),
        ),
      ),
    );
  }
}
