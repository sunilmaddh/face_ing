import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/dialog/common_date_picker.dart';
import 'package:ntt_data/core/utils/dialog/common_dialog.dart';
import 'package:ntt_data/modules/views/vital_graph/controller/vital_graph_controller.dart';
import 'package:ntt_data/modules/views/vital_graph/helper/vital_grapgh_helper.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';
import 'package:intl/intl.dart';

class FirstLineVitalWidget extends StatelessWidget {
  FirstLineVitalWidget({super.key, required this.guestId});

  final String guestId;
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
            children: [
              Obx(
                () => CommonText.text(
                  _vitalGraphController.vitalGraphResponse.value.dateRange ??
                      '',
                  fontWeight: FontWeight.bold,
                  fontSize: AppDimensions.font(21),
                ),
              ),

              15.horizontalSpace,
              InkWell(
                onTap: () async {
                  if (_vitalGraphController.isGraphFilterType.value ==
                      "Monthly") {
                    CommonDialog().showMonthYearPickerDialog(
                      context,

                      onTop: (String month, String year) {
                        _vitalGraphController.monthIndex.value = month;
                        _vitalGraphController.yearIndex.value = year;
                        _vitalGraphController.monthYearDate.value =
                            "$year/$month";
                        final formatted =
                            _vitalGraphController.monthYearDate.value;

                        _vitalGraphController.selectedMonthDate.value =
                            formatted;

                        if (guestId.isNotEmpty) {
                          VitalGraphHelper().callForGuestWithDateRange(
                            "4W",
                            formatted,
                            guestId,
                            true,
                          );
                        } else {
                          VitalGraphHelper().callForUserWithDateRange(
                            "4W",
                            formatted,
                          );
                        }
                      },
                      month: _vitalGraphController.monthIndex.value,
                      year: _vitalGraphController.yearIndex.value,
                      controller: _vitalGraphController,
                    );
                  } else {
                    late DateTime date;

                    // ✅ Parse only if selectedDate has a value
                    if (_vitalGraphController.selectedDate.value.isNotEmpty) {
                      try {
                        // Your selectedDate format = yyyy/MM/dd
                        date = DateFormat(
                          "yyyy/MM/dd",
                        ).parse(_vitalGraphController.selectedDate.value);
                      } catch (e) {
                        // fallback to today if parsing fails
                        date = DateTime.now();
                      }
                    } else {
                      // First time opening calendar -> use today
                      date = DateTime.now();
                    }

                    // Build YYYY/MM for API
                    String calDate = DateFormat(
                      'yyyy/MM',
                    ).format(_vitalGraphController.calenderDate.value);

                    // Call calendar API
                    await VitalGraphHelper().callForCalenderWithDateRange(
                      "4W",
                      calDate,
                      null,
                    );

                    // Show date picker
                    showCommonDatePicker(
                      // ignore: use_build_context_synchronously
                      context: context,
                      onMonthChanged: (newDate, updateState) {
                        _vitalGraphController.onMonthChangeInCalender(
                          newDate,
                          updateState,
                        );
                      },
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                      initialDate: date,
                      eventMap: _vitalGraphController.eventMap,
                      onDateSelected: (DateTime selectedDate) async {
                        // Convert selected date to your required format: yyyy/MM/dd
                        String formattedDate = DateFormat(
                          'yyyy/MM/dd',
                        ).format(selectedDate);

                        _vitalGraphController.selectedDate.value =
                            formattedDate;

                        if (guestId.isNotEmpty) {
                          await VitalGraphHelper().callForGuestWithDateRange(
                            "7D",
                            formattedDate,
                            guestId,
                            true,
                          );
                        } else {
                          await VitalGraphHelper().callForUserWithDateRange(
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
                  child: const Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
