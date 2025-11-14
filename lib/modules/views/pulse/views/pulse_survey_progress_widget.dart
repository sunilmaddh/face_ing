import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/modules/views/pulse/controller/pulse_survey_controller.dart';
import 'package:ntt_data/modules/views/pulse/widget/pulse_survey_page_view_builder.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/custom_shimmer.dart/shimmer_widget.dart';

class PulseSurveyProgressWidget extends StatefulWidget {
const PulseSurveyProgressWidget({super.key});

  @override
  State<PulseSurveyProgressWidget> createState() =>
      _PulseSurveyProgressWidgetState();
}

class _PulseSurveyProgressWidgetState extends State<PulseSurveyProgressWidget> {
  final _controller = Get.find<PulseSurveyController>();

  @override
  void initState() {
    _controller.getPulseQuetionList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        onTop: () {
          AppNavigation.back();
        },
        title: "Pulse Survey Progress",
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Obx(
            () =>
                _controller.isPulseQuestionListLoading.isTrue
                    ? ShimmerLoadingScreen(
                      widget: PulseQuestionShimmerListItem(),
                      itemCount: 8,
                    )
                    : PulseSurveyPageViewBuilder(
                      pages: _controller.pulseQuestionList,
                      pulseSurveyController: _controller,
                    ),
          ),
        ),
      ),
    );
  }
}
