import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/base/base_view.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/api_constants.dart';
import 'package:ntt_data/core/constants/app_strings.dart';
import 'package:ntt_data/core/storage/app_preferences.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/date_time_halper.dart';
import 'package:ntt_data/modules/geust/controller/geust_controller.dart';
import 'package:ntt_data/modules/profile/widgets/user_history_card.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/custom_shimmer.dart/shimmer_widget.dart';

class GuestHealthHistoryList extends BaseView<GeustController> {
  const GuestHealthHistoryList({super.key});

  String get guestId => Get.arguments[ApiConstants.guestId] ?? "";

  @override
  bool get useDefaultLoader => false;

  @override
  Widget buildView(BuildContext context, GeustController controller) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.guestHealthHistoryTitle),
      body: Obx(() {
        if (controller.isLoading.isTrue) {
          return ShimmerLoadingScreen(widget: ShimmerListItem(), itemCount: 8);
        }

        if (controller.guestHealthList.isEmpty) {
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
          itemCount: controller.guestHealthList.length,
          itemBuilder: (context, index) {
            final result = controller.guestHealthList[index];

            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: () async {
                  final isFullStory = AppPreferences.instance.getHistoryType();

                  await controller.getGeustDetails(
                    guestId,
                    result.scanId.toString(),
                    isFullStory,
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
