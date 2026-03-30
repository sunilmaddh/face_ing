import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/vital_graph/models/vital_graph_response_model.dart';
import 'package:ntt_data/modules/vital_graph/helper/vital_color_helper.dart';
import 'package:ntt_data/modules/vital_graph/helper/vital_graph_status.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class CommonGraphCard extends StatelessWidget {
  const CommonGraphCard({
    super.key,
    required this.widget,
    required this.vitalName,
    required this.avg,
    required this.unit,
    required this.statusList,
    this.vitalValue = "",
    required this.healthList,
  });
  final Widget widget;
  final String vitalName;
  final String vitalValue;
  final String avg;
  final String unit;
  final List<String> statusList;
  final List<HealthList> healthList;

  @override
  Widget build(BuildContext context) {
    var statusListWith = VitalGraphStatus().statusListWithColor[vitalName];
    var val = avg.isNotEmpty ? avg : vitalValue;
    Color color =
        healthList.isNotEmpty
            ? getStatusAndIsTypical(vitalName, val, healthList)
            : Colors.black12;
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
                        style: TextStyle(fontSize: 13, fontFamily: "Mulish"),
                        maxLines: 2,
                        vitalName,

                        fontWeight: FontWeight.w600,

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
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: "Mulish",
                                    ),

                                    fontWeight: FontWeight.w600,

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
              padding: EdgeInsets.only(bottom: 0),
              alignment: Alignment.center,
              child: widget,
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: AppDimensions.only(bottom: 10),
                child: Wrap(
                  alignment: WrapAlignment.start,
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
}
