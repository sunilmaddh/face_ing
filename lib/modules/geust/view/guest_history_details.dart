import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/storage/app_preferences.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/geust/controller/geust_controller.dart';
import 'package:ntt_data/modules/geust/widget/build_card_widget.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';

class GuestHistoryDetails extends StatefulWidget {
  const GuestHistoryDetails({super.key});

  @override
  State<GuestHistoryDetails> createState() => _GuestHistoryDetailsState();
}

class _GuestHistoryDetailsState extends State<GuestHistoryDetails>
    with SingleTickerProviderStateMixin {
  late final GeustController controller;
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    controller = Get.find<GeustController>();

    tabController = TabController(length: 6, vsync: this);

    _initiateData();
  }

  Future<void> _initiateData() async {
    controller.isFullStory.value =
        await AppPreferences.instance.getHistoryType();

    if (controller.isFullStory.isTrue) {
      controller.tabWidget.value = [
        BuildCardWidget(
          healthDetailsList: controller.basicVitalSigns,
          isBasicVital: true.obs,
        ),
        BuildCardWidget(
          healthDetailsList: controller.bloodlessBloodTests,
          isBasicVital: true.obs,
        ),
        BuildCardWidget(
          healthDetailsList: controller.risks,
          isBasicVital: true.obs,
        ),
        BuildCardWidget(
          healthDetailsList: controller.stress,
          isBasicVital: true.obs,
        ),
        BuildCardWidget(
          healthDetailsList: controller.heartRateVariability,
          isBasicVital: true.obs,
        ),
        BuildCardWidget(
          healthDetailsList: controller.advancedHeartRateVariability,
          isBasicVital: true.obs,
        ),
      ];

      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onTop: AppNavigation.back,
        title: "Guest Health Reports",
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.historyCardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: AppDimensions.symmetric(horizontal: 10.0, vertical: 10.0),
          child: BuildCardWidget(
            healthDetailsList: controller.basicVitalSigns,
            isBasicVital: true.obs,
          ),
        ),
      ),
    );
  }
}
