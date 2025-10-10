import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/widgets/common_list_card.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class CommonSelectableList extends StatelessWidget {
  CommonSelectableList({
    super.key,
    required this.title,
    required this.items,
    required this.onSelectionChanged,
    this.initialSelected = const [],
    this.isMultiSelect = true,
    this.spacing = 8.0,
    this.titleColor,
  });

  final String title;
  final List<dynamic> items;
  final List<int> initialSelected;
  final bool isMultiSelect;
  final double spacing;
  final Color? titleColor;
  final Function(List<dynamic> selectedValues) onSelectionChanged;

  final RxList<int> selectedIndices = <int>[].obs;

  @override
  Widget build(BuildContext context) {
    // Initialize once (when widget first built)
    selectedIndices.assignAll(initialSelected);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppDimensions.height(20)),
        CommonText.text(
          title,
          color: titleColor ?? AppColors.primary,
          fontSize: AppDimensions.font(16),
          fontWeight: FontWeight.w700,
        ),
        SizedBox(height: AppDimensions.height(20)),
        ListView.builder(
          itemCount: items.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(spacing),
              child: Obx(() {
                bool isSelected = selectedIndices.contains(index);

                return InkWell(
                  onTap: () {
                    if (isMultiSelect) {
                      if (isSelected) {
                        selectedIndices.remove(index);
                      } else {
                        selectedIndices.add(index);
                      }
                    } else {
                      selectedIndices.assignAll([index]);
                    }

                    onSelectionChanged(
                      selectedIndices.map((i) => items[i]).toList(),
                    );
                  },
                  child: CommonListCard(
                    text: items[index],
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
