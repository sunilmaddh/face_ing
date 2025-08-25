import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/extentions.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class CustomBottomSheet {
  static void show({
    required String title,
    required Widget content,
    bool isDismissible = true,
  }) {
    Get.bottomSheet(
      Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Custom Content
            Flexible(child: content),

            SizedBox(height: 10), // Add spacing at the bottom
          ],
        ),
      ),
      isDismissible: isDismissible,
      backgroundColor: Colors.transparent,
    );
  }
}

class CustomBottomSheetConfidence {
  static void show({required String status}) {
    Color getStatusColor(String level) {
      switch (level) {
        case "High":
          return const Color(0xFF1BC76D);
        case "Medium":
          return const Color(0xFFEEC000);
        case "Low":
          return const Color(0xFFFA704E);
        default:
          return Colors.grey;
      }
    }

    Get.bottomSheet(
      SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              height: 1100,
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        // top content scrollable
                        Expanded(
                          child: SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: AppDimensions.only(top: 20),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () => Get.back(),
                                        icon: const Icon(Icons.arrow_back_ios),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "The Confidence Level in This Result is ${status.toFirstCaps()}",
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          style: TextStyle(
                                            color: AppColors.blackColor,
                                            fontSize: AppDimensions.font(16),
                                            fontWeight: FontWeight.w600,
                                            // 👈 underline
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                20.verticalSpace,

                                Text(
                                  AppConstents.confidenceLevelDiscription,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: AppDimensions.font(14),
                                    color: AppColors.searchColor,
                                  ),
                                ),

                                10.verticalSpace,

                                Text(
                                  "The Confidence level values:",
                                  style: TextStyle(
                                    fontSize: AppDimensions.font(14),
                                    color: AppColors.searchColor,
                                    // 👈 underline
                                  ),
                                ),

                                ...["High", "Medium", "Low"].map((level) {
                                  final statusColor = getStatusColor(level);
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 3,
                                    ),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 8.5,
                                          backgroundColor: statusColor,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          "$level Confidence",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.searchColor,
                                            // 👈 underline
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                                15.verticalSpace,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Align(
                    alignment: Alignment.topCenter,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 13.5,
                        backgroundColor: getStatusColor(status),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      isDismissible: false,
      backgroundColor: Colors.transparent,
    );
  }

  Color getStatusColor(String level) {
    switch (level.toLowerCase()) {
      case "high":
        return Colors.red;
      case "medium":
        return Colors.yellow;
      case "low":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
