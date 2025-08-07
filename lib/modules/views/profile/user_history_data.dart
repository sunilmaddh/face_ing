import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/date_time_halper.dart';
import 'package:ntt_data/modules/views/profile/controller/profile_controller.dart';
import 'package:ntt_data/modules/views/profile/widgets/user_history_card.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/custom_shimmer.dart/shimmer_widget.dart';

class UserHistoryData extends StatelessWidget {
  UserHistoryData({super.key});

  final _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    _profileController.getUserHistory();
    return Scaffold(
      appBar: CustomAppBar(
        onTop: () {
          AppNavigation.back();
        },
        title: "User History",
      ),
      body: Obx(
        () =>
            _profileController.isLoading.isTrue
                ? ShimmerLoadingScreen()
                : _profileController.userHealthList.isEmpty
                ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset(
                      AppAssets.noDataImage,
                      alignment: Alignment.center,
                    ),
                  ),
                )
                : ListView.builder(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  itemCount: _profileController.userHealthList.length,
                  itemBuilder: (context, index) {
                    var result = _profileController.userHealthList[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: InkWell(
                        onTap: () async {
                          var isFullStory =
                              await IndoSharedPreference.instance
                                  .getHistoryType();

                          _profileController.getUserHealthDetails(
                            healthId: result.scanId,
                            isFullHistory: isFullStory,
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: AppDimensions.height(12.0),
                          ),
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
                ),
      ),
    );
  }
}
