import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart' show AppColors;
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/profile/controller/profile_controller.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/custom_shimmer.dart/shimmer_widget.dart';

import '../../../widgets/fields/common_text.dart';

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
        title: "User History list",
      ),
      body: Obx(
        () =>
            _profileController.userHealthList.isEmpty
                ? ShimmerLoadingScreen()
                : ListView.separated(
                  padding: EdgeInsets.all(20),
                  itemCount: _profileController.userHealthList.length,
                  itemBuilder: (context, index) {
                    var result = _profileController.userHealthList[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: InkWell(
                        onTap: () {
                          _profileController.getUserHealthDetails(
                            healthId: result.scanId,
                            isFullHistory: true,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText.text(
                                  AppConstents.scanId,
                                  fontSize: AppDimensions.font(14),
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primary,
                                ),
                                CommonText.text(
                                  result.scanId!,
                                  // result["value"]
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText.text(
                                  AppConstents.dateTime,
                                  fontSize: AppDimensions.font(14),
                                  fontWeight: FontWeight.w500,
                                ),
                                CommonText.text(
                                  result.dateOfScan!,
                                  // result["value"]
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(color: Color(0xffFAF7F7));
                  },
                ),

        // ListView.builder(

        //   },
        // ),
      ),
    );
  }
}
