import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
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
  bool isBlood;
  final bool isLowGood;
  bool isBreathing;
  final bool isSdkType;

  String imageRes = "";
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
  });

  @override
  Widget build(BuildContext context) {
    if (isSdkType) {
      if (isLowGood == true) {
        if (vitalName == "Breathing Rate" ||
            vitalName == "Pulse Rate(Heart Rate)" ||
            vitalName == "PRQ" ||
            vitalName == "Hemoglobin") {
          isBreathing = true;
        } else if (vitalName == "Blood Systolic") {
          isBlood = true;
        }
      }
    } else {
      if (isLowGood == true) {
        if (vitalName == "Breathing Rate" || vitalName == "Heart Rate") {
          isBreathing = true;
        } else if (vitalName == "Blood Systolic") {
          isBlood = true;
        }
      }
    }
    if (isSdkType == true) {
      imageRes = _getImageResourceBinah();
      color = _getColorBinah();
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
        children: [
          Row(
            children: [
              SizedBox(
                width: 120,
                height: 210,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        maxLines: 2,
                        vitalName,
                        fontSize: 14,
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
                              text: vitalValue,
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
                      children: [
                        CommonText.text(
                          maxLines: 2,
                          vitalHeading,
                          fontSize: 16,
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
        ],
      ),
    );
  }

  String _getImageResourceBinah() {
    switch (vitalStatus) {
      case 'Low':
        return isBreathing
            ? AppAssets.mediumImage
            : isLowGood
            ? AppAssets.veryHighImage
            : AppAssets.veryLowImage;
      case 'Normal':
        return isBreathing
            ? AppAssets.mediumImage
            : isLowGood
            ? AppAssets.highImage
            : AppAssets.veryHighImage;
      case "Medium":
        return AppAssets.mediumImage;
      case "Mild":
        return AppAssets.mediumImage;
      case 'High':
        return isBreathing
            ? AppAssets.mediumImage
            : isLowGood
            ? AppAssets.veryHighImage
            : isBlood
            ? AppAssets.lowImage
            : AppAssets.veryLowImage;
      case 'Very High':
        return AppAssets.veryLowImage;
      default:
        return AppAssets.veryHighImage;
    }
  }

  Color _getColorBinah() {
    switch (vitalStatus) {
      case 'Low':
        return isBreathing
            ? const Color(0xFFEEC000)
            : isLowGood
            ? const Color(0xFF1BC76D)
            : const Color(0xFFFA704E);
      case 'Normal':
        return isBreathing
            ? const Color(0xFFEEC000)
            : isLowGood
            ? const Color(0xFFED9A33)
            : const Color(0xFF1BC76D);
      case 'Medium':
        return const Color(0xFFEEC000);
      case 'Mild':
        return const Color(0xFFEEC000);
      case 'Very High':
        return isLowGood ? const Color(0xFFFA704E) : const Color(0xFF1BC76D);
      case 'High':
        return isBreathing
            ? const Color(0xFFEEC000)
            : isLowGood
            ? const Color(0xFF1BC76D)
            : isBlood
            ? const Color(0xFFED9A33)
            : const Color(0xFFFA704E);
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
      case 'Very Low':
      case 'Low':
      case 'Normal':
      case 'Medium':
      case 'High':
      case 'Optimal':
      case 'Very High':
        return vitalStatus;
      default:
        return '';
    }
  }
}
