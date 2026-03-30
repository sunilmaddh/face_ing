import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_strings.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/home/controller/home_controller.dart';
import 'package:ntt_data/modules/home/helper/home_helper.dart';
import 'package:ntt_data/modules/home/widget/menu_card.dart';
import 'package:ntt_data/modules/phq/controllers/assessment_controller.dart';
import 'package:ntt_data/modules/pulse/controller/pulse_survey_controller.dart';
import 'package:ntt_data/modules/pulse/helper/pulse_helper.dart';
import 'package:ntt_data/modules/pulse/models/pulse_survey_model.dart';
import 'package:ntt_data/modules/pulse/views/pulse_screen.dart';
import 'package:ntt_data/modules/pulse/widget/pulse_line_chart_widget.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class MenuCardWidget extends StatelessWidget {
  MenuCardWidget({super.key});

  final HomeController homeController = Get.find<HomeController>();
  final PulseSurveyController pulseController =
      Get.find<PulseSurveyController>();
  final AssessmentController assController = Get.find<AssessmentController>();

  final PulseHelper pulseHelper = PulseHelper();
  final HomeHalper homeHelper = HomeHalper();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppDimensions.symmetric(horizontal: 16),
      child: Obx(() {
        final pulseModel = pulseController.pulseSevryModel.value;
        final status = pulseModel.status?.toString() ?? "";

        final List<PulseSurveyList> pulseList =
            pulseModel.xAxis != null && pulseModel.result != null
                ? pulseHelper.normalizeHealthData(
                  pulseModel.xAxis!,
                  pulseModel.result!,
                )
                : <PulseSurveyList>[];

        final List<String> xAxis =
            pulseModel.xAxis != null
                ? pulseHelper.formatXAxis(pulseModel.xAxis!)
                : <String>[];

        final Color statusColor = pulseHelper.getColor(status);

        final String anxietyText =
            assController.anxietyResponse.value.clinicalData == "N/A"
                ? "No Data"
                : (assController.anxietyResponse.value.clinicalData ?? "");

        final String depressionText =
            assController.depressionResponse.value.clinicalData == "N/A"
                ? "No Data"
                : (assController.depressionResponse.value.clinicalData ?? "");

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
                                    status.isNotEmpty
                                        ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 15.h),
                                            PulseLineChartWidget(
                                              height: 50,
                                              bottomTitles: xAxis,
                                              vitalValues: pulseList,
                                            ),
                                            SizedBox(height: 10.h),
                                            CommonText.labelMedium(
                                              AppStrings.latestResult,

                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xff898989),
                                            ),
                                            SizedBox(height: 5.h),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  pulseHelper.getImage(status),
                                                  width: 24.w,
                                                  height: 24.h,
                                                  color: statusColor,
                                                ),
                                                SizedBox(width: 10.w),
                                                CommonText.titleMedium(
                                                  status,

                                                  fontWeight: FontWeight.w700,
                                                  color: statusColor,
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                        : const MenuCard(
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
                          onTap: () {},
                          child: CommonCard(
                            color: AppColors.homeCardColor,
                            widget: SizedBox(
                              height: AppDimensions.height(149),
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
                                        CommonText.labelLarge(
                                          "Blood Pressure",

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
                                        CommonText.displaySmall(
                                          homeController
                                                  .wellnessModel
                                                  .value
                                                  ?.bloodPressure ??
                                              "No result",

                                          color: homeHelper.getBloodColor(
                                            homeController
                                                    .wellnessModel
                                                    .value
                                                    ?.bloodPressureStatus ??
                                                "",
                                          ),
                                        ),
                                        SizedBox(width: AppDimensions.width(5)),
                                        CommonText.labelLarge(
                                          "bpm",
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
                              width: Get.width,
                              child: Padding(
                                padding: AppDimensions.symmetric(vertical: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CommonText.labelLarge(
                                      "Anxiety",

                                      fontWeight: FontWeight.w700,
                                      color: AppColors.blackColor,
                                    ),
                                    SizedBox(height: AppDimensions.height(5)),
                                    SizedBox(
                                      height: AppDimensions.height(32),
                                      width: AppDimensions.width(32),
                                      child: SvgPicture.asset(
                                        AppAssets.anxietyAssets,
                                        height: 22,
                                        width: 22,
                                      ),
                                    ),
                                    SizedBox(height: AppDimensions.height(20)),
                                    CommonText.labelLarge(
                                      anxietyText,

                                      fontWeight: FontWeight.w700,
                                      color: _getColor(anxietyText),
                                    ),
                                  ],
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
                            assController.isFromHomeScreen(true);
                            AppNavigation.to(AppRoutes.phqResultScreen);
                          },
                          child: CommonCard(
                            color: AppColors.homeCardColor,
                            widget: SizedBox(
                              height: AppDimensions.height(149),
                              width: Get.width,
                              child: Padding(
                                padding: AppDimensions.symmetric(vertical: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CommonText.labelLarge(
                                      "Depression",

                                      fontWeight: FontWeight.w700,
                                      color: AppColors.blackColor,
                                    ),
                                    SizedBox(height: AppDimensions.height(5)),
                                    SizedBox(
                                      height: AppDimensions.height(32),
                                      width: AppDimensions.width(32),
                                      child: SvgPicture.asset(
                                        AppAssets.depressionAssets,
                                        height: 22,
                                        width: 22,
                                      ),
                                    ),
                                    SizedBox(height: AppDimensions.height(20)),
                                    CommonText.labelLarge(
                                      depressionText,
                                      fontWeight: FontWeight.w700,
                                      color: _getColor(depressionText),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
