import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/health_data/widgets/seamless_circular_progressIndicator.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class CircleProgressCard extends StatelessWidget {
  const CircleProgressCard({
    super.key,
    this.progress = 0,
    this.maxProgress = 0,
    this.age = 0,
    this.borderColor = AppColors.btntext,
    this.drawArcColor = AppColors.btntext,
    this.size = 0.0,
    this.baseStrokeWidth = 0.0,
    this.bottomImage = "",
    this.centerImage = "",
    this.leftPadding = 30.0,
    this.value = "",
    this.mass = "",
    required this.title,
  });

  final int progress; // Current progress value
  final int maxProgress;
  final int age;
  final Color borderColor;
  final Color drawArcColor;
  final double size;
  final double baseStrokeWidth;
  final String title;
  final String bottomImage;
  final String centerImage;
  final double leftPadding;
  final String value;
  final String mass;

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      radius: AppDimensions.radius(18),
      widget: Padding(
        padding: EdgeInsets.symmetric(
          vertical: AppDimensions.height(20),
          horizontal: AppDimensions.width(20),
        ),
        child: Column(
          children: [
            CommonText.text(
              title,
              maxLines: 4,

              fontSize: AppDimensions.font(16),
              fontWeight: FontWeight.w600,
              color: AppColors.blackColor,
            ),
            // SizedBox(height: AppDimensions.height(20)),
            if (centerImage.isNotEmpty)
              Stack(
                children: [
                  SvgPicture.asset(centerImage),
                  Positioned(
                    bottom: 0,
                    left: AppDimensions.height(leftPadding),
                    child: CommonText.text(
                      value,
                      fontSize: AppDimensions.font(14),
                      fontWeight: FontWeight.w400,
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
            if (age > 0.0)
              Padding(
                padding: EdgeInsets.only(top: AppDimensions.height(30)),
                child: SeamlessCircularProgressIndicator(
                  progress: progress,
                  age: age,
                  borderColor: borderColor,
                  drawArcColor: drawArcColor,
                ),
              ),

            if (bottomImage.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonText.text(
                    value,
                    fontSize: AppDimensions.font(24),
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                  CommonText.text(
                    mass,
                    fontSize: AppDimensions.font(14),
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackColor,
                  ),
                ],
              ),

            if (bottomImage.isNotEmpty) SvgPicture.asset(bottomImage),
          ],
        ),
      ),
    );
  }
}
