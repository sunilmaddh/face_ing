import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/base/base_view.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/api_constants.dart';
import 'package:ntt_data/core/constants/app_strings.dart';
import 'package:ntt_data/core/storage/app_preferences.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/date_time_halper.dart';
import 'package:ntt_data/modules/profile/controller/profile_controller.dart';
import 'package:ntt_data/modules/profile/widgets/user_history_card.dart';
import 'package:ntt_data/modules/vital_graph/controller/vital_graph_controller.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/custom_shimmer.dart/shimmer_widget.dart';

class UserHistoryData extends BaseView<ProfileController> {
  UserHistoryData({super.key});

  final VitalGraphController _vitalGraphController =
      Get.find<VitalGraphController>();

  @override
  bool get useDefaultLoader => false;

  @override
  void onInit(ProfileController controller) {
    controller.getUserHistory();
  }

  @override
  Widget buildView(BuildContext context, ProfileController controller) {
    return Scaffold(
      appBar: CustomAppBar(
        onTop: AppNavigation.back,
        title: AppStrings.userHistoryTitle,
        actions: [
          InkWell(
            onTap: () {
              _vitalGraphController.selectedIndex.value = 0;
              AppNavigation.to(
                AppRoutes.vitalGraphHistory,
                arguments: {ApiConstants.guestId: ""},
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                AppAssets.barImage,
                height: AppDimensions.height(30),
                width: AppDimensions.width(30),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.isTrue) {
          return ShimmerLoadingScreen(widget: ShimmerListItem(), itemCount: 8);
        }

        if (controller.userHealthList.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                AppAssets.noDataImage,
                alignment: Alignment.center,
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: controller.userHealthList.length,
          itemBuilder: (context, index) {
            final result = controller.userHealthList[index];

            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: () async {
                  final isFullStory = AppPreferences.instance.getHistoryType();

                  controller.getUserHealthDetails(
                    healthId: result.scanId,
                    isFullHistory: isFullStory,
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: AppDimensions.height(12.0)),
                  child: UserHistoryCard(
                    scanId: result.scanId!,
                    dateTime: DateTimeHelper.formatUtcToLocal(
                      result.dateOfScan.toString(),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
