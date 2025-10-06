import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/extentions.dart';

class CustomBottomSheet {
  static void show({
    required String title,
    required Widget content,
    bool isDismissible = true,
    bool isEnableDra = true,
  }) {
    Get.bottomSheet(
      enableDrag: isEnableDra,
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
            title.isNotEmpty
                ? Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
                : SizedBox.shrink(),
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
      // 👇 SafeArea applied only at top (no bottom padding)
      SafeArea(
        top: true,
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30.h),
                  width: double.infinity,

                  // 👇 Cap height at 85% of screen
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.85,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                  ),

                  child: SingleChildScrollView(
                    // 👇 Removed bottom padding to avoid gap
                    padding: EdgeInsets.all(16.w).copyWith(bottom: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        10.verticalSpace,
                        Row(
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
                                  fontSize: AppDimensions.font(16.sp),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        20.verticalSpace,

                        Text(
                          AppConstents.confidenceLevelDiscription,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.searchColor,
                          ),
                        ),

                        10.verticalSpace,

                        Text(
                          "The Confidence level values:",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.searchColor,
                          ),
                        ),

                        10.verticalSpace,

                        ...["High", "Medium", "Low"].map((level) {
                          final statusColor = getStatusColor(level);
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.h),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 8.5.r,
                                  backgroundColor: statusColor,
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  "$level Confidence",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.searchColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),

                        15.verticalSpace,
                      ],
                    ),
                  ),
                ),

                // 👇 Status Circle on top
                Align(
                  alignment: Alignment.topCenter,
                  child: CircleAvatar(
                    radius: 30.r,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 13.5.r,
                      backgroundColor: getStatusColor(status),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      isDismissible: false,
      backgroundColor: Colors.transparent,
    );
  }
}
