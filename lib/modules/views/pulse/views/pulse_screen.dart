import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/pulse/controller/pulse_survey_controller.dart';
import 'package:ntt_data/modules/views/pulse/helper/pulse_helper.dart';
import 'package:ntt_data/modules/views/pulse/views/pulse_health_status.dart';
import 'package:ntt_data/modules/views/pulse/widget/pulse_line_chart.dart';
import 'package:ntt_data/widgets/custom_shimmer.dart/shimmer_widget.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class PulseScreen extends StatefulWidget {
  const PulseScreen({super.key});

  @override
  State<PulseScreen> createState() => _PulseScreenState();
}

class _PulseScreenState extends State<PulseScreen> {
  final _controller = Get.find<PulseSurveyController>();

  @override
  void initState() {
    _controller.fetchPulseSurvey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: CommonText.text(
          "Pulse History",
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
        ),
      ),

      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Obx(() {
          final status = _controller.pulseSevryModel.value.status;
          final color = PulseHelper().getColor(status.toString());
          return _controller.isPulseSurveryLoading.isTrue
              ? ShimmerLoadingScreen(
                widget: PulseShimmerListItem(),
                itemCount: 3,
              )
              : _controller.pulseSurveyADayList.isEmpty 
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: AppDimensions.width(300),
                    child: LottieBuilder.asset(
                      AppAssets.allReport,
                      fit: BoxFit.fill,
                      repeat: true,
                    ),
                  ),
                  CommonText.text("No data available", fontSize: 24.sp),
                ],
              )
              : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: AppColors.btntext,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        10.verticalSpace,
                        CommonText.text(
                          AppConstents.todayResult,
                          fontSize: AppDimensions.font(14),
                          fontWeight: FontWeight.w700,
                          color: Color(0xff898989),
                        ),

                        _controller.pulseSevryModel.value.status
                                .toString()
                                .isEmpty
                            ? SizedBox.shrink()
                            : CommonText.text(
                              _controller.pulseSevryModel.value.status
                                  .toString(),
                              fontSize: AppDimensions.font(46),
                              fontWeight: FontWeight.w700,
                              color: color,
                            ),

                        // 10.verticalSpace,
                      ],
                    ),
                  ),

                  Container(
                    width: Get.width,
                    height: MediaQuery.of(context).size.height - 250.h,
                    padding: AppDimensions.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xffF5F5F5),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Column(
                      children: [
                        PulseHealthStatus(
                          pulseSurveyADay: _controller.pulseSurveyADayList,
                        ),
                        15.verticalSpace,
                        PulseLineChart(
                          pulseServeyModel: _controller.pulseSevryModel.value,
                        ),
                      ],
                    ),
                  ),
                ],
              );
        }),
      ),
    );
  }
}
