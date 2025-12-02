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

              // Obx(() {
              //   String displayText = "";
              //   if (_vitalGraphController.selectedDate.value.isNotEmpty) {
              //     try {
              //       DateTime parsed;
              //       if (_vitalGraphController.isGraphFilterType.value ==
              //           "Monthly") {
              //         parsed = DateFormat(
              //           "yyyy/MM",
              //         ).parse(_vitalGraphController.selectedDate.value);
              //       } else {
              //         parsed = DateFormat(
              //           "yyyy/MM/dd",
              //         ).parse(_vitalGraphController.selectedDate.value);
              //       }
              //       displayText = DateFormat("yyyy-MMM").format(parsed);
              //     } catch (_) {}
              //   }
              //   if (displayText.isEmpty &&
              //       _vitalGraphController.vitalGraphResponse.value.dateRange !=
              //           null) {
              //     try {
              //       DateTime parsedFallback = DateFormat("yyyy/MM").parse(
              //         _vitalGraphController.vitalGraphResponse.value.dateRange
              //             .toString(),
              //       );
              //       displayText = DateFormat("yyyy-MMM").format(parsedFallback);
              //     } catch (_) {}
              //   }
              //   if (displayText.isEmpty) {
              //     DateTime now = DateTime.now();
              //     displayText = DateFormat("yyyy-MMM").format(now);
              //   }
              //   return CommonText.text(
              //     displayText,
              //     fontWeight: FontWeight.bold,
              //     fontSize: AppDimensions.font(21),
              //   );
              // }),
              15.horizontalSpace,
              InkWell(
                onTap: () async {
                  if (_vitalGraphController.isGraphFilterType.value ==
                      "Monthly") {
                    CommonDialog().showMonthYearPickerDialog(
                      context,

                      /// 🚫 Block future year & month
                      onTop: (String month, String year) {
                        final formatted = "$year/$month";
                        _vitalGraphController.selectedDate.value = formatted;

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
                    );
                  } else {
                    String calDate = '';
                    calDate = DateFormat(
                      'yyyy/MM',
                    ).format(_vitalGraphController.calenderDate.value);
                    await VitalGraphHelper().callForCalenderWithDateRange(
                      "4W",
                      calDate,
                      null,
                    );
                    showCommonDatePicker(
                      context: context,
                      onMonthChanged: (date, updateState) {
                        _vitalGraphController.onMonthChangeInCalender(
                          date,
                          updateState,
                        );
                      },
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                      initialDate: DateTime.now(),
                      onDateSelected: (DateTime selectedDate) {
                        String formattedDate = DateFormat(
                          'yyyy/MM/dd',
                        ).format(selectedDate);

                        _vitalGraphController.selectedDate.value =
                            formattedDate;

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
                      eventMap: _vitalGraphController.eventMap,
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
