import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/home/controllers/home_controller.dart';
import 'package:ntt_data/modules/views/home/halper/home_halper.dart';
import 'package:ntt_data/modules/views/home/widgets/menu_card.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class MenuCardWidget extends StatelessWidget {
  MenuCardWidget({super.key});
  final homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppDimensions.symmetric(horizontal: 16),
      child: Obx(
        () => CommonCard(
          widget: Padding(
            padding: AppDimensions.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        // AppNavigation.to(
                        //   AppRoutes.pulseSurveyScreen,
                        // );
                      },
                      child: MenuCard(
                        menuTitle: "Pulse Survey",
                        image: AppAssets.pulseServe,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // AppNavigation.to(AppRoutes.voiceScreen);
                      },
                      child: MenuCard(
                        menuTitle: "Voice Scan",
                        image: AppAssets.voiceScan,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppDimensions.height(15)),
                homeController.wellnessModel.value.bloodPressureStatus != null
                    ? CommonCard(
                      color: AppColors.homeCardColor,
                      widget: SizedBox(
                        height: AppDimensions.height(71),
                        width: Get.width,
                        child: Padding(
                          padding: AppDimensions.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CommonText.text(
                                    "Blood Pressure",
                                    fontFamily: "DM Sans",
                                    fontSize: AppDimensions.font(14),
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary,
                                  ),

                                  SizedBox(height: AppDimensions.height(5)),

                                  SvgPicture.asset(AppAssets.bHeartAssets),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonText.text(
                                    homeController
                                        .wellnessModel
                                        .value
                                        .bloodPressure
                                        .toString(),
                                    fontFamily: "DM Sans",
                                    fontSize: AppDimensions.font(24),
                                    fontWeight: FontWeight.w700,
                                    color: HomeHalper().getBloodColor(
                                      homeController
                                          .wellnessModel
                                          .value
                                          .bloodPressureStatus
                                          .toString(),
                                    ),
                                  ),

                                  CommonText.text(
                                    "bpm",
                                    fontFamily: "DM Sans",
                                    fontSize: AppDimensions.font(14),
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.blackColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
