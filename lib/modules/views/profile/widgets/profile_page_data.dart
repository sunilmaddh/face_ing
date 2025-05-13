import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/modules/views/auth/auth_controller.dart'
    show AuthController;
import 'package:ntt_data/widgets/common_list_card.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class ProfilePageData extends StatelessWidget {
  ProfilePageData({
    super.key,
    required this.text,
    required this.list,
    required this.id,
    required this.authController,
    required this.question,
  });

  final String text;
  final List<dynamic> list;
  final RxList<int> selectedIndices = <int>[].obs; // Track multiple selections
  final String id;
  final String question;
  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: AppDimensions.height(30)),
        CommonText.text(
          text,
          color: AppColors.primary,
          fontSize: AppDimensions.font(16),
          fontWeight: FontWeight.w700,
          maxLines: 3,
        ),
        SizedBox(height: AppDimensions.height(30)),
        ListView.builder(
          itemCount: list.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(() {
                bool isSelected = selectedIndices.contains(index);
                return InkWell(
                  onTap: () {
                    if (isSelected) {
                      selectedIndices.remove(index);
                    } else {
                      selectedIndices.add(index);
                    }
                    authController.storeQuestionAnswer(
                      id,
                      question,
                      selectedIndices.map((i) => list[i]).toList(),
                    );
                  },
                  child: CommonListCard(
                    text: list[index],
                    index: index, // Pass normal int instead of RxInt
                    selectedIndices: selectedIndices, // Pass the RxList
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
