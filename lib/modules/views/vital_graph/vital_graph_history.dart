import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/vital_graph/first_line_vital_widget.dart';
import 'package:ntt_data/modules/views/vital_graph/vital_graph_first_card.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';

class VitalGraphHistory extends StatelessWidget {
  const VitalGraphHistory({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onTop: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AppNavigation.back();
          });
        },
        title: "History",
      ),
      backgroundColor: AppColors.historyCardColor,
      body: Padding(
        padding: AppDimensions.only(top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: AppDimensions.symmetric(vertical: 20),
              color: AppColors.btntext,
              child: FirstLineVitalWidget(),
            ),
            VitalGraphFirstCard(),
            30.verticalSpace,
          ],
        ),
      ),
    );
  }
}
