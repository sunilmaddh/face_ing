import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_strings.dart'; // ✅ added
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/binah/helper/health_report_helper.dart';
import 'package:ntt_data/modules/binah/widgets/vital_card_widget.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.btntext,
      appBar: CustomAppBar(
        title: AppStrings.healthDataReport, // ✅ updated
        onTop: () {
          AppNavigation.back();
        },
      ),
      body: Container(
        margin: const EdgeInsets.all(15.0), // ✅ const added
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
