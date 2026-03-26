import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/base/base_view.dart';
import 'package:ntt_data/modules/pulse/controller/pulse_survey_controller.dart';
import 'package:ntt_data/modules/pulse/widget/pulse_survey_page_view_builder.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/custom_shimmer.dart/shimmer_widget.dart';

class PulseSurveyProgressWidget extends BaseView<PulseSurveyController> {
  const PulseSurveyProgressWidget({super.key});

  @override
  bool get useDefaultLoader => false;

  @override
  void onInit(PulseSurveyController controller) {
    controller.getPulseQuetionList();
  }

  @override
  Widget buildView(BuildContext context, PulseSurveyController controller) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        onTop: AppNavigation.back,
        title: "Pulse Survey Progress",
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Obx(() {
            if (controller.isPulseQuestionListLoading.isTrue) {
              return ShimmerLoadingScreen(
                widget: PulseQuestionShimmerListItem(),
                itemCount: 8,
              );
            }

            return PulseSurveyPageViewBuilder(
              pages: controller.pulseQuestionList,
              pulseSurveyController: controller,
            );
          }),
        ),
      ),
    );
  }
}
