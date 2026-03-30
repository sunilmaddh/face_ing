import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/dialog/common_date_picker.dart';
import 'package:ntt_data/core/utils/dialog/common_dialog.dart';
import 'package:ntt_data/modules/vital_graph/controller/vital_graph_controller.dart';
import 'package:ntt_data/modules/vital_graph/helper/vital_grapgh_helper.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';
import 'package:intl/intl.dart';

class FirstLineVitalWidget extends StatelessWidget {
  FirstLineVitalWidget({super.key, required this.guestId});

  final String guestId;
  final VitalGraphController controller = Get.find<VitalGraphController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppDimensions.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonText.text("Select Vital", fontWeight: FontWeight.w400),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => CommonText.headlineMedium(
                  controller.vitalGraphResponse.value.dateRange ?? '',
                  fontWeight: FontWeight.bold,
                ),
              ),

              15.horizontalSpace,

              InkWell(
                onTap: () => _handleDateSelection(context),
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

  Future<void> _handleDateSelection(BuildContext context) async {
    if (controller.isGraphFilterType.value == "Monthly") {
      _handleMonthlyPicker(context);
    } else {
      await _handleCalendarPicker(context);
    }
  }

  void _handleMonthlyPicker(BuildContext context) {
    CommonDialog().showMonthYearPickerDialog(
      context,
      onTop: (String month, String year) {
        controller.monthIndex.value = month;
        controller.yearIndex.value = year;

        final formatted = "$year/$month";

        controller.monthYearDate.value = formatted;
        controller.selectedMonthDate.value = formatted;

        if (guestId.isNotEmpty) {
          VitalGraphHelper().callForGuestWithDateRange(
            "4W",
            formatted,
            guestId,
            true,
          );
        } else {
          VitalGraphHelper().callForUserWithDateRange("4W", formatted);
        }
      },
      month: controller.monthIndex.value,
      year: controller.yearIndex.value,
      controller: controller,
    );
  }

  Future<void> _handleCalendarPicker(BuildContext context) async {
    DateTime initialDate;

    if (controller.selectedDate.value.isNotEmpty) {
      try {
        initialDate = DateFormat(
          "yyyy/MM/dd",
        ).parse(controller.selectedDate.value);
      } catch (_) {
        initialDate = DateTime.now();
      }
    } else {
      initialDate = DateTime.now();
    }

    final calDate = DateFormat('yyyy/MM').format(controller.calendarDate.value);

    await VitalGraphHelper().callForCalenderWithDateRange("4W", calDate, null);

    showCommonDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      eventMap: controller.eventMap,

      onMonthChanged: (newDate, updateState) {
        controller.onMonthChangeInCalendar(newDate, updateState);
      },

      onDateSelected: (DateTime selectedDate) async {
        final formattedDate = DateFormat('yyyy/MM/dd').format(selectedDate);

        controller.selectedDate.value = formattedDate;

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
}
