import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_fonts.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/home/helper/home_helper.dart';
import 'package:ntt_data/modules/home/widget/circle_card_widget.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class WellnessCard extends StatelessWidget {
  const WellnessCard({
    super.key,
    required this.guageValue,
    required this.wellnessDiff,
    required this.status,
    required this.wellnessPosNeg,
  });
  final double guageValue;
  final String wellnessDiff;
  final String status;
  final String wellnessPosNeg;

  @override
  Widget build(BuildContext context) {
    debugPrint(guageValue.toString());
    debugPrint(wellnessDiff.toString());
    return CircleCardWidget(
      size: 190.w,
      widget:
          guageValue > 0.0
              ? Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CommonText.labelSmall(
                          "Wellness Score",

                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                          fontType: AppFontType.mono,
                        ),
                        Text(
                          guageValue.toStringAsFixed(0),
                          style: TextStyle(
                            fontSize: AppDimensions.font(55),
                            fontWeight: FontWeight.w700,
                            color: HomeHalper().getWellnessColor(status),
                            fontFamily: "League Spartan",
                          ),
                        ),
                        wellnessDiff != "null" && wellnessDiff != "0"
                            ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                wellnessPosNeg == "Negative"
                                    ? Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.red,
                                    )
                                    : Icon(
                                      Icons.arrow_drop_up,
                                      color: Colors.green,
                                    ),
                                CommonText.titleSmall(
                                  wellnessDiff,

                                  fontWeight: FontWeight.w600,
                                  color:
                                      wellnessPosNeg == "Negative"
                                          ? Colors.red
                                          : Colors.green,
                                ),
                              ],
                            )
                            : SizedBox.shrink(),
                        wellnessDiff != "null"
                            ? CommonText.text(
                              "From Last time",
                              style: TextStyle(
                                fontSize: AppDimensions.font(8),
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: CircularPercentIndicator(
                      radius: 91.r,
                      lineWidth: 15.w,
                      percent: guageValue / 10, // dynamic value
                      animation: true,
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: HomeHalper().getWellnessColor(status),
                      backgroundColor: Colors.grey.shade200,
                      center: SizedBox(),
                    ),
                  ),
                ],
              )
              : Center(
                child: CommonText.text("No Data", color: AppColors.primary),
              ),
    );
  }
}
