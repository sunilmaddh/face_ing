import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/data/models/healthDetailsResponseModel.dart';
import 'package:ntt_data/modules/views/profile/controller/profile_controller.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/bar/custom_tab_bar_view.dart';
import 'package:ntt_data/widgets/custom_shimmer.dart/shimmer_widget.dart';
import 'package:ntt_data/widgets/indo_sakura_common_card.dart';

class UserHealthDetails extends StatelessWidget {
  UserHealthDetails({super.key});
  final _controller = Get.find<ProfileController>();
  List<Widget> tabWidget = [];
  @override
  Widget build(BuildContext context) {
    tabWidget = [
      _buildWidget(_controller.binahHIstoryDetails),
      _buildWidget(_controller.basicVitalSigns),
      _buildWidget(_controller.bloodlessBloodTests),
      _buildWidget(_controller.risks),
      _buildWidget(_controller.stress),
      _buildWidget(_controller.heartRateVariability),
      _buildWidget(_controller.advancedHeartRateVariability),
    ];
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
        child: CustomTabBarView(
          isNotRadius: false,
          tabWidgets: AppMethods().tabWidgets,
          tabBarWidgets: tabWidget,
        ),

        //  Obx(
        //   () =>
        //       _profileController.binahHIstoryDetails.isEmpty
        //           ? ShimmerLoadingScreen()
        //           : ListView.builder(
        //             padding: EdgeInsets.all(10),
        //             itemCount: _profileController.binahHIstoryDetails.length,
        //             itemBuilder: (context, index) {
        //               var result =
        //                   _profileController.binahHIstoryDetails[index];

        //               return Padding(
        //                 padding: const EdgeInsets.only(bottom: 10),
        //                 child: IndoSakuraCommonCard(
        //                   isSdkType: true,
        //                   isLowGood: stringToBool(result.isTypeVital!),
        //                   vitalName: result.vitalName!,
        //                   vitalCondition: result.vitalRange!,
        //                   vitalDescription: result.vitalDescription!,
        //                   vitalStatus: result.vitalStatus!,
        //                   vitalValue: result.vitalValue!,
        //                   vitalHeading: result.vitalHeading!,
        //                   vitalMass: result.vitalUnit!,
        //                   vitalSubList: result.vitalSubList!,
        //                 ),
        //               );
        //             },
        //           ),
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
        // ),
      ),
    );
  }

  _buildWidget(List<HealthDetailList> healthDetailsList) {
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        // padding: EdgeInsets.all(10),
        itemCount: healthDetailsList.length,
        itemBuilder: (context, index) {
          var result = healthDetailsList[index];
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
                AppNavigation.to(
                  AppRoutes.vitalDescriptions,
                  arguments: {"vitalKey": result.vitalKey},
                );
              },
            ),
          );
        },
      ),
    );
  }

  bool stringToBool(String value) {
    return value.toLowerCase() == 'true';
  }
}
