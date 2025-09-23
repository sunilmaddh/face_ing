import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/data/models/vital_graph_response_model.dart';
import 'package:ntt_data/modules/views/vital_graph/helper/vital_color_helper.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class CommonGraphCard extends StatelessWidget {
  CommonGraphCard({
    super.key,
    required this.widget,
    required this.vitalName,
    required this.avg,
    required this.unit,
    required this.statusList,
    this.vitalValue = "",
    required this.healthList,
    // required this.isVitalType,
  });
  final Widget widget;
  final String vitalName;
  final String vitalValue;
  final String avg;
  final String unit;
  final List<String> statusList;
  final List<HealthList> healthList;
  //  final String isVitalType;
  @override
  Widget build(BuildContext context) {
    var statusListWith = statusListWithColor[vitalName];
    var val = avg.isNotEmpty ? avg : vitalValue;
    Color color = getStatusAndIsTypical(vitalName, val, healthList);
    return CommonCard(
      isBorder: true,
      radius: 12.0,
      widget: Padding(
        padding: AppDimensions.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(6.0),
                    // margin: EdgeInsets.symmetric(horizontal: 15),
                    width: 37.85,
                    height: 37.85,
                    decoration: BoxDecoration(
                      color: Color(0xffFBF0F3),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: SvgPicture.asset(
                      "assets/images/svg/pulse_graph.svg",
                    ),
                  ),
                ),
                8.horizontalSpace,
                Flexible(
                  flex: 7,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CommonText.text(
                        maxLines: 2,
                        vitalName,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Mulish",
                        color: Color(0xff616161),
                      ),

                      vitalValue.isNotEmpty
                          ? RichText(
                            text: TextSpan(
                              text: val,
                              style: TextStyle(
                                color: color,
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Mulish",
                              ),
                              children: [
                                TextSpan(
                                  text: "  $unit",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Mulish",
                                    color: Color(0xff616161),
                                  ),
                                ),
                              ],
                            ),
                          )
                          : Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              avg.isNotEmpty
                                  ? CommonText.text(
                                    "Avg:",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Mulish",
                                    color: Color(0xff818181),
                                  )
                                  : SizedBox(),
                              avg.isNotEmpty
                                  ? SizedBox(width: AppDimensions.width(10))
                                  : SizedBox(width: AppDimensions.width(30)),

                              RichText(
                                text: TextSpan(
                                  text: val,
                                  style: TextStyle(
                                    color: color,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Mulish",
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "  $unit",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Mulish",
                                        color: Color(0xff616161),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                    ],
                  ),
                ),
              ],
            ),

            Container(
              margin: AppDimensions.all(8.0),
              alignment: Alignment.center,
              child: widget,
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: AppDimensions.only(bottom: 10),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  direction: Axis.horizontal,
                  spacing: 10,
                  runSpacing: 3,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runAlignment: WrapAlignment.center,
                  children:
                      statusListWith != null
                          ? statusListWith.map((v) {
                            return SizedBox(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    radius: 5.5,
                                    backgroundColor: v.color,
                                  ),
                                  4.horizontalSpace,

                                  Text(
                                    v.status,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: v.color,
                                      fontFamily: "Mulish",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList()
                          : [],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool stringToBool(String value) {
    return value.toLowerCase() == 'true';
  }

  final Map<String, List<StatusListColor>> statusListWithColor = {
    "Wellness Score": [
      StatusListColor(status: "Low", color: Color(0xffFA704E)),
      StatusListColor(status: "Medium", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xff1BC76D)),
    ],
    "Breathing Rate": [
      StatusListColor(status: "Low", color: Color(0xffEEC000)),
      StatusListColor(status: "Normal", color: Color(0xff1BC76D)),
      StatusListColor(status: "High", color: Color(0xffEEC000)),
    ],
    "Heart Rate": [
      StatusListColor(status: "Low", color: Color(0xffEEC000)),
      StatusListColor(status: "Normal", color: Color(0xff1BC76D)),
      StatusListColor(status: "High", color: Color(0xffEEC000)),
    ],
    "PRQ": [
      StatusListColor(status: "Low", color: Color(0xffEEC000)),
      StatusListColor(status: "Normal", color: Color(0xff1BC76D)),
      StatusListColor(status: "High", color: Color(0xffEEC000)),
    ],
    "Blood Pressure Systolic": [
      StatusListColor(status: "Low", color: Color(0xffEEC000)),
      StatusListColor(status: "Normal", color: Color(0xff1BC76D)),
      StatusListColor(status: "High", color: Color(0xffFA704E)),
    ],
    "Blood Pressure Daistolic": [
      StatusListColor(status: "Low", color: Color(0xffEEC000)),
      StatusListColor(status: "Normal", color: Color(0xff1BC76D)),
      StatusListColor(status: "High", color: Color(0xffFA704E)),
    ],
    "Oxygen Saturation": [
      StatusListColor(status: "Low", color: Color(0xffFA704E)),
      StatusListColor(status: "Normal", color: Color(0xff1BC76D)),
    ],
    "Hemoglobin": [
      StatusListColor(status: "Low", color: Color(0xffEEC000)),
      StatusListColor(status: "Normal", color: Color(0xff1BC76D)),
      StatusListColor(status: "High", color: Color(0xffEEC000)),
    ],
    "Hemoglobin A1C": [
      StatusListColor(status: "Normal", color: Color(0xff1BC76D)),
      StatusListColor(status: "Prediabetes risk", color: Color(0xffEEC000)),
      StatusListColor(status: "Diabetes risk", color: Color(0xffFA704E)),
    ],
    "ASCVD Risk": [
      StatusListColor(status: "Low", color: Color(0xff1BC76D)),
      StatusListColor(status: "Normal", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xffFA704E)),
    ],
    "High Blood Pressure Risk": [
      StatusListColor(status: "Low", color: Color(0xff1BC76D)),
      StatusListColor(status: "Medium", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xffFA704E)),
    ],
    "High HbA1c Risk": [
      StatusListColor(status: "Low", color: Color(0xff1BC76D)),
      StatusListColor(status: "Medium", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xffFA704E)),
    ],
    "High Fasting Glucose Risk": [
      StatusListColor(status: "Low", color: Color(0xff1BC76D)),
      StatusListColor(status: "High", color: Color(0xffFA704E)),
    ],
    "High Total Cholesterol Risk": [
      StatusListColor(status: "Low", color: Color(0xff1BC76D)),
      StatusListColor(status: "Medium", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xffFA704E)),
    ],
    "Low Hemoglobin Risk": [
      StatusListColor(status: "Low", color: Color(0xff1BC76D)),

      StatusListColor(status: "High", color: Color(0xffFA704E)),
    ],
    "Stress Level": [
      StatusListColor(status: "Low", color: Color(0xff1BC76D)),
      StatusListColor(status: "Normal", color: Color(0xff9ED042)),
      StatusListColor(status: "Mild", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xffED9A33)),
      StatusListColor(status: "Very High", color: Color(0xffFA704E)),
    ],
    "Recovery Ability (PNS Zone)": [
      StatusListColor(status: "Low", color: Color(0xffFA704E)),
      StatusListColor(status: "Normal", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xff1BC76D)),
    ],
    "Stress Response (SNS Zone)": [
      StatusListColor(status: "Low", color: Color(0xff1BC76D)),
      StatusListColor(status: "Normal", color: Color(0xffEEC000)),

      StatusListColor(status: "High", color: Color(0xffFA704E)),
    ],
    "Normalized Stress Index ": [
      StatusListColor(status: "Low", color: Color(0xff1BC76D)),
      StatusListColor(status: "Normal", color: Color(0xff9ED042)),
      StatusListColor(status: "Mild", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xffED9A33)),
      StatusListColor(status: "Very High", color: Color(0xffFA704E)),
    ],
    "Baesky Stress Index ": [
      StatusListColor(status: "Low", color: Color(0xff1BC76D)),
      StatusListColor(status: "Normal", color: Color(0xff9ED042)),
      StatusListColor(status: "Mild", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xffED9A33)),
      StatusListColor(status: "Very High", color: Color(0xffFA704E)),
    ],
    "Mean RRi": [
      StatusListColor(status: "Low", color: Color(0xffFA704E)),
      StatusListColor(status: "Normal", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xff1BC76D)),
    ],
    "RMSSD": [
      StatusListColor(status: "Low", color: Color(0xffFA704E)),
      StatusListColor(status: "Normal", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xff1BC76D)),
    ],
    "HRV SDNN": [
      StatusListColor(status: "Low", color: Color(0xffFA704E)),
      StatusListColor(status: "Normal", color: Color(0xff1BC76D)),
    ],
    "PNS Index": [
      StatusListColor(status: "Low", color: Color(0xffFA704E)),
      StatusListColor(status: "Normal", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xff1BC76D)),
    ],
    "SNS Index": [
      StatusListColor(status: "Low", color: Color(0xff1BC76D)),
      StatusListColor(status: "Normal", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xffFA704E)),
    ],
    "SD1": [
      StatusListColor(status: "Low", color: Color(0xffFA704E)),
      StatusListColor(status: "Normal", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xff1BC76D)),
    ],
    "SD2": [
      StatusListColor(status: "Low", color: Color(0xff1BC76D)),
      StatusListColor(status: "Normal", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xffFA704E)),
    ],
  };
}

class StatusListColor {
  final String status;
  final Color color;
  StatusListColor({required this.status, required this.color});
}
