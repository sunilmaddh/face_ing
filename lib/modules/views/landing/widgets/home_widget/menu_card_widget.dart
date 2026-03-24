import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/data/models/pulse_survey_model.dart';
import 'package:ntt_data/modules/views/landing/controller/home_controller.dart';
import 'package:ntt_data/modules/views/landing/helper/home_helper.dart';
import 'package:ntt_data/modules/views/landing/widgets/home_widget/menu_card.dart';
import 'package:ntt_data/modules/views/phq/controllers/assessment_controller.dart';
import 'package:ntt_data/modules/views/landing/pulse/controller/pulse_survey_controller.dart';
import 'package:ntt_data/modules/views/landing/pulse/helper/pulse_helper.dart';
import 'package:ntt_data/modules/views/landing/pulse/views/pulse_screen.dart';
import 'package:ntt_data/modules/views/landing/pulse/widget/pulse_Line_chart_widget.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

// ignore: must_be_immutable
class MenuCardWidget extends StatelessWidget {
  MenuCardWidget({super.key});
  final homeController = Get.find<HomeController>();
  final pulseController = Get.find<PulseSurveyController>();
  RxList<PulseSurveyList> pulsList = <PulseSurveyList>[].obs;
  var assController = AssessmentController.instance;
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
                          child: CommonCard(
                            color: AppColors.homeCardColor,
                            widget: SizedBox(
                              height: AppDimensions.height(149),
                              // height: AppDimensions.height(71),
                              width: Get.width,
                              child: Padding(
                                padding: AppDimensions.symmetric(vertical: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CommonText.text(
                                          "Blood Pressure",
                                          fontFamily: "Manrope",
                                          fontSize: AppDimensions.font(14),
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.blackColor,
                                        ),
                                        SizedBox(
                                          height: AppDimensions.height(5),
                                        ),
                                        SvgPicture.asset(
                                          AppAssets.bHeartAssets,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: AppDimensions.height(10)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        CommonText.text(
                                          homeController
                                                  .wellnessModel
                                                  .value
                                                  .bloodPressure ??
                                              "No result",
                                          fontFamily: "Manrope",
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

                                        SizedBox(width: AppDimensions.width(5)),

                                        CommonText.text(
                                          "bpm",
                                          fontFamily: "Manrope",
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
                          ),
                          // const MenuCard(
                          //   menuTitle: "Voice Scan",
                          //   image: AppAssets.voiceScan,
                          // ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppDimensions.height(15)),
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
                            assController.isFromHomeScreen(true);
                            AppNavigation.to(AppRoutes.phqResultScreen);
                          },
                          child: CommonCard(
                            color: AppColors.homeCardColor,
                            widget: SizedBox(
                              height: AppDimensions.height(149),
                              // height: AppDimensions.height(71),
                              width: Get.width,
                              child: Padding(
                                padding: AppDimensions.symmetric(vertical: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CommonText.text(
                                      "Anxiety",
                                      fontFamily: "Manrope",
                                      fontSize: AppDimensions.font(14),
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.blackColor,
                                    ),
                                    SizedBox(height: AppDimensions.height(5)),
                                    SizedBox(
                                      height: AppDimensions.height(32),
                                      width: AppDimensions.width(32),
                                      child: SvgPicture.asset(
                                        height: 22,
                                        width: 22,
                                        AppAssets.anxietyAssets,
                                      ),
                                    ),
                                    SizedBox(height: AppDimensions.height(20)),
                                    CommonText.text(
                                      assController
                                                  .anxietyResponse
                                                  .value
                                                  .clinicalData ==
                                              "N/A"
                                          ? "No Data"
                                          : assController
                                                  .anxietyResponse
                                                  .value
                                                  .clinicalData ??
                                              "",
                                      fontFamily: "Manrope",
                                      fontSize: AppDimensions.font(14),
                                      fontWeight: FontWeight.w700,
                                      color: _getColor(
                                        assController
                                                .anxietyResponse
                                                .value
                                                .clinicalData ??
                                            "",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // const MenuCard(
                          //   menuTitle: "Voice Scan",
                          //   image: AppAssets.voiceScan,
                          // ),
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
                            assController.isFromHomeScreen(true);
                            AppNavigation.to(AppRoutes.phqResultScreen);
                          },
                          child: CommonCard(
                            color: AppColors.homeCardColor,
                            widget: SizedBox(
                              height: AppDimensions.height(149),
                              // height: AppDimensions.height(71),
                              width: Get.width,
                              child: Padding(
                                padding: AppDimensions.symmetric(vertical: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CommonText.text(
                                      "Depression",
                                      fontFamily: "Manrope",
                                      fontSize: AppDimensions.font(14),
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.blackColor,
                                    ),
                                    SizedBox(height: AppDimensions.height(5)),
                                    SizedBox(
                                      height: AppDimensions.height(32),
                                      width: AppDimensions.width(32),
                                      child: SvgPicture.asset(
                                        height: 22,
                                        width: 22,
                                        AppAssets.depressionAssets,
                                      ),
                                    ),
                                    SizedBox(height: AppDimensions.height(20)),
                                    CommonText.text(
                                      assController
                                                  .depressionResponse
                                                  .value
                                                  .clinicalData ==
                                              "N/A"
                                          ? "No Data"
                                          : assController
                                                  .depressionResponse
                                                  .value
                                                  .clinicalData ??
                                              "",
                                      fontFamily: "Manrope",
                                      fontSize: AppDimensions.font(14),
                                      fontWeight: FontWeight.w700,
                                      color: _getColor(
                                        assController
                                                .depressionResponse
                                                .value
                                                .clinicalData ??
                                            "",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // const MenuCard(
                          //   menuTitle: "Voice Scan",
                          //   image: AppAssets.voiceScan,
                          // ),
                        ),
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: AppDimensions.height(15)),
                // homeController.wellnessModel.value.bloodPressureStatus != null
                //     ? CommonCard(
                //       color: AppColors.homeCardColor,
                //       widget: SizedBox(
                //         height: AppDimensions.height(71),
                //         width: Get.width,
                //         child: Padding(
                //           padding: AppDimensions.symmetric(vertical: 5),
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             mainAxisSize: MainAxisSize.min,
                //             children: [
                //               Column(
                //                 crossAxisAlignment: CrossAxisAlignment.center,
                //                 children: [
                //                   CommonText.text(
                //                     "Blood Pressure",
                //                     fontFamily: "DM Sans",
                //                     fontSize: AppDimensions.font(14),
                //                     fontWeight: FontWeight.w700,
                //                     color: AppColors.primary,
                //                   ),
                //                   SizedBox(height: AppDimensions.height(5)),
                //                   SvgPicture.asset(AppAssets.bHeartAssets),
                //                 ],
                //               ),
                //               Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   CommonText.text(
                //                     homeController
                //                         .wellnessModel
                //                         .value
                //                         .bloodPressure
                //                         .toString(),
                //                     fontFamily: "DM Sans",
                //                     fontSize: AppDimensions.font(24),
                //                     fontWeight: FontWeight.w700,
                //                     color: HomeHalper().getBloodColor(
                //                       homeController
                //                           .wellnessModel
                //                           .value
                //                           .bloodPressureStatus
                //                           .toString(),
                //                     ),
                //                   ),

                //                   CommonText.text(
                //                     "bpm",
                //                     fontFamily: "DM Sans",
                //                     fontSize: AppDimensions.font(14),
                //                     fontWeight: FontWeight.w400,
                //                     color: AppColors.blackColor,
                //                   ),
                //                 ],
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     )
                //     : SizedBox.shrink(),
              ],
            ),
          ),
        );
      }),
    );
  }

  Color _getColor(String score) {
    final lower = score.toLowerCase();
    if (lower.contains('normal') || lower.contains('minimal')) {
      return const Color(0xFF66BB6A);
    } else if (lower.contains('mild')) {
      return const Color(0xFFFFA726);
    } else if (lower.contains('moderate')) {
      return const Color(0xFFFFA726);
    } else if (lower.contains('severe')) {
      return const Color(0xFFEF5350);
    }
    return Colors.grey;
  }
}
