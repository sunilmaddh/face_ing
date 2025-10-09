import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/widgets/bottom_sheet/custom_bottom_sheet.dart';
import 'package:ntt_data/widgets/button/rounded_button.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class BottomsheetHelper {
  static void showBottomSheetAlert(
    BuildContext context,
    TabController tabController,
  ) {
    return CustomBottomSheet.show(
      isDismissible: true,
      isEnableDra: true,
      title: "",
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.99,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: RoundedButton(
                isAppBar: false,
                isClose: true,
                onPressed: () {
                  Get.back();
                  // tabController.animateTo(0);
                },
              ),
            ),

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  LottieBuilder.asset(
                    width: MediaQuery.of(context).size.width * 0.7,
                    AppAssets.allReport,
                  ),

                  CommonText.text(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    "Sign up to view detailed insights and full measurements",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
