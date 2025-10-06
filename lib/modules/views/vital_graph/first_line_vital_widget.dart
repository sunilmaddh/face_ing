import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/dialog/common_date_picker.dart';
import 'package:ntt_data/core/utils/dialog/common_dialog.dart';
import 'package:ntt_data/modules/views/vital_graph/controller/vital_graph_controller.dart';
import 'package:ntt_data/modules/views/vital_graph/helper/vital_grapgh_helper.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

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
          InkWell(
            onTap: () {
              if (_vitalGraphController.isGraphFilterType.value == "Today") {
                showCommonDatePicker(
                  context: context,
                  firstDate: DateTime(2025),
                  lastDate: DateTime.now(),
                  onDateSelected: (DateTime selectedDate) {
                    String formattedDate = DateFormat(
                      'yyyy/MM/dd',
                    ).format(selectedDate);

                    if (guestId.isNotEmpty) {
                      VitalGraphHelper().callForGuestWithDateRange(
                        "1D",
                        formattedDate,
                        guestId,
                        true,
                      );
                    } else {
                      VitalGraphHelper().callForUserWithDateRange(
                        "1D",
                        formattedDate,
                      );
                    }
                  },
                );
              } else if (_vitalGraphController.isGraphFilterType.value ==
                  "Monthly") {
                CommonDialog().showMonthYearPickerDialog(
                  context,
                  onTop: (String month, String year) {
                    if (guestId.isNotEmpty) {
                      VitalGraphHelper().callForGuestWithDateRange(
                        "4W",
                        "$year/$month",
                        guestId,
                        true,
                      );
                    } else {
                      VitalGraphHelper().callForUserWithDateRange(
                        "4W",
                        "$year/$month",
                      );
                    }
                  },
                );
              } else {
                showCommonDatePicker(
                  context: context,
                  firstDate: DateTime(2025),
                  lastDate: DateTime.now(),
                  onDateSelected: (DateTime selectedDate) {
                    String formattedDate = DateFormat(
                      'yyyy/MM/dd',
                    ).format(selectedDate);

                    if (guestId.isNotEmpty) {
                      VitalGraphHelper().callForGuestWithDateRange(
                        "7D",
                        formattedDate,
                        guestId,
                        true,
                      );
                    } else {
                      VitalGraphHelper().callForUserWithDateRange(
                        "7D",
                        formattedDate,
                      );
                    }
                  },
                );
              }
            },
            child: Container(
              padding: AppDimensions.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.calendar_month_outlined, color: Colors.white),
              // Text(
              //   _vitalGraphController.isGraphFilterType.value,
              //   style: TextStyle(color: AppColors.btntext),
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
