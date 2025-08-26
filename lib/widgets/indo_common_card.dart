import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/extentions.dart';
import 'package:ntt_data/widgets/bottom_sheet/custom_bottom_sheet.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';

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
  final VoidCallback onTop;
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
    required this.onTop,
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
                    width: AppDimensions.width(120),
                    padding: const EdgeInsets.all(15),
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
                        Text(
                          widget.vitalName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff575656),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          widget.vitalCondition,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff575656),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: widget.vitalValue.toFirstCaps(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff4A4949),
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' ${widget.vitalMass}', // Add space before vitalMass
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Divider
                  Container(
                    width: 1,
                    height: AppDimensions.height(
                      150,
                    ), // Adjust height as needed
                    color: const Color(0xffD9D9D9),
                  ),

                  // Right section
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.vitalStatus.isNotEmpty
                                ? "${widget.vitalHeading} is ${AppMethods.capitalizeFirst(widget.vitalStatus)}"
                                : "",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff5E5D5D),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            widget.vitalDescription,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff5E5D5D),
                              height: 1.25,
                            ),
                          ),
                          const SizedBox(height: 20),
                          widget.imageAsset.isNotEmpty
                              ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  widget.confidenceLevel.isNotEmpty
                                      ? Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 8.5,
                                            backgroundColor: getStatusColor(
                                              widget.confidenceLevel,
                                            ),
                                          ),

                                          TextButton(
                                            onPressed: () {
                                              CustomBottomSheetConfidence.show(
                                                status:
                                                    widget.confidenceLevel
                                                        .toFirstCaps(),
                                              );
                                            },
                                            child: Text(
                                              "${widget.confidenceLevel.toFirstCaps()} Confidence",
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.searchColor,
                                              ),
                                            ),

                                            // vitalConfidenceLevel.toFirstCaps(),
                                          ),
                                        ],
                                      )
                                      : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          widget.isVitalActive
                                              ? Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 10.5,
                                                    backgroundColor:
                                                        statusColor,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    widget.vitalStatus
                                                        .toFirstCaps(),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: statusColor,
                                                    ),
                                                  ),
                                                ],
                                              )
                                              : SizedBox(),

                                          // SvgPicture.asset(imageAsset, width: 20, height: 20),
                                        ],
                                      ),
                                ],
                              )
                              : SizedBox(),
                          Container(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: widget.onTop,
                              child: Icon(
                                Icons.info_rounded,
                                color: AppColors.infoIconColor,
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
            // Expand/Collapse button ONLY if isExpand prop is true
            widget.isExpand
                ? Padding(
                  padding: const EdgeInsets.only(right: 8, bottom: 15),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child:
                          isExpanded
                              ? const Icon(Icons.minimize_outlined)
                              : const Icon(Icons.add_outlined),
                    ),
                  ),
                )
                : const SizedBox(),

            // Show detailed card only when expanded AND vitalName is stress or blood pressure
            if (isExpanded &&
                (widget.vitalName.toLowerCase() == "stress level" ||
                    widget.vitalName == "HRV SDNN" ||
                    widget.vitalName == 'Blood Pressure'))
              widget.expandedWidget,
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
