import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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
  String vitalKey = Get.arguments["vitalKey"] ?? "";
  final _profileComtroller = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    _profileComtroller.getVitalDescryption(vitalKey: vitalKey);

    String cleanHtml = _profileComtroller.vitalDescriptionModel.value.vitalDesc!
        .replaceAll(RegExp(r"src='\s+"), "src='");

    return Scaffold(
      appBar: CustomAppBar(
        title: "Vital Signs Description",
        onTop: () {
          Get.back();
        },
      ),
      body: Container(
        // margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.historyCardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          // alignment: Alignment.center,
          width: ScreenUtils.screenWidth,
          height: ScreenUtils.screenHeight,
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.btntext,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Obx(
              () =>
                  _profileComtroller.isVitalDescriptionLoading.isTrue
                      ? SizedBox(
                        height: ScreenUtils.screenHeight,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                      )
                      : _profileComtroller
                          .vitalDescriptionModel
                          .value
                          .vitalDesc!
                          .isNotEmpty
                      ? Html(
                        data: cleanImageSrc(
                          _profileComtroller
                              .vitalDescriptionModel
                              .value
                              .vitalDesc!,
                        ),
                      )
                      : Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Image.asset(
                            AppAssets.noDataImage,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
            ),
          ),
        ),
      ),
    );
  }
}

String cleanImageSrc(String html) {
  final pattern = '(<img\\b[^>]*?\\bsrc\\s*=\\s*)([\'"]?)\\s*(.*?)\\s*([\'"]?)';
  final imgTagRegex = RegExp(pattern, caseSensitive: false, dotAll: true);

  return html.replaceAllMapped(imgTagRegex, (match) {
    final beforeSrc = match.group(1) ?? ''; // <img ... src=
    final quote = match.group(2) ?? ''; // ' or "
    final url = match.group(3)?.trim() ?? ''; // Remove spaces
    return '$beforeSrc$quote$url$quote';
  });
}

String _cleanImageSrc(String html) {
  final pattern = '(<img\\b[^>]*?\\bsrc\\s*=\\s*)([\'"]?)\\s*(.*?)\\s*([\'"]?)';

  return html.replaceAllMapped(
    RegExp(pattern, caseSensitive: false, dotAll: true),
    (match) {
      final prefix = match.group(1) ?? '';
      final quote =
          (match.group(2)?.isNotEmpty == true) ? match.group(2)! : '"';
      final src = (match.group(3) ?? '').trim();
      final closingQuote =
          (match.group(4)?.isNotEmpty == true) ? match.group(4)! : quote;
      return '$prefix$quote$src$closingQuote';
    },
  );
}

String data =
    "<!DOCTYPE html> <html lang='en'> <head>   <meta charset='UTF-8'>   <title>Wellness Score</title>   <style>     body {       font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;       line-height: 1.6;       padding: 40px;       background-color: #fffff;       color: #333;     }      h1, h2 {       color: #2c3e50;     }      .highlight {       font-weight: bold;       color: #1a73e8;     }      ul {       margin-left: 20px;     }      .section {       margin-bottom: 30px;     }      .note {       font-style: italic;       color: #666;     }  .responsive {   width: 20%;   height: auto; }  .center {   display: block;   margin-left: auto;   margin-right: auto;   width: 50%; }   </style> </head> <body>    <h1>Wellness Score</h1> <img src='https://blr1.digitaloceanspaces.com/faceingrecognize234/uploads/userprofile/welness-score-1.png' alt='Paris' class='center responsive' width='100' height='100'>  <div class='section'>         <p>   The Wellness Score is a  <strong>prediction risk</strong>  score that is used to predict a person's cardiovascular risk for the next 5 to 10 years. The Wellness Score is based on the vital signs measured by our technology, and is designed to serve as a reference when measured at rest, under similar conditions during all of the measurements, and if the score is consistent in repeated measurements over time.  </p>  <p> The higher the wellness score, the lower the cardiovascular risk.   </p>      <div class='section'>     <h2>How is it calculated?</h2>     <p>Your Wellness Score is calculated using your vitals results from any single measurement. The values of each one of the vital sign measurements affect your Wellness Score prediction.</p>           <p>Generally, a lower Heart Rate at rest implies more efficient heart function and better cardiovascular fitness. Therefore, a higher Heart Rate reduces your Wellness Score - even when the heart rate is within the normal range. For example, heart rates that are higher than 65 reduce the wellness score to a  <strong>medium score</strong>  , and values that are higher than 84 reduce the wellness score to a  <strong>low score.</strong> </p> <p> HRV measures the variation in time between heartbeats. The Stress Level that is calculated from this variance also affects your Wellness Score. Thus, Very High and High stress levels are correlated with a  <strong>low score</strong> , while Mild and Normal stress levels are correlated with a  <strong>medium score</strong> . .</p> <img src='https://blr1.digitaloceanspaces.com/faceingrecognize234/uploads/userprofile/welness-score-2.png' alt='Paris' class='center responsive' width='100' height='100'> <p> Your Oxygen Saturation level measures the amount of oxygen in the blood delivered from the lungs to the rest of the body. A higher level implies a more efficient function, thus, a lower Oxygen Saturation level reduces the Wellness Score. </p>      <p> In addition, High Blood Pressure readings at rest may pose a higher risk of health problems and therefore may reduce the Wellness Score. </p>   </div>   </body> </html> ";
