import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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
            // padding: const EdgeInsets.all(16),
            children: [
              Html(data: data),
              // SvgPicture.asset(AppAssets.wellnessScore),
              // SizedBox(height: AppDimensions.height(34)),
              // CommonText.text(
              //   maxLines: 100,
              //   textAlign: TextAlign.start,
              //   _profileComtroller.vitalDescriptionModel.value.vitalDesc
              //       .toString(),
              //   // "The Wellness Score is a prediction risk score that is used to predict a person's cardiovascular risk for the next 5 to 10 years. The Wellness Score is based on the vital signs measured by our technology, and is designed to serve as a reference when measured at rest, under similar conditions during all of the measurements, and if the score is consistent in repeated measurements over time. The higher the wellness score, the lower the cardiovascular risk. How is it calculated? Your Wellness Score is calculated using your vitals results from any single measurement. The values of each one of the vital sign measurements affect your Wellness Score prediction. Generally, a lower Heart Rate at rest implies more efficient heart function and better cardiovascular fitness. Therefore, a higher Heart Rate reduces your Wellness Score - even when the heart rate is within the normal range. For example, heart rates that are higher than 65 reduce the wellness score to a medium score, and values that are higher than 84 reduce the wellness score to a low score. HRV measures the variation in time between heartbeats. The Stress Level that is calculated from this variance also affects your Wellness Score. Thus, Very High and High stress levels are correlated with a low score, while Mild and Normal stress levels are correlated with a medium score.",
              // ),
            ],
          ),
        ),
      ),
    );
  }

  String data =
      "<!DOCTYPE html>\n<html lang='en'>\n<head>\n  <meta charset='UTF-8'>\n  <title>Wellness Score</title>\n  <style>\n    body {\n      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;\n      line-height: 1.6;\n      padding: 40px;\n      background-color: #f7f9fb;\n      color: #333;\n    }\n\n    h1, h2 {\n      color: #2c3e50;\n    }\n\n    .highlight {\n      font-weight: bold;\n      color: #1a73e8;\n    }\n\n    ul {\n      margin-left: 20px;\n    }\n\n    .section {\n      margin-bottom: 30px;\n    }\n\n    .note {\n      font-style: italic;\n      color: #666;\n    }\n\t\n\t<!--img {\n  display: block;\n  margin-left: auto;\n  margin-right: auto;\n  width:20%;\n  height:30%;\n} -->\n\n.responsive {\n  width: 20%;\n  height: auto;\n}\n  </style>\n</head>\n<body>\n\n  <h1>Wellness Score</h1>\n<img src='C:Users\bvinaDownloads\binah 1.png' alt='Paris' class='center responsive' width='100' height='100'>\n <div class='section'>\n  \n  \n  <p>\n  The Wellness Score is a \n<strong>prediction risk</strong>\n score that is used to predict a person's cardiovascular risk for the next 5 to 10 years. The Wellness Score is based on the vital signs measured by our technology, and is designed to serve as a reference when measured at rest, under similar conditions during all of the measurements, and if the score is consistent in repeated measurements over time.\n </p>\n <p>\nThe higher the wellness score, the lower the cardiovascular risk.\n  </p>\n  \n  <div class='section'>\n    <h2>How is it calculated?</h2>\n    <p>Your Wellness Score is calculated using your vitals results from any single measurement. The values of each one of the vital sign measurements affect your Wellness Score prediction.</p>\n  \n  \n    <p>Generally, a lower Heart Rate at rest implies more efficient heart function and better cardiovascular fitness. Therefore, a higher Heart Rate reduces your Wellness Score - even when the heart rate is within the normal range. For example, heart rates that are higher than 65 reduce the wellness score to a \n<strong>medium score</strong>\n, and values that are higher than 84 reduce the wellness score to a \n<strong>low score.</strong>\n</p>\n<p>\nHRV measures the variation in time between heartbeats. The Stress Level that is calculated from this variance also affects your Wellness Score. Thus, Very High and High stress levels are correlated with a \n<strong>low score</strong>\n, while Mild and Normal stress levels are correlated with a \n<strong>medium score</strong>\n.\n.</p>\n<img src='C:Users\bvinaDownloads\binah 2.png' alt='Paris' class='center responsive' width='100' height='100'>\n<p>\nYour Oxygen Saturation level measures the amount of oxygen in the blood delivered from the lungs to the rest of the body. A higher level implies a more efficient function, thus, a lower Oxygen Saturation level reduces the Wellness Score.\n</p>\n   \n <p>\nIn addition, High Blood Pressure readings at rest may pose a higher risk of health problems and therefore may reduce the Wellness Score.\n</p> \n\n</div>\n\n\n</body>\n</html>\n\n";
}
