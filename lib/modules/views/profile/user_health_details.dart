import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/modules/views/profile/controller/profile_controller.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/custom_shimmer.dart/shimmer_widget.dart';
import 'package:ntt_data/widgets/indo_sakura_common_card.dart';

class UserHealthDetails extends StatelessWidget {
  UserHealthDetails({super.key});
  final _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
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
              _profileController.binahHIstoryDetails.isEmpty
                  ? ShimmerLoadingScreen()
                  : ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: _profileController.binahHIstoryDetails.length,
                    itemBuilder: (context, index) {
                      var result =
                          _profileController.binahHIstoryDetails[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: IndoSakuraCommonCard(
                          isSdkType: true,
                          isLowGood: stringToBool(result.isTypeVital!),
                          vitalName: result.vitalName!,
                          vitalCondition: result.vitalRange!,
                          vitalDescription: result.vitalDescription!,
                          vitalStatus: result.vitalStatus!,
                          vitalValue: result.vitalValue!,
                          vitalHeading: result.vitalHeading!,
                          vitalMass: result.vitalUnit!,
                          vitalSubList: result.vitalSubList!,
                          onInfoTop: () {
                            AppNavigation.to(AppRoutes.vitalDescriptions);
                          },
                        ),
                      );
                    },
                  ),
          //  ListView.separated(
          //   padding: EdgeInsets.all(20),
          //   itemCount: _profileController.binahHIstoryDetails.length,
          //   itemBuilder: (context, index) {
          //     var result = _profileController.binahHIstoryDetails[index];
          //     return Padding(
          //       padding: const EdgeInsets.only(top: 10),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           CommonText.text(
          //             result["key"] ?? "",
          //             fontSize: AppDimensions.font(14),
          //             fontWeight: FontWeight.w500,
          //           ),
          //           CommonText.text(result["value"] ?? ""),
          //         ],
          //       ),
          //     );
          //   },
          //   separatorBuilder: (context, index) {
          //     return Divider(color: Color(0xffFAF7F7));
          //   },
          // ),
        ),
      ),
    );
  }

  bool stringToBool(String value) {
    return value.toLowerCase() == 'true';
  }
}
