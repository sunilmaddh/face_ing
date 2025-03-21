import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/widgets/common_list_card.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class ProfilePageData extends StatelessWidget {
  ProfilePageData({super.key, required this.text, required this.list});

  final String text;
  final List<dynamic> list;
  final RxInt currentIndex = (-1).obs; // Make currentIndex reactive

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
              child: InkWell(
                onTap: () {
                  currentIndex.value = index; // Update reactive value
                },
                child: CommonListCard(
                      text: list[index],
                      index: index.obs, // Convert to RxInt
                      currentIndex: currentIndex, // Pass reactive currentIndex
                    
                    ),
              ),
            );
          },
        ),
      ],
    );
  }
}
