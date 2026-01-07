import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/data/models/pulse_survey_model.dart';
import 'package:ntt_data/modules/views/home/controllers/home_controller.dart';
import 'package:ntt_data/modules/views/home/halper/home_halper.dart';
import 'package:ntt_data/modules/views/home/widgets/menu_card.dart';
import 'package:ntt_data/modules/views/pulse/controller/pulse_survey_controller.dart';
import 'package:ntt_data/modules/views/pulse/helper/pulse_helper.dart';
import 'package:ntt_data/modules/views/pulse/views/pulse_screen.dart';
import 'package:ntt_data/modules/views/pulse/widget/pulse_Line_chart_widget.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

// ignore: must_be_immutable
class MenuCardWidget extends StatelessWidget {
  MenuCardWidget({super.key});
  final homeController = Get.put(HomeController());
  final pulseController = Get.find<PulseSurveyController>();
  RxList<PulseSurveyList> pulsList = <PulseSurveyList>[].obs;
  RxList<String> xAxis = <String>[].obs;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppDimensions.symmetric(horizontal: 16),
      child: Obx(() {
        if (pulseController.pulseSevryModel.value.xAxis != null) {
          pulsList.value = PulseHelper().normalizeHealthData(
            pulseController.pulseSevryModel.value.xAxis!,
            pulseController.pulseSevryModel.value.result!,
          );
          xAxis.value = PulseHelper().formatXAxis(
            pulseController.pulseSevryModel.value.xAxis!,
          );
        }
        final status = pulseController.pulseSevryModel.value.status;
        final color = PulseHelper().getColor(status.toString());
        return CommonCard(
          widget: Padding(
            padding: AppDimensions.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Get.to(() => PulseScreen(fromHome: true));
                          },
                          child: CommonCard(
                            color: AppColors.homeCardColor,
                            widget: SizedBox(
                              height: AppDimensions.height(149),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child:
                                    pulseController
                                                    .pulseSevryModel
                                                    .value
                                                    .status !=
                                                null &&
                                            pulseController
                                                .pulseSevryModel
                                                .value
                                                .status
                                                .toString()
                                                .isNotEmpty
                                        ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,

                                          children: [
                                            SizedBox(height: 15.h),
                                            PulseLineChartWidget(
                                              height: 50,
                                              bottomTitles: xAxis,
                                              vitalValues: pulsList,
                                            ),
                                            SizedBox(height: 10.h),
                                            CommonText.text(
                                              AppConstents.latestResult,

                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "Manrope",
                                              color: const Color(0xff898989),
                                            ),
                                            SizedBox(height: 5.h),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  PulseHelper().getImage(
                                                    pulseController
                                                        .pulseSevryModel
                                                        .value
                                                        .status
                                                        .toString(),
                                                  ),
                                                  width: 24.w,
                                                  height: 24.h,
                                                  color: PulseHelper().getColor(
                                                    pulseController
                                                        .pulseSevryModel
                                                        .value
                                                        .status
                                                        .toString(),
                                                  ),
                                                ),
                                                SizedBox(width: 10.w),
                                                CommonText.text(
                                                  pulseController
                                                      .pulseSevryModel
                                                      .value
                                                      .status
                                                      .toString(),
                                                  fontSize: AppDimensions.font(
                                                    16,
                                                  ),
                                                  fontWeight: FontWeight.w700,
                                                  color: color,
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                        : MenuCard(
                                          menuTitle: "Pulse Survey",
                                          image: AppAssets.pulseServe,
                                        ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 12.w),

                    Flexible(
                      flex: 2,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            // AppNavigation.to(AppRoutes.voiceScreen);
                          },
                          child: const MenuCard(
                            menuTitle: "Voice Scan",
                            image: AppAssets.voiceScan,
                          ),
                        ),
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
        );
      }),
    );
  }
}
