import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
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
  List<Widget> tabWidget = [];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: AppMethods.tabGuestWidget.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    tabWidget = [
      BuildCardWidget(healthDetailsList: _controller.basicVitalSigns),
      BuildCardWidget(healthDetailsList: _controller.bloodlessBloodTests),
      BuildCardWidget(healthDetailsList: _controller.risks),
      BuildCardWidget(healthDetailsList: _controller.stress),
      BuildCardWidget(healthDetailsList: _controller.heartRateVariability),
      BuildCardWidget(
        healthDetailsList: _controller.advancedHeartRateVariability,
      ),
    ];

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
        child: CustomTabBarView(
          tabController: _tabController,
          isNotRadius: false,
          tabWidgets: AppMethods.tabGuestWidget,
          tabBarWidgets: tabWidget,
          onTabChanged: (value) {
            if (value > 0) {
              BottomsheetHelper.showBottomSheetAlert(context, _tabController);
            }
          },
        ),
      ),
    );
  }
}
