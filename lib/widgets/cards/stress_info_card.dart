import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/extentions.dart';
import 'package:ntt_data/widgets/bottom_sheet/custom_bottom_sheet.dart';

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
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  titleText,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff575656),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  textAlign: TextAlign.start,
                  maxLines: 2,
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
                    flex: 1,
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
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff4A4949),
                        ),
                      ),
                      TextSpan(
                        text: unitText,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              vitalConfidenceLevel.isNotEmpty
                  ? Expanded(
                    flex: 5,
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
                          child: Text(
                            "${vitalConfidenceLevel.toFirstCaps()} Confidence",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.searchColor,
                            ),
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
