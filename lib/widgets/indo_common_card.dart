import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_fonts.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/extensions/extentions.dart';
import 'package:ntt_data/widgets/bottom_sheet/custom_bottom_sheet.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class IndoCommonCard extends StatefulWidget {
  final String vitalName;
  final String vitalStatus;
  final String vitalValue;
  final String confidenceLevel;
  final String vitalHeading;
  final String vitalDescription;
  final String vitalCondition;
  final String vitalMass;
  final String imageAsset;
  final bool isExpand;
  final bool isVitalActive;
  final Widget expandedWidget;

  final VoidCallback onInfoTop;

  const IndoCommonCard({
    super.key,
    this.vitalName = "",
    this.vitalStatus = "",
    this.imageAsset = "",
    this.vitalValue = "",
    this.vitalHeading = "",
    this.vitalDescription = "",
    this.vitalCondition = "",
    this.vitalMass = "",
    this.confidenceLevel = "",
    this.isExpand = false,
    this.isVitalActive = true,
    this.expandedWidget = const SizedBox(),
    required this.onInfoTop, // fixed default widget
  });
  @override
  State<IndoCommonCard> createState() => _CommonCardState();
}

class _CommonCardState extends State<IndoCommonCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    // String imageAsset;

    switch (widget.imageAsset) {
      case AppAssets.mediumImage:
        statusColor = const Color(0xFFFFD700); // Yellow color
        break;
      case AppAssets.highImage:
        statusColor = const Color(0xFF9ED042); // Yellow color
        break;
      case AppAssets.veryHighImage:
        statusColor = const Color(0xFF1BC76D); // Green color
        break;
      case AppAssets.veryLowImage:
      default:
        statusColor = const Color(0xFFFA704E); // Red color
    }

    return CommonCard(
      radius: AppDimensions.radius(18.0),
      widget: Container(
        // margin: EdgeInsets.all(6.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: AppDimensions.width(101),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.imageAsset.isNotEmpty
                            ? SvgPicture.asset(
                              widget.imageAsset,
                              width: AppDimensions.width(37),
                              height: AppDimensions.height(37),
                            )
                            : SizedBox(),
                        SizedBox(height: AppDimensions.height(10)),
                        CommonText.labelLarge(
                          maxLines: 3,
                          widget.vitalName,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff575656),
                          textAlign: TextAlign.left,
                        ),

                        CommonText.labelSmall(
                          widget.vitalCondition,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff575656),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: widget.vitalValue.toFirstCaps(),
                                style: TextStyle(
                                  fontSize: AppDimensions.font(20),
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff4A4949),
                                  fontFamily: "Gilroy-Bold",
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' ${widget.vitalMass}', // Add space before vitalMass
                                style: TextStyle(
                                  fontSize: AppDimensions.font(12),
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff4A4949),
                                  fontFamily: "Gilroy-Bold",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Divider
                  Container(width: 1, color: const Color(0xffD9D9D9)),

                  // Right section
                  Expanded(
                    child: Padding(
                      padding: AppDimensions.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText.titleMedium(
                            fontType: AppFontType.secondary,
                            maxLines: 3,
                            widget.vitalStatus.isNotEmpty
                                ? "${widget.vitalHeading} is ${AppMethods.capitalizeFirst(widget.vitalStatus)}"
                                : "",

                            fontWeight: FontWeight.w400,
                            color: Color(0xff5E5D5D),
                          ),
                          const SizedBox(height: 10),
                          CommonText.labelMedium(
                            maxLines: 7,
                            widget.vitalDescription,

                            fontWeight: FontWeight.w400,
                            color: Color(0xff5E5D5D),
                          ),
                          SizedBox(height: AppDimensions.height(20.0)),
                          widget.imageAsset.isNotEmpty
                              ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  widget.confidenceLevel.isNotEmpty
                                      ? Expanded(
                                        flex: 8,
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 8.5,
                                              backgroundColor: getStatusColor(
                                                widget.confidenceLevel,
                                              ),
                                            ),
                                            SizedBox(
                                              width: AppDimensions.width(5.0),
                                            ),

                                            InkWell(
                                              onTap: () {
                                                CustomBottomSheetConfidence.show(
                                                  status:
                                                      widget.confidenceLevel
                                                          .toFirstCaps(),
                                                );
                                              },
                                              child: CommonText.labelMedium(
                                                "${widget.confidenceLevel.toFirstCaps()} Confidence",

                                                decoration:
                                                    TextDecoration.underline,

                                                fontWeight: FontWeight.w400,
                                                color: AppColors.searchColor,
                                              ),

                                              // vitalConfidenceLevel.toFirstCaps(),
                                            ),
                                          ],
                                        ),
                                      )
                                      : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          widget.isVitalActive
                                              ? Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 8.5,
                                                    backgroundColor:
                                                        statusColor,
                                                  ),
                                                  SizedBox(
                                                    width: AppDimensions.width(
                                                      5.0,
                                                    ),
                                                  ),

                                                  CommonText.labelLarge(
                                                    widget.vitalStatus
                                                        .toFirstCaps(),

                                                    fontWeight: FontWeight.w400,
                                                    color: statusColor,
                                                  ),
                                                ],
                                              )
                                              : SizedBox(),
                                        ],
                                      ),
                                ],
                              )
                              : SizedBox.shrink(),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: widget.onInfoTop,
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
                  ),
                ],
              ),
            ),
            widget.isExpand
                ? Container(height: 1, color: const Color(0xffD9D9D9))
                : SizedBox.shrink(),

            widget.isExpand
                ? Padding(
                  padding: AppDimensions.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText.text(
                          isExpanded ? "Hide Result" : "Show all Result",
                          color: AppColors.infoIconColor,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child:
                              isExpanded
                                  ? const Icon(
                                    Icons.remove_circle_outline,
                                    color: AppColors.infoIconColor,
                                  )
                                  : const Icon(
                                    Icons.add_circle_outline,
                                    color: AppColors.infoIconColor,
                                  ),
                        ),
                      ],
                    ),
                  ),
                )
                : const SizedBox(),

            // Expand/Collapse button ONLY if isExpand prop is true
            if (isExpanded) widget.expandedWidget,
          ],
        ),
      ),
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
