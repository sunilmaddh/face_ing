import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/data/models/healthDetailsResponseModel.dart';
import 'package:ntt_data/modules/views/geust/controller/geust_controller.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/bar/custom_tab_bar_view.dart';
import 'package:ntt_data/widgets/indo_sakura_common_card.dart';

// ignore: must_be_immutable
class GuestHistoryDetails extends StatelessWidget {
  GuestHistoryDetails({super.key});
  final _controller = Get.find<GeustController>();

  List<Widget> tabWidget = [];

  @override
  Widget build(BuildContext context) {
    tabWidget = [
      _buildWidget(_controller.healthDetailsList),
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
        title: "Guest Health Reports",
      ),

      body: Container(
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.historyCardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: CustomTabBarView(
          isNotRadius: false,
          tabWidgets: AppMethods.tabWidgets,
          tabBarWidgets: tabWidget,
        ),
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
              confidenceLevel: result.vitalConfidence.toString(),
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
