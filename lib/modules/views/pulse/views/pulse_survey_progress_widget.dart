import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/modules/views/pulse/controller/pulse_survey_controller.dart';
import 'package:ntt_data/modules/views/pulse/helper/pulse_helper.dart';
import 'package:ntt_data/modules/views/pulse/widget/pulse_survey_page_view_builder.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';

class PulseSurveyProgressWidget extends StatelessWidget {
  PulseSurveyProgressWidget({super.key});

  final PulseSurveyController _controller = Get.find<PulseSurveyController>();

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
          child: PulseSurveyPageViewBuilder(
            pages: PulseHelper.pulseServeQuestionList,
            pulseSurveyController: _controller,
          ),
        ),
      ),
    );
  }
}
