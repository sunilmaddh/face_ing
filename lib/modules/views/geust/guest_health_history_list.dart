import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/date_time_halper.dart';
import 'package:ntt_data/modules/views/geust/controller/geust_controller.dart';
import 'package:ntt_data/modules/views/profile/widgets/user_history_card.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/custom_shimmer.dart/shimmer_widget.dart';

class GuestHealthHistoryList extends StatelessWidget {
  GuestHealthHistoryList({super.key});

  final _guestController = Get.find<GeustController>();
  final String guestId = Get.arguments["guestId"] ?? "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onTop: () {
          AppNavigation.back();
        },
        title: "Guest Health History",
        // actions: [
        //   InkWell(
        //     onTap: () {
        //       AppNavigation.to(
        //         AppRoutes.vitalGraphHistory,
        //         arguments: {"guestId": guestId},
        //       );
        //     },
        //     child: Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Image.asset(
        //         AppAssets.barImage,
        //         height: AppDimensions.height(30),
        //         width: AppDimensions.width(30),
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: Obx(
        () =>
            _guestController.isLoading.isTrue
                ? ShimmerLoadingScreen(widget: ShimmerListItem(), itemCount: 8)
                : _guestController.guestHealthList.isEmpty
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
                  itemCount: _guestController.guestHealthList.length,
                  itemBuilder: (context, index) {
                    var result = _guestController.guestHealthList[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: InkWell(
                        onTap: () async {
                          var isFullStory =
                              await IndoSharedPreference.instance
                                  .getHistoryType();

                          _guestController.getGeustDetails(
                            guestId,
                            result.scanId.toString(),
                            isFullStory,
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
