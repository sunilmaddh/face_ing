import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/health_data/helper/health_report_helper.dart';
import 'package:ntt_data/modules/views/health_data/widgets/vital_card_widget.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';

class AllReportScreen extends StatefulWidget {
  const AllReportScreen({super.key});

  @override
  State<AllReportScreen> createState() => _AllReportScreenState();
}

class _AllReportScreenState extends State<AllReportScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.btntext,
      appBar: CustomAppBar(
        title: "Health data report",
        onTop: () {
          AppNavigation.back();
        },
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: AppColors.historyCardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: AppDimensions.symmetric(horizontal: 8.0, vertical: 8.0),
          child: VitalCartWidget(
            allList: HealthReportHelper().minimunVitalCards,
          ),
        ),
      ),
    );
  }
}
