import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/modules/views/binah/controllers/measurement_controller.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/modules/views/health_data/helper/health_report_helper.dart';
import 'package:ntt_data/modules/views/health_data/widgets/getvitalStatus.dart';
import 'package:ntt_data/modules/views/health_data/widgets/vital_card_widget.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bar/custom_tab_bar_view.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';

// ignore: must_be_immutable
class AnalyzingHealthData extends StatefulWidget {
  const AnalyzingHealthData({super.key});

  @override
  State<AnalyzingHealthData> createState() => _AnalyzingHealthDataState();
}

class _AnalyzingHealthDataState extends State<AnalyzingHealthData>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(
      length: AppMethods.tabWidgets.length,
      vsync: this,
    );

    super.initState();
  }

  final _measurementController = Get.find<MeasurementController>();

  final statusHelper = Getvitalstatus();

  List<Widget> barWidgets = [];

  @override
  Widget build(BuildContext context) {
    barWidgets = [
      if (_measurementController.scanType.value != "add-guest" &&
          _measurementController.scanType.value != "re-scan")
        VitalCartWidget(allList: HealthReportHelper().allVitalCards),
      VitalCartWidget(allList: HealthReportHelper().basicVital),
      VitalCartWidget(allList: HealthReportHelper().bloodlessVital),
      VitalCartWidget(allList: HealthReportHelper().riskList),
      VitalCartWidget(allList: HealthReportHelper().stress),
      VitalCartWidget(allList: HealthReportHelper().hrvsddnList),
      VitalCartWidget(allList: HealthReportHelper().adhrvsddnList),
    ];
    return Scaffold(
      backgroundColor: AppColors.btntext,
      appBar: CustomAppBar(
        onTop: () {
          AppNavigation.back();
        },
        isCenterTitle: true,
        title: "Health data report",
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: AppColors.historyCardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: CustomTabBarView(
          isNotRadius: false,
          tabWidgets:
              (_measurementController.scanType.value != "add-guest" &&
                      _measurementController.scanType.value != "re-scan")
                  ? AppMethods.tabWidgets
                  : AppMethods.tabGuestWidget,
          tabBarWidgets: barWidgets,
          tabController: _tabController,
          onTabChanged: (index) {
            // if (_measurementController.scanType.value == "add-guest" ||
            //     _measurementController.scanType.value == "re-scan") {
            //   if (index > 0) {
            //     BottomsheetHelper.showBottomSheetAlert(context, _tabController);
            //   }
            // }
          },
        ),
      ),
    );
  }
}
