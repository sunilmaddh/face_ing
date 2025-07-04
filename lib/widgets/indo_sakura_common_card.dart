import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/data/models/healthDetailsResponseModel.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

// ignore: camel_case_types
class IndoSakuraCommonCard extends StatelessWidget {
  final String vitalName;
  final String vitalStatus;
  final String vitalValue;
  final String vitalHeading;
  final String vitalDescription;
  final String vitalCondition;
  final String vitalMass;
  final List<HealthDetailList> vitalSubList;
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
    this.isLowGood = false,
    this.isBreathing = false,
    this.isSdkType = false,
    required this.vitalSubList,
  });

  @override
  Widget build(BuildContext context) {
    if (isSdkType &&
        isLowGood &&
        vitalName == "Blood Pressure" &&
        vitalStatus == "High") {
      isLowGood = false;
    }
    if (isSdkType == true) {
      imageRes = _getImageResourceBinah(vitalStatus);
      color = _getColorBinah(vitalStatus);
    } else {
      imageRes = _getImageResource();
      color = _getColor();
    }
    status = _getStatus();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      margin: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              SizedBox(
                width: 140,
                height: 215,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (vitalStatus.isNotEmpty)
                        SvgPicture.asset(
                          imageRes,
                          width: 37,
                          height: 37,
                          fit: BoxFit.cover,
                        ),
                      const SizedBox(height: 5),
                      CommonText.text(
                        maxLines: 3,
                        vitalName,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff575656),
                      ),
                      const SizedBox(height: 5),
                      CommonText.text(
                        vitalCondition,
                        fontSize: 10,
                        color: Color(0xff575656),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: capitalizeFirst(vitalValue),
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff4A4949),
                              ),
                            ),
                            TextSpan(
                              text: ' $vitalMass',
                              style: const TextStyle(
                                fontSize: 14,
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
              Container(width: 2, height: 180, color: const Color(0xffD9D9D9)),
              Expanded(
                child: SizedBox(
                  height: 195,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonText.text(
                          maxLines: 2,
                          vitalHeading,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff5E5D5D),
                        ),
                        const SizedBox(height: 10),
                        CommonText.text(
                          maxLines: 5,
                          vitalDescription,
                          fontSize: 12,
                          color: Color(0xff5E5D5D),
                        ),
                        const SizedBox(height: 20),
                        if (vitalStatus.isNotEmpty)
                          Row(
                            children: [
                              Container(
                                width: 21,
                                height: 21,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: color,
                                ),
                              ),
                              const SizedBox(width: 10),
                              CommonText.text(
                                status,
                                fontSize: 14,
                                color: color,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
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
                    ? Container(
                      height: 1, // Adjust height as needed
                      color: const Color(0xffD9D9D9),
                    )
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
                        if (isSdkType) {
                          if (stringToBool(result.isTypeVital.toString()) ==
                              true) {
                            if (vitalName == "Breathing Rate" ||
                                vitalName == "Pulse Rate(Heart Rate)" ||
                                vitalName == "PRQ" ||
                                vitalName == "Hemoglobin") {
                              isBreathing = true;
                            } else if (vitalName == "Blood Systolic") {
                              isBlood = true;
                            } else if (result.vitalName == "Mean RRi" &&
                                    result.vitalStatus == "Low" ||
                                result.vitalName == "RMSSD" &&
                                    result.vitalStatus == "Low") {
                              isLowGood = false;
                            } else {
                              isLowGood = stringToBool(
                                result.isTypeVital.toString(),
                              );
                            }
                          }
                        }
                        if (isSdkType) {
                          imageResSub = _getImageResourceBinah(
                            result.vitalStatus.toString(),
                          );
                        }
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    result.vitalName.toString(),
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff575656),
                                    ),
                                  ),
                                  Text(
                                    result.vitalHeading.toString(),
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff575656),
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    imageResSub,
                                    width: 20,
                                    height: 20,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: result.vitalValue,
                                          style: const TextStyle(
                                            fontSize: 26,
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

                                  // SvgPicture.asset(
                                  //   imageRes,
                                  //   width: 20,
                                  //   height: 20,
                                  // ),
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
      ),
    );
  }

  String capitalizeFirst(String word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }

  bool stringToBool(String value) {
    return value.toLowerCase() == 'true';
  }

  String _getImageResourceBinah(String vitalStatus) {
    switch (vitalStatus) {
      case 'low':
      case 'Low':
        return isLowGood ? AppAssets.mediumAsset : AppAssets.veryLowImage;
      case "normal":
      case 'Normal':
        return AppAssets.veryHighImage;
      case "Medium":
      case "medium":
        return AppAssets.mediumImage;
      case "Mild":
        return AppAssets.mediumImage;
      case 'High':
      case 'high':
        return isLowGood ? AppAssets.mediumAsset : AppAssets.veryLowImage;
      case 'Prediabetes risk':
      case 'Prediabetes':
        return AppAssets.mediumImage;
      case 'Diabetes risk':
      case 'Diabetes':
        return AppAssets.veryLowImage;
      default:
        return AppAssets.veryHighImage;
    }
  }

  Color _getColorBinah(String vitalStatus) {
    switch (vitalStatus) {
      case 'Low':
        return isLowGood ? const Color(0xFFEEC000) : const Color(0xFFFA704E);
      case 'Normal':
        return const Color(0xFF1BC76D);
      case 'Medium':
        return const Color(0xFFEEC000);
      case 'Mild':
        return const Color(0xFFEEC000);
      case 'High':
        return isLowGood ? const Color(0xFFEEC000) : const Color(0xFFFA704E);
      case 'Prediabetes risk':
      case 'Prediabetes':
        return const Color(0xFFEEC000);
      case 'Diabetes risk':
      case 'Diabetes':
        return const Color(0xFFFA704E);
      default:
        return Colors.white;
    }
  }

  String _getImageResource() {
    switch (vitalStatus) {
      case 'Very Low':
        return isBreathing
            ? AppAssets.mediumImage
            : isBlood
            ? AppAssets.lowImage
            : isLowGood
            ? AppAssets.veryHighImage
            : AppAssets.veryLowImage;
      case 'Low':
        return isLowGood ? AppAssets.highImage : AppAssets.lowImage;
      case 'Normal':
        return AppAssets.veryHighImage;
      case 'Medium':
        return AppAssets.mediumImage;
      case 'High':
        return isBreathing
            ? AppAssets.mediumImage
            : isLowGood
            ? AppAssets.mediumImage
            : AppAssets.highImage;
      case 'Very High':
        return isBlood
            ? AppAssets.lowImage
            : isLowGood
            ? AppAssets.lowImage
            : AppAssets.veryHighImage;
      case 'Optimal':
        return AppAssets.veryHighImage;

      default:
        return AppAssets.veryHighImage;
    }
  }

  Color _getColor() {
    switch (vitalStatus) {
      case 'Very Low':
        return isBlood
            ? const Color(0xFFFA704E)
            : isLowGood
            ? const Color(0xFF1BC76D)
            : const Color(0xFFFA704E);
      case 'Low':
        return isBreathing
            ? const Color(0xFFEEC000)
            : isLowGood
            ? const Color(0xFF9ED042)
            : const Color(0xFFED9A33);
      case 'Normal':
        return const Color(0xFF1BC76D);
      case 'Medium':
        return const Color(0xFFEEC000);
      case 'Optimal':
        return const Color(0xFF1BC76D);
      case 'Very High':
        return isLowGood ? const Color(0xFFFA704E) : const Color(0xFF1BC76D);
      case 'High':
        return isBreathing
            ? const Color(0xFFEEC000)
            : isBlood || isLowGood
            ? const Color(0xFFED9A33)
            : const Color(0xFF9ED042);
      default:
        return Colors.white;
    }
  }

  String _getStatus() {
    switch (vitalStatus) {
      case 'Diabetes':
        return 'Diabetes risk';
      case 'Prediabetes':
        return 'Prediabetes risk';
      case 'Very Low':
      case 'Low':
      case 'Normal':
      case 'Medium':
      case 'High':
      case 'Optimal':
      case 'Very High':
      case 'Prediabetes risk':
      case 'Diabetes risk':
        return vitalStatus;

      default:
        return '';
    }
  }
}
