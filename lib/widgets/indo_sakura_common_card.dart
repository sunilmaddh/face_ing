import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/extentions.dart';
import 'package:ntt_data/data/helper/vital_status_halper.dart';
import 'package:ntt_data/modules/profile/models/healthDetailsResponseModel.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/bottom_sheet/custom_bottom_sheet.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

// ignore: camel_case_types, must_be_immutable
class IndoSakuraCommonCard extends StatelessWidget {
  final String vitalName;
  final String vitalStatus;
  final String vitalValue;
  final String vitalHeading;
  final String vitalDescription;
  final String vitalCondition;
  final String vitalMass;
  final VoidCallback onInfoTop;
  final List<HealthDetailList> vitalSubList;
  final String confidenceLevel;
  bool isBlood;
  bool isLowGood;
  bool isBreathing;
  bool isHighLow = false;
  bool isStress = false;
  bool isWellnessScore = false;
  final bool isSdkType;
  RxBool isExpanded = false.obs;

  String imageRes = "";
  String imageResSub = "";
  Color color = Colors.white;
  String status = "";

  IndoSakuraCommonCard({
    super.key,
    this.vitalName = '',
    this.vitalStatus = '',
    this.vitalValue = '',
    this.vitalHeading = '',
    this.vitalDescription = '',
    this.vitalCondition = '',
    this.vitalMass = '',
    this.isBlood = false,
    this.confidenceLevel = "",
    this.isLowGood = false,
    this.isBreathing = false,
    this.isSdkType = false,
    required this.onInfoTop,
    required this.vitalSubList,
  });

