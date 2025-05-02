import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({
    super.key,
    this.width = 143,
    required this.title,
    this.value = "",
    this.mass = "",
    this.image = "",
    this.isCenter = false,
  });
  final String title;
  final String value;
  final String mass;
  final String image;
  final double width;
  final bool isCenter;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimensions.width(width),
      child: CommonCard(
        radius: AppDimensions.radius(18),
        widget: Padding(
          padding: EdgeInsets.only(top: AppDimensions.height(10)),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment:
                    isCenter == false
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                children: [
                  CommonText.text(
                    maxLines: 2,
                    title,
                    fontSize: AppDimensions.font(16),
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                  ),

                  SizedBox(height: AppDimensions.height(20)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
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
                ],
              ),
              SizedBox(height: 20.h),
              image.isNotEmpty
                  ? Container(
                    padding: EdgeInsets.only(top: 100),
                    width: AppDimensions.width(width),
                    height: 150,
                    alignment: Alignment.bottomCenter,
                    child: SvgPicture.asset(image, fit: BoxFit.contain),
                  )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
