import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/modules/views/pulse/controller/pulse_survey_controller.dart';
import 'package:ntt_data/modules/views/pulse/helper/pulse_helper.dart';
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
  final RxInt selectedIndex = (-1).obs; // Track single selection
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

        /// List of selectable options
        ListView.builder(
          itemCount: list.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Obx(() {
                bool isSelected = selectedIndex.value == index;

                return InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    selectedIndex.value = index;
                    pulseController.storeQuestionAnswer(
                      id,
                      question,
                      list[index],
                    );
                    pulseController.isEnable.value = true;
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: AppColors.selectedList,
                      borderRadius: BorderRadius.circular(16),
                      // gradient:
                      //     isSelected
                      //         ? const LinearGradient(
                      //           colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                      //         )
                      //         : null,
                      border:
                          isSelected
                              ? null
                              : Border.all(
                                color: AppColors.borderColor,
                                width: 1.5,
                              ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(2), // border thickness
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? AppColors.selectedList
                                : AppColors.btntext,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(
                          list[index].toString(),
                          style: TextStyle(
                            color:
                                isSelected ? AppColors.primary : Colors.black87,
                            fontWeight:
                                isSelected ? FontWeight.w700 : FontWeight.w500,
                            fontSize: AppDimensions.font(15),
                          ),
                        ),
                      ),
                    ),
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
