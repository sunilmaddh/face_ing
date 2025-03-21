import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/common_assets.dart';
import 'package:ntt_data/modules/views/health_data/additional_screen.dart';
import 'package:ntt_data/modules/views/health_data/all_report_screen.dart';
import 'package:ntt_data/widgets/bar/custom_tab_bar_view.dart';
import 'package:ntt_data/modules/views/health_data/vital_screen.dart';
import 'package:ntt_data/modules/views/health_data/wellness_screen.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';

// ignore: must_be_immutable
class AnalyzingHealthData extends StatelessWidget {
   AnalyzingHealthData({super.key});

  List<Widget> tabWidgets=[Tab(text: "All",),
                  Tab(text: "Vitals"),
                  Tab(text: "Wellness"),
                  Tab(text: "Additional"),];
                   List<Widget> barWidgets=[ AllReportScreen(),
                  VitalScreen(),
                  WellnessScreen(),
                  AdditionalScreen(),];
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(
      isCenterTitle: false,
      title: "Analyzing health data",textColor: AppColors.blackColor,actions: [Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: CommonAssets.svgAsset(AppAssets.downloadIcon),
      )],),
    body: CustomTabBarView(tabBarWidgets: barWidgets,tabWidgets: tabWidgets,),
    );
  }
}