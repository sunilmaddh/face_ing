import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/pulse/controller/pulse_survey_controller.dart';
import 'package:ntt_data/widgets/common_list_card.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class PulsePageDataWidget extends StatelessWidget {
  PulsePageDataWidget({
    super.key,
    required this.text,
    required this.list,
    required this.id,
    required this.pulseController,
    required this.question,
  });

  final String text;
  final List<dynamic> list;
  final RxList<int> selectedIndices = <int>[].obs; // Track multiple selections
  final String id;
  final String question;
  final PulseSurveyController pulseController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: AppDimensions.height(40)),
        CommonText.text(
          text,
          color: AppColors.primary,
          fontSize: AppDimensions.font(16),
          fontWeight: FontWeight.w700,
          maxLines: 5,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppDimensions.height(60)),
        ListView.builder(
          itemCount: list.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Obx(() {
                bool isSelected = selectedIndices.contains(index);
                return InkWell(
                  onTap: () {
                    if (isSelected) {
                      selectedIndices.remove(index);
                    } else {
                      selectedIndices.add(index);
                    }
                  },
                  child: CommonListCard(
                    text: list[index],
                    index: index,
                    selectedIndices: selectedIndices,
                  ),
                );
              }),
            );
          },
        ),
      ],
    );
  }
}
