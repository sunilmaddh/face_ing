import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/dialog/bottomsheet_helper.dart';
import 'package:ntt_data/modules/views/geust/controller/geust_controller.dart';
import 'package:ntt_data/modules/views/geust/widget/build_card_widget.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/bar/custom_tab_bar_view.dart';

// ignore: must_be_immutable
class GuestHistoryDetails extends StatefulWidget {
  const GuestHistoryDetails({super.key});

  @override
  State<GuestHistoryDetails> createState() => _GuestHistoryDetailsState();
}

class _GuestHistoryDetailsState extends State<GuestHistoryDetails>
    with SingleTickerProviderStateMixin {
  final _controller = Get.find<GeustController>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    initiateData();
    _tabController = TabController(
      length: AppMethods.tabGuestWidget.length,
      vsync: this,
    );
  }

  initiateData() async {
    _controller.isFullStory.value =
        await IndoSharedPreference.instance.getHistoryType();
    if (_controller.isFullStory.isTrue) {
      _controller.tabWidget.value = [
        BuildCardWidget(
          healthDetailsList: _controller.basicVitalSigns,
          isBasicVital: true.obs,
        ),
        BuildCardWidget(
          healthDetailsList: _controller.bloodlessBloodTests,
          isBasicVital: true.obs,
        ),
        BuildCardWidget(
          healthDetailsList: _controller.risks,
          isBasicVital: true.obs,
        ),
        BuildCardWidget(
          healthDetailsList: _controller.stress,
          isBasicVital: true.obs,
        ),
        BuildCardWidget(
          healthDetailsList: _controller.heartRateVariability,
          isBasicVital: true.obs,
        ),
        BuildCardWidget(
          healthDetailsList: _controller.advancedHeartRateVariability,
          isBasicVital: true.obs,
        ),
      ];
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onTop: () => AppNavigation.back(),
        title: "Guest Health Reports",
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.historyCardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Obx(
          () =>
              _controller.isFullStory.isTrue
                  ? CustomTabBarView(
                    tabController: _tabController,
                    isNotRadius: false,
                    tabWidgets: AppMethods.tabGuestWidget,
                    tabBarWidgets: _controller.tabWidget,
                    onTabChanged: (value) {
                      // if (value > 0) {
                      //   BottomsheetHelper.showBottomSheetAlert(
                      //     context,
                      //     _tabController,
                      //   );
                      // }
                    },
                  )
                  : Padding(
                    padding: AppDimensions.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: BuildCardWidget(
                      healthDetailsList: _controller.basicVitalSigns,
                      isBasicVital: true.obs,
                    ),
                  ),
        ),
      ),
    );
  }
}
