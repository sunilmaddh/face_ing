import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/extentions.dart';
import 'package:ntt_data/core/utils/vital_status_halper.dart';
import 'package:ntt_data/data/models/healthDetailsResponseModel.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/bottom_sheet/custom_bottom_sheet.dart';
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

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      margin: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: AppDimensions.width(120),
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
                                  fontSize: AppDimensions.font(26),
                                  fontWeight: FontWeight.w400,
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
                // Container(
                //   width: 1,
                //   // height: AppDimensions.height(250),
                //   color: const Color(0xffD9D9D9),
                // ),
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
                        if (status.isNotEmpty)
                          confidenceLevel.isNotEmpty
                              ? Row(
                                children: [
                                  CircleAvatar(
                                    radius: 8.5,
                                    backgroundColor: getStatusColor(
                                      confidenceLevel,
                                    ),
                                  ),

                                  TextButton(
                                    onPressed: () {
                                      CustomBottomSheetConfidence.show(
                                        status: confidenceLevel.toFirstCaps(),
                                      );
                                    },
                                    child: Text(
                                      "${confidenceLevel.toFirstCaps()} Confidence",
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
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
                                children: [
                                  CircleAvatar(
                                    radius: 8.5,
                                    backgroundColor: color,
                                  ),
                                  SizedBox(width: AppDimensions.width(10)),
                                  CommonText.text(
                                    AppMethods.capitalizeFirst(status),
                                    fontSize: AppDimensions.font(14),
                                    color: color,
                                  ),
                                ],
                              ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
                  ),
                ),
              ],
            ),
          ),
          VitalSubListWidget(vitalSubList: vitalSubList, isSdkType: isSdkType),
        ],
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
            visible: vitalSubList != null && vitalSubList.isNotEmpty,
            child: Padding(
              padding: EdgeInsets.only(right: 15, bottom: 15),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    isExpanded.value = !isExpanded.value;
                  },
                  child:
                      isExpanded.value
                          ? const Icon(Icons.minimize_outlined)
                          : const Icon(Icons.add_outlined),
                ),
              ),
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
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: AppDimensions.only(right: 20.0),
                                  child: Text(
                                    maxLines: 2,
                                    result.vitalName.toString(),
                                    style: TextStyle(
                                      fontSize: AppDimensions.font(10),
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff575656),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    maxLines: 2,
                                    result.vitalHeading.toString(),
                                    style: TextStyle(
                                      fontSize: AppDimensions.font(10),
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff575656),
                                    ),
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
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff4A4949),
                                            ),
                                          ),
                                          TextSpan(
                                            text: result.vitalUnit,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SvgPicture.asset(
                                      result.vitalStatus!.isNotEmpty
                                          ? imageResSub
                                          : "",
                                      width: AppDimensions.width(20),
                                      height: AppDimensions.height(20),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    AppNavigation.to(
                                      AppRoutes.vitalDescriptions,
                                      arguments: {"vitalKey": result.vitalKey},
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
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Colors.grey,
                        thickness: 1,
                        indent: 16,
                        endIndent: 16,
                      );
                    },
                  )
                  : SizedBox.shrink(),
        ),
      ],
    );
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
