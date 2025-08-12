import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
// ignore: unused_import
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/screen_utils.dart';
import 'package:ntt_data/modules/views/profile/controller/profile_controller.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:html/parser.dart' as html_parser;

class VitalDescriptions extends StatelessWidget {
  VitalDescriptions({super.key});
  String vitalKey = Get.arguments["vitalKey"] ?? "";
  final _profileComtroller = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    _profileComtroller.getVitalDescryption(vitalKey: vitalKey);

    // String cleanHtml = _profileComtroller.vitalDescriptionModel.value.vitalDesc!
    //     .replaceAll(RegExp(r"src='\s+"), "src='");

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
                      : _profileComtroller.vitalDesc.isNotEmpty
                      ? Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: HtmlWidget(_profileComtroller.vitalDesc.value),
                      )
                      : SizedBox(
                        height: ScreenUtils.screenHeight,
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

  //   String cleanImageSrc(String html) {
  //     var document = html_parser.parse(html);
  //     document.getElementsByTagName('img').forEach((img) {
  //       if (img.attributes['src'] != null) {
  //         img.attributes['src'] = img.attributes['src']!.trim();
  //       }
  //     });
  //     return document.outerHtml;
  //   }
  // }
  String cleanImageSrc(String html) {
    var document = html_parser.parse(html);

    document.getElementsByTagName('img').forEach((img) {
      var src = img.attributes['src'];
      if (src != null && src.trim().isNotEmpty) {
        // Trim spaces
        src = src.trim();

        // Upgrade http to https if applicable
        if (src.startsWith('http://')) {
          src = src.replaceFirst('http://', 'https://');
        }

        img.attributes['src'] = src;
      }
    });

    return document.outerHtml;
  }
}

