import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/home/widgets/circle_card_widget.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class WellnessCard extends StatelessWidget {
  const WellnessCard({super.key, required this.guageValue});
  final double guageValue;

  @override
  Widget build(BuildContext context) {
    return CircleCardWidget(
      size: 215,
      widget: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonText.text(
                  "Wellness Score",
                  fontSize: AppDimensions.font(11),
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                  fontFamily: "DM Sans",
                ),
                CommonText.text(
                  guageValue.toStringAsFixed(0),
                  fontSize: AppDimensions.font(55),
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                  fontFamily: "League Spartan",
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_drop_down),
                    CommonText.text(
                      "5",
                      fontSize: AppDimensions.font(15),
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ],
                ),
                CommonText.text(
                  "From Last time",
                  fontSize: AppDimensions.font(8),
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: CircularPercentIndicator(
              radius: 102,
              lineWidth: 15,
              percent: guageValue / 10, // dynamic value
              animation: true,
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: AppColors.primary,
              backgroundColor: Colors.grey.shade200,
              center: SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
