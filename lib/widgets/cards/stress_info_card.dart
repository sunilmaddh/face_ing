import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/extentions.dart';
import 'package:ntt_data/widgets/bottom_sheet/custom_bottom_sheet.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class StressInfoCard extends StatelessWidget {
  final String vitalName;
  final bool isExpanded;
  final String titleText;
  final String statusText;
  final String valueText;
  final String unitText;
  final String imageAsset;
  final String vitalConfidenceLevel;
  final VoidCallback onTop;
  const StressInfoCard({
    super.key,
    required this.vitalName,
    required this.isExpanded,
    required this.titleText,
    required this.statusText,
    required this.valueText,
    required this.unitText,
    this.vitalConfidenceLevel = "",
    this.imageAsset = "",
    required this.onTop,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 1, color: Color(0xffD9D9D9)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: CommonText.text(
                  maxLines: 2,
                  titleText,
                  fontSize: AppDimensions.font(10),
                  fontWeight: FontWeight.w400,
                  color: Color(0xff575656),
                ),
              ),
              20.horizontalSpace,
              Expanded(
                flex: 6,
                child: Text(
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  statusText.toFirstCaps(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff575656),
                  ),
                ),
              ),
              this.imageAsset.isNotEmpty
                  ? Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SvgPicture.asset(
                        this.imageAsset,
                        width: 20,
                        height: 20,
                      ),
                    ),
                  )
                  : SizedBox(),
            ],
          ),
        ),
        Padding(
          padding: AppDimensions.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: valueText,
                        style: TextStyle(
                          fontSize: AppDimensions.font(26),
                          fontWeight: FontWeight.w700,
                          color: Color(0xff4A4949),
                        ),
                      ),
                      TextSpan(
                        text: unitText,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff4A4949),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              vitalConfidenceLevel.isNotEmpty
                  ? Expanded(
                    flex: 8,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 8.5,
                          backgroundColor: getStatusColor(vitalConfidenceLevel),
                        ),

                        TextButton(
                          onPressed: () {
                            CustomBottomSheetConfidence.show(
                              status: vitalConfidenceLevel.toFirstCaps(),
                            );
                          },
                          child: CommonText.text(
                            "${vitalConfidenceLevel.toFirstCaps()} Confidence",
                            decoration: TextDecoration.underline,
                            fontSize: AppDimensions.font(14),
                            fontWeight: FontWeight.w400,
                            color: AppColors.searchColor,
                          ),
                        ),
                      ],
                    ),
                  )
                  : SizedBox.shrink(),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: onTop,
                    child: Icon(
                      Icons.info_rounded,
                      color: AppColors.infoIconColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color getStatusColor(String level) {
    switch (level.toLowerCase()) {
      case "high":
        return const Color(0xFF1BC76D);
      case "medium":
        return const Color(0xFFEEC000);
      case "low":
        return const Color(0xFFFA704E);
      default:
        return Colors.grey;
    }
  }
}
