import 'package:biosensesignal_flutter_sdk/images/image_validity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/modules/views/binah/controllers/measurement_controller.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/dialog/dialog_halper.dart';
import 'package:ntt_data/widgets/button/primary_button.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class StartStopButton extends StatelessWidget {
  StartStopButton({super.key, required this.userName});

  final controller = Get.find<MeasurementController>();
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.width(30)),
        child: SafeArea(
          child: SizedBox(
            height: AppDimensions.height(210),
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: AppDimensions.height(10)),
                    CommonText.text(
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      "${userName.trimRight()}, Ready to Measure Your Vital Signs?",
                      color: AppColors.primary,
                      fontSize: AppDimensions.font(18),
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: AppDimensions.height(8.0)),
                    CommonText.text(
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      "Sit still, ensure your face is evenly illuminated and there is no light source in the background.",
                      color: AppColors.searchColor,
                    ),
                    SizedBox(height: AppDimensions.height(15)),
                  ],
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: SafeArea(
                    child: PrimaryButton(
                      isLoading: controller.isLoading.value,
                      text: "Measure now",
                      onPressed: () async {
                        var batteryLevel = await AppMethods().getBatteryLevel();
                        var batterySaveMode =
                            await AppMethods().getBatterySaveMode();
                        if (batteryLevel < 20) {
                          // ignore: use_build_context_synchronously
                          DialogHelper().showBatteryLevelAlertDialog(context);
                        } else if (batterySaveMode) {
                          // ignore: use_build_context_synchronously
                          DialogHelper().showBatterySaveAlertDialog(context);
                        } else {
                          controller.isLoading.value = true;
                          controller.isScanStop.value = false;
                          controller.isFirstEver.value = true;
                          controller.startStopButtonClicked();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class PulseRate extends StatelessWidget {
  const PulseRate({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MeasurementController>();
    return Obx(
      () => Container(
        margin: EdgeInsets.zero,
        alignment: Alignment.center,
        height: AppDimensions.height(70),
        width: AppDimensions.width(70),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AppAssets.redHeart)),
        ),
        child: Text(
          controller.pulseRate.value.isNotEmpty
              ? "${controller.pulseRate.value} "
              : "- -",
          style: TextStyle(
            color: AppColors.btntext,
            fontSize: AppDimensions.font(22),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class ImageValidityScan extends StatelessWidget {
  const ImageValidityScan({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MeasurementController>();
    return Obx(() {
      final imageData = controller.imageData.value;

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.width(45)),
        child: Column(
          children: [
            Text(
              textAlign: TextAlign.center,
              imageData?.imageValidity == ImageValidity.faceTooFar ||
                      imageData?.imageValidity == ImageValidity.invalidRoi
                  ? "Face too far"
                  : imageData?.imageValidity == ImageValidity.tiltedHead
                  ? "Tilted Head"
                  : imageData?.imageValidity == ImageValidity.unevenLight
                  ? "Uneven light"
                  : imageData?.imageValidity ==
                      ImageValidity.invalidDeviceOrientation
                  ? "Invalid device orientation"
                  : "",
              style: TextStyle(
                color: AppColors.primary,
                fontSize: AppDimensions.font(18),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppDimensions.height(10)),
            Text(
              textAlign: TextAlign.center,
              controller.imageValidityString.value,
              style: TextStyle(
                color: Colors.black,
                fontSize: AppDimensions.font(15),
              ),
            ),
          ],
        ),
      );
    });
  }
}
