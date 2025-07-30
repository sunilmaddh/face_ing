import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
// ignore: unused_import
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/screen_utils.dart';
import 'package:ntt_data/modules/views/profile/controller/profile_controller.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';

class VitalDescriptions extends StatelessWidget {
  VitalDescriptions({super.key});

  final _profileComtroller = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    _profileComtroller.getVitalDescryption();
    return Scaffold(
      appBar: CustomAppBar(title: "Vital Signs Description", onTop: () {}),
      body: Container(
        // margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.historyCardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: ScreenUtils.screenWidth,
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.btntext,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(children: [SvgPicture.asset(AppAssets.wellnessScore)]),
        ),
      ),
    );
  }
}