  @override
  Widget build(BuildContext context) {
    final vitalHalper = BinahVitalHelper(
      isSdkType: isSdkType,
      vitalName: vitalName,
      vitalStatus: vitalStatus,
      isLowGood: isLowGood,
      vitalValue: vitalValue,
    );

    imageRes = vitalHalper.getImageResource(vitalStatus);
    color = vitalHalper.getColor();
    status = vitalHalper.getStatus();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CommonCard(
        radius: AppDimensions.radius(18.0),
        padding: 0.0,
        widget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: AppDimensions.width(101),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (vitalStatus.isNotEmpty)
                            SvgPicture.asset(
                              imageRes,
                              width: AppDimensions.width(37),
                              height: AppDimensions.height(37),
                              fit: BoxFit.cover,
                            ),
                          SizedBox(height: AppDimensions.height(5)),
                          CommonText.text(
                            maxLines: 3,
                            vitalName,
                            fontSize: AppDimensions.font(14),
                            fontWeight: FontWeight.w400,
                            color: Color(0xff575656),
                          ),
                          vitalCondition.isNotEmpty
                              ? SizedBox(height: AppDimensions.height(5))
                              : SizedBox.shrink(),
                          vitalCondition.isNotEmpty
                              ? CommonText.text(
                                vitalCondition,
                                fontSize: AppDimensions.font(10),
                                color: Color(0xff575656),
                              )
                              : SizedBox.shrink(),
                          SizedBox(height: AppDimensions.height(10)),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: AppMethods.capitalizeFirst(vitalValue),
                                  style: TextStyle(
                                    fontSize: AppDimensions.font(20),
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff4A4949),
                                  ),
                                ),
                                TextSpan(
                                  text: ' $vitalMass',
                                  style: TextStyle(
                                    fontSize: AppDimensions.font(14),
                                    color: Color(0xff4A4949),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  VerticalDividerLine(),

                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.,
                        children: [
                          CommonText.text(
                            maxLines: 3,
                            vitalHeading,
                            fontSize: AppDimensions.font(16),
                            fontWeight: FontWeight.w400,
                            color: Color(0xff5E5D5D),
                          ),
                          SizedBox(height: AppDimensions.height(10)),
                          CommonText.text(
                            maxLines: 9,
                            vitalDescription,
                            fontSize: AppDimensions.font(12),
                            color: Color(0xff5E5D5D),
                          ),
                          SizedBox(height: AppDimensions.height(10)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (status.isNotEmpty)
                                confidenceLevel.isNotEmpty
                                    ? Expanded(
                                      flex: 7,
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 8.5,
                                            backgroundColor: getStatusColor(
                                              confidenceLevel,
                                            ),
                                          ),

                                          SizedBox(
                                            width: AppDimensions.width(5.0),
                                          ),

                                          InkWell(
                                            onTap: () {
                                              CustomBottomSheetConfidence.show(
                                                status:
                                                    confidenceLevel
                                                        .toFirstCaps(),
                                              );
                                            },
                                            child: CommonText.text(
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              "${confidenceLevel.toFirstCaps()} Confidence",
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.searchColor,
                                            ),

                                            // vitalConfidenceLevel.toFirstCaps(),
                                          ),
                                        ],
                                      ),
                                    )
                                    : Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 8.5,
                                          backgroundColor: color,
                                        ),
                                        SizedBox(
                                          width: AppDimensions.width(5.0),
                                        ),
                                        CommonText.text(
                                          AppMethods.capitalizeFirst(status),
                                          fontSize: AppDimensions.font(14),
                                          color: color,
                                        ),
                                      ],
                                    ),

                              if (vitalValue.isNotEmpty ||
                                  vitalStatus.isNotEmpty)
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: onInfoTop,
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Icon(
                                        Icons.info,
                                        color: AppColors.infoIconColor,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            VitalSubListWidget(
              vitalSubList: vitalSubList,
              isSdkType: isSdkType,
            ),
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

// ignore: must_be_immutable
class VitalSubListWidget extends StatelessWidget {
  VitalSubListWidget({
    super.key,
    required this.vitalSubList,
    required this.isSdkType,
  });
  final List<HealthDetailList> vitalSubList;
  RxBool isExpanded = false.obs;
  String imageResSub = "";
  final bool isSdkType;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(
          () => Visibility(
            visible: vitalSubList.isNotEmpty,
            child: Column(
              children: [
                Container(height: 1, color: const Color(0xffD9D9D9)),

                Padding(
                  padding: AppDimensions.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      isExpanded.value = !isExpanded.value;
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText.text(
                          isExpanded.value
                              ? "Hide results"
                              : "Show all results",
                          color: AppColors.infoIconColor,
                        ),
                        isExpanded.value
                            ? const Icon(
                              Icons.remove_circle_outline,
                              color: AppColors.infoIconColor,
                            )
                            : const Icon(
                              Icons.add_circle_outline,
                              color: AppColors.infoIconColor,
                            ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Obx(
          () =>
              isExpanded.value
                  ? Container(height: 1, color: const Color(0xffD9D9D9))
                  : SizedBox.shrink(),
        ),

        Obx(
          () =>
              isExpanded.value
                  ? ListView.separated(
                    shrinkWrap: true,
                    itemCount: vitalSubList.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (contect, index) {
                      var result = vitalSubList[index];
                      final vitalSubHalper = BinahVitalHelper(
                        isSdkType: isSdkType,
                        vitalName: result.vitalName!,
                        vitalStatus: result.vitalStatus!,
                        isLowGood: AppMethods.stringToBool(
                          result.isTypeVital.toString(),
                        ),
                        vitalValue: result.vitalValue.toString(),
                      );
                      imageResSub = vitalSubHalper.getImageResource(
                        result.vitalStatus.toString(),
                      );
                      return Padding(
                        padding: AppDimensions.symmetric(
                          horizontal: 8.0,
                          vertical: 5.0,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: CommonText.text(
                                    maxLines: 2,
                                    result.vitalName.toString(),
                                    fontSize: AppDimensions.font(10),
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff575656),
                                  ),
                                ),
                                Flexible(
                                  flex: 5,
                                  child: CommonText.text(
                                    maxLines: 2,
                                    result.vitalHeading.toString(),
                                    fontSize: AppDimensions.font(10),
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff575656),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: SvgPicture.asset(
                                    result.vitalStatus!.isNotEmpty
                                        ? imageResSub
                                        : "",
                                    width: AppDimensions.width(20),
                                    height: AppDimensions.height(20),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: AppDimensions.height(10)),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: result.vitalValue,
                                            style: TextStyle(
                                              fontSize: AppDimensions.font(26),
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xff4A4949),
                                            ),
                                          ),
                                          TextSpan(
                                            text: result.vitalUnit,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff4A4949),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    result.vitalConfidence!.isNotEmpty
                                        ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            CircleAvatar(
                                              radius: 8.5,
                                              backgroundColor: getStatusColor(
                                                result.vitalConfidence
                                                    .toString(),
                                              ),
                                            ),

                                            TextButton(
                                              onPressed: () {
                                                CustomBottomSheetConfidence.show(
                                                  status:
                                                      result.vitalConfidence!
                                                          .toFirstCaps(),
                                                );
                                              },
                                              child: Text(
                                                "${result.vitalConfidence!.toFirstCaps()} Confidence",
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
                                        : SizedBox.shrink(),
                                    InkWell(
                                      onTap: () {
                                        AppNavigation.to(
                                          AppRoutes.vitalDescriptions,
                                          arguments: {
                                            "vitalKey": result.vitalKey,
                                          },
                                        );
                                      },
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Icon(
                                          Icons.info,
                                          color: AppColors.infoIconColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Container(
                        height: 1,
                        color: const Color(0xffD9D9D9),
                      );
                    },
                  )
                  : SizedBox.shrink(),
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

class VerticalDividerLine extends StatelessWidget {
  final Color color;
  final double thickness;

  const VerticalDividerLine({
    super.key,
    this.color = const Color(0xffD9D9D9),
    this.thickness = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(width: thickness, color: color);
  }
}
