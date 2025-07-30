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
import 'package:ntt_data/widgets/fields/common_text.dart';

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
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              SvgPicture.asset(AppAssets.wellnessScore),
              SizedBox(height: AppDimensions.height(34)),
              CommonText.text(
                maxLines: 100,
                textAlign: TextAlign.start,
                _profileComtroller.vitalDescriptionModel.value.vitalDesc
                    .toString(),
                // "The Wellness Score is a prediction risk score that is used to predict a person's cardiovascular risk for the next 5 to 10 years. The Wellness Score is based on the vital signs measured by our technology, and is designed to serve as a reference when measured at rest, under similar conditions during all of the measurements, and if the score is consistent in repeated measurements over time. The higher the wellness score, the lower the cardiovascular risk. How is it calculated? Your Wellness Score is calculated using your vitals results from any single measurement. The values of each one of the vital sign measurements affect your Wellness Score prediction. Generally, a lower Heart Rate at rest implies more efficient heart function and better cardiovascular fitness. Therefore, a higher Heart Rate reduces your Wellness Score - even when the heart rate is within the normal range. For example, heart rates that are higher than 65 reduce the wellness score to a medium score, and values that are higher than 84 reduce the wellness score to a low score. HRV measures the variation in time between heartbeats. The Stress Level that is calculated from this variance also affects your Wellness Score. Thus, Very High and High stress levels are correlated with a low score, while Mild and Normal stress levels are correlated with a medium score.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
