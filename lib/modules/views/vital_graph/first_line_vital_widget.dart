import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/vital_graph/controller/vital_graph_controller.dart';
import 'package:ntt_data/modules/views/vital_graph/helper/vital_grapgh_helper.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';
import 'package:ntt_data/widgets/menu/custom_dropdown_menu.dart';
import 'package:ntt_data/widgets/menu/indo_custom_data_picker_ranger.dart';

// ignore: must_be_immutable
class FirstLineVitalWidget extends StatelessWidget {
  FirstLineVitalWidget({super.key, t, required this.guestId});

  final String guestId;

  DateTime firstDate = DateTime(2025);
  DateTime lastDate = DateTime.now();

  final _vitalGraphController = Get.find<VitalGraphController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppDimensions.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonText.text("Select Vital", fontWeight: FontWeight.w400),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Obx(
                () => CustomDropdownMenu(
                  selectedValue: _vitalGraphController.selectedValue.value,
                  onSelectionChanged: (v) {
                    _vitalGraphController.selectedValue.value = v;
                    VitalGraphHelper().callForGuestWithFilter(
                      _vitalGraphController.selectedValue.value,
                      guestId,
                      false,
                    );
                  },
                  onTap: () {},
                  items: VitalGraphHelper().filterTypeList,
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () async {
                  showDialog<CustomDateRangePicker>(
                    context: context,
                    builder:
                        (context) => IndoCustomDateRangePicker(
                          primaryColor: AppColors.primary,
                          backgroundColor: AppColors.btntext,
                          onApplyClick: (v, v2) {
                            VitalGraphHelper().callForGuestWithDateRange(
                              v.toString(),
                              v2.toString(),
                              guestId,
                              false,
                            );
                          },
                          minimumDate: firstDate,
                          onCancelClick: () {},
                          maximumDate: lastDate,
                          initialStartDate: DateTime.now(),
                        ),
                  );
                },
                icon: Icon(Icons.date_range),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