//   "<!DOCTYPE html> <html lang='en'> <head>   <meta charset='UTF-8'>   <title>Blood Pressure</title>   <style>     body {       font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;       line-height: 1.6;       padding: 40px;       background-color: #ffffff;       color: #333;     }      h1, h2 {       color: #2c3e50;     }      .highlight {       font-weight: bold;       color: #1a73e8;     }      ul {       margin-left: 20px;     }      .section {       margin-bottom: 30px;     }      .note {       font-style: italic;       color: #666;     }  .responsive {   width: 20%;   height: auto; }  .center {   display: block;   margin-left: auto;   margin-right: auto;   width: 50%; }   </style> </head> <body>    <h1>Blood Pressure</h1>  <div class='section'>      <p>   The pressure of blood exerted on the walls of the arteries, which carry blood from the heart to other parts of the body. Normal systolic pressure is from 100 to 129.  </p>   <img src='https://blr1.digitaloceanspaces.com/faceingrecognize234/uploads/userprofile/Blood_pressure_1.png' alt='Paris' class='center responsive' width='100' height='100'>      <div class='section'>          <p>Blood Pressure measures the pressure of circulating blood against artery walls, and it is measured by two numbers. The first number, or systolic pressure, refers to the pressure inside the artery when the heart contracts and pumps blood throughout the body. The second number, or diastolic pressure, refers to the pressure inside the artery when the heart is at rest and is filling with blood.Most people dont know if they have high Blood Pressure  especially since there may be no noticeable warning signs or symptoms  and therefore the Blood Pressure must be measured.Blood pressure changes in response to different activities and is recommended to be measured while at rest. Consistently high blood pressure readings may result in a diagnosis of high blood pressure (hypertension), which poses a higher risk for health problems such as heart disease, heart attack, and stroke. In most cases, high blood pressure has no defined cause, and it is called primary hypertension. However, it is related to unhealthy lifestyles such as physical inactivity, stressful life, obesity, shift work, pregnancy, etc. It should be emphasized that Blood Pressure can be managed through diagnosis, lifestyle changes, medication and long-term monitoring.Blood Pressure is categorized as low, normal, or elevated: low blood pressure is defined as systolic pressure of less than 100, normal blood pressure is defined as systolic pressure of 100 to 129, while elevated blood pressure is defined as systolic pressure of 130 or higher.These numbers should be used as a guide only. A single Blood Pressure measurement that is higher than normal is not necessarily an indication of a problem. Your doctor will want to see multiple Blood Pressure measurements over several days or weeks before making a diagnosis of high blood pressure and commencing treatment. </p>   </div>   </body> </html>  ";
// "<!DOCTYPE html> <html lang='en'> <head>   <meta charset='UTF-8'>   <title>Blood Pressure</title>   <style>     body {       font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;       line-height: 1.6;       padding: 40px;       background-color: #ffffff;       color: #333;     }      h1, h2 {       color: #2c3e50;     }      .highlight {       font-weight: bold;       color: #1a73e8;     }      ul {       margin-left: 20px;     }      .section {       margin-bottom: 30px;     }      .note {       font-style: italic;       color: #666;     }  .responsive {   width: 20%;   height: auto; }  .center {   display: block;   margin-left: auto;   margin-right: auto;   width: 50%; }   </style> </head> <body>    <h1>Blood Pressure</h1>  <div class='section'>      <p>   The pressure of blood exerted on the walls of the arteries, which carry blood from the heart to other parts of the body. Normal systolic pressure is from 100 to 129.  </p>   <img src='https://blr1.digitaloceanspaces.com/faceingrecognize234/uploads/userprofile/Blood_pressure_1.png' alt='Paris' class='center responsive' width='100' height='100'>      <div class='section'>          <p>Blood Pressure measures the pressure of circulating blood against artery walls, and it is measured by two numbers. The first number, or systolic pressure, refers to the pressure inside the artery when the heart contracts and pumps blood throughout the body. The second number, or diastolic pressure, refers to the pressure inside the artery when the heart is at rest and is filling with blood.Most people dont know if they have high Blood Pressure  especially since there may be no noticeable warning signs or symptoms  and therefore the Blood Pressure must be measured.Blood pressure changes in response to different activities and is recommended to be measured while at rest. Consistently high blood pressure readings may result in a diagnosis of high blood pressure (hypertension), which poses a higher risk for health problems such as heart disease, heart attack, and stroke. In most cases, high blood pressure has no defined cause, and it is called primary hypertension. However, it is related to unhealthy lifestyles such as physical inactivity, stressful life, obesity, shift work, pregnancy, etc. It should be emphasized that Blood Pressure can be managed through diagnosis, lifestyle changes, medication and long-term monitoring.Blood Pressure is categorized as low, normal, or elevated: low blood pressure is defined as systolic pressure of less than 100, normal blood pressure is defined as systolic pressure of 100 to 129, while elevated blood pressure is defined as systolic pressure of 130 or higher.These numbers should be used as a guide only. A single Blood Pressure measurement that is higher than normal is not necessarily an indication of a problem. Your doctor will want to see multiple Blood Pressure measurements over several days or weeks before making a diagnosis of high blood pressure and commencing treatment. </p>   </div>   </body> </html>  ";
// "<!DOCTYPE html> <html lang='en'> <head>   <meta charset='UTF-8'>   <title>Wellness Score</title>   <style>     body {       font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;       line-height: 1.6;       padding: 40px;       background-color: #fffff;       color: #333;     }      h1, h2 {       color: #2c3e50;     }      .highlight {       font-weight: bold;       color: #1a73e8;     }      ul {       margin-left: 20px;     }      .section {       margin-bottom: 30px;     }      .note {       font-style: italic;       color: #666;     }  .responsive {   width: 20%;   height: auto; }  .center {   display: block;   margin-left: auto;   margin-right: auto;   width: 50%; }   </style> </head> <body>    <h1>Wellness Score</h1> <img src='https://blr1.digitaloceanspaces.com/faceingrecognize234/uploads/userprofile/welness-score-1.png' alt='Paris' class='center responsive' width='100' height='100'>  <div class='section'>         <p>   The Wellness Score is a  <strong>prediction risk</strong>  score that is used to predict a person's cardiovascular risk for the next 5 to 10 years. The Wellness Score is based on the vital signs measured by our technology, and is designed to serve as a reference when measured at rest, under similar conditions during all of the measurements, and if the score is consistent in repeated measurements over time.  </p>  <p> The higher the wellness score, the lower the cardiovascular risk.   </p>      <div class='section'>     <h2>How is it calculated?</h2>     <p>Your Wellness Score is calculated using your vitals results from any single measurement. The values of each one of the vital sign measurements affect your Wellness Score prediction.</p>           <p>Generally, a lower Heart Rate at rest implies more efficient heart function and better cardiovascular fitness. Therefore, a higher Heart Rate reduces your Wellness Score - even when the heart rate is within the normal range. For example, heart rates that are higher than 65 reduce the wellness score to a  <strong>medium score</strong>  , and values that are higher than 84 reduce the wellness score to a  <strong>low score.</strong> </p> <p> HRV measures the variation in time between heartbeats. The Stress Level that is calculated from this variance also affects your Wellness Score. Thus, Very High and High stress levels are correlated with a  <strong>low score</strong> , while Mild and Normal stress levels are correlated with a  <strong>medium score</strong> . .</p> <img src='https://blr1.digitaloceanspaces.com/faceingrecognize234/uploads/userprofile/welness-score-2.png' alt='Paris' class='center responsive' width='100' height='100'> <p> Your Oxygen Saturation level measures the amount of oxygen in the blood delivered from the lungs to the rest of the body. A higher level implies a more efficient function, thus, a lower Oxygen Saturation level reduces the Wellness Score. </p>      <p> In addition, High Blood Pressure readings at rest may pose a higher risk of health problems and therefore may reduce the Wellness Score. </p>   </div>   </body> </html> ";
