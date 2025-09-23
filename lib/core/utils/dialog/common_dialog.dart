import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_text_styles.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/widgets/button/primary_button.dart';
import 'package:ntt_data/widgets/cards/common_dialog_card.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';
import 'package:ntt_data/widgets/fields/custom_form_field.dart';

class CommonDialog {
  void showFullWidthDialog({
    required String title,
    required VoidCallback onPressed,
    required TextEditingController textController,
    RxBool? isLoading,
  }) {
    final formKey = GlobalKey<FormState>();
    final RxBool loading =
        isLoading ?? false.obs; // Ensure proper RxBool handling

    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          width: Get.width,
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonText.text(
                  title,
                  fontSize: AppDimensions.font(16),
                  fontWeight: FontWeight.w500,
                  fontFamily: AppTextStyles.fontFamily,
                ),
                const SizedBox(height: 30),
                CustomFormField(
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return "Please enter email ID";
                    }
                    return null;
                  },
                  label: "Email",
                  hint: "Please enter email ID",
                  controller: textController,
                ),
                const SizedBox(height: 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text("Close"),
                    ),
                    Obx(
                      () => PrimaryButton(
                        isLoading: loading.value,
                        text: 'Get OTP',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            loading.value = true; // Show loading state
                            onPressed();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static Future<void> openDatePicker({
    required BuildContext context,
    required TextEditingController dateController,
  }) async {
    BottomPicker.date(
      closeWidget: InkWell(
        onTap: () {
          Get.back();
        },
        child: SvgPicture.asset(AppAssets.cloaseDialog),
      ),
      pickerTitle: Text(
        'Select your Birthday',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: AppColors.backArrowColor,
        ),
      ),
      dateOrder: DatePickerDateOrder.dmy,
      initialDateTime: DateTime.now(),
      maxDateTime: DateTime.now(),
      minDateTime: DateTime(1930),
      pickerTextStyle: TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
      onChange: (index) {
        // print(index);
      },
      onSubmit: (index) {
        String formattedDate = DateFormat('yyyy/MM/dd').format(index);
        dateController.text = formattedDate;
        print(index);
      },
      onDismiss: (p0) {
        // print(p0);
      },
      bottomPickerTheme: BottomPickerTheme.plumPlate,
    ).show(context);
  }

  static void selectDate({
    required BuildContext context,
    required TextEditingController dateController,
  }) async {
    DateTime currentDate = DateTime.now();
    DateTime minDate = DateTime(1925, 1, 1);
    DateTime maxDate = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate.isBefore(maxDate) ? currentDate : maxDate,
      firstDate: minDate,
      lastDate: maxDate,
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy/MM/dd').format(pickedDate);
      dateController.text = formattedDate;
      print("Selected Date: $formattedDate");
    }
  }

  // Show delete confirmation dialog
  // Show delete confirmation dialog
  void showDeleteUserDialog({
    required BuildContext context,
    required VoidCallback onConfirm,
    required String title,
    required String message,
    required confirmText,
    bool isShowCancelButton = true,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.btntext,
          title: CommonText.text(
            title,
            maxLines: 2,
            fontSize: AppDimensions.font(18),
            fontWeight: FontWeight.w400,
            fontFamily: "Gilroy-Bold",
          ),
          content: CommonText.text(
            message,
            maxLines: 5,
            fontSize: AppDimensions.font(15),
            fontWeight: FontWeight.w400,
            fontFamily: "Gilroy-Medium",
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                    height: AppDimensions.height(40),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close dialog
                        onConfirm(); // Execute delete action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: CommonText.text(
                        confirmText,
                        color: AppColors.btntext,
                      ),
                    ),
                  ),
                ),
                isShowCancelButton
                    ? SizedBox(width: AppDimensions.width(10))
                    : SizedBox.shrink(),
                Visibility(
                  visible: isShowCancelButton,
                  child: Expanded(
                    child: SizedBox(
                      height: AppDimensions.height(40),

                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Close dialog
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.btntext,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                            side: BorderSide(color: AppColors.deleteDesColor),
                          ),
                        ),
                        child: CommonText.text(
                          "Cancel",
                          color: AppColors.backArrowColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void showScanDialog({
    required BuildContext context,
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
    required String title,
    required String message,
    required String confirmText,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppColors.btntext,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    onCancel();
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: SvgPicture.asset(AppAssets.cloaseDialog),
                  ),
                ),
                SvgPicture.asset(AppAssets.scanError),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(message, textAlign: TextAlign.center),
                const SizedBox(height: 20),
                SizedBox(
                  height: AppDimensions.height(40),

                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onConfirm();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: CommonText.text(
                      confirmText,
                      color: AppColors.btntext,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showLogoutDialog({
    required BuildContext context,
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
    required String title,
    required String message,
    required String confirmText,
    required bool isLogoutLoading,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppColors.btntext,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    onCancel();
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: SvgPicture.asset(AppAssets.cloaseDialog),
                  ),
                ),
                // SvgPicture.asset(AppAssets.scanError),
                // const SizedBox(height: 16),
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(message, textAlign: TextAlign.center),
                const SizedBox(height: 20),
                SizedBox(
                  height: AppDimensions.height(40),

                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.pop(context);
                      onConfirm();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child:
                        isLogoutLoading == true
                            ? const CircularProgressIndicator(
                              color: AppColors.primary,
                            )
                            : CommonText.text(
                              confirmText,
                              color: AppColors.btntext,
                            ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void editGuestDialog({
    required BuildContext context,
    required VoidCallback onCancel,
    required List<Map<String, String>> guestOptionList,
    required Function(String isOptionType) onConfirm,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppColors.btntext,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Close Button
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    onCancel();
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: SvgPicture.asset(AppAssets.cloaseDialog),
                  ),
                ),

                /// Scrollable Options
                ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: guestOptionList.length,
                  itemBuilder: (context, index) {
                    final option = guestOptionList[index];
                    final name = option["name"] ?? "";
                    final type = option["isOptionType"] ?? "";
                    return InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        onConfirm(type); // Return the type
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonText.text(
                              name,
                              fontSize: AppDimensions.font(16),
                              fontWeight: FontWeight.w400,
                              color: AppColors.guestOptionColor,
                              fontFamily: "Gilroy-Medium",
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.primary,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(color: Colors.grey.shade300);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showFullWidthCupertinoDatePicker({
    required BuildContext context,
    required Function(DateTime) onDateSelected,
    String title = "Select Date of birth",
    bool isNotDob = false,
  }) {
    DateTime now = DateTime.now();
    DateTime initialDate = DateTime(now.year - 18, now.month, now.day);
    DateTime selectedDate = isNotDob ? now : initialDate;
    bool isFutureDate = false;

    commonDialogCard(
      title: title,
      context: context,
      widget: CupertinoDatePicker(
        itemExtent: 50,
        mode: CupertinoDatePickerMode.date,
        dateOrder: DatePickerDateOrder.dmy,
        initialDateTime: isNotDob ? now : initialDate,
        minimumDate: DateTime(1925),
        maximumDate: DateTime(2050),
        // DateTime(
        //   DateTime.now().year - 18,
        //   DateTime.now().month,
        //   DateTime.now().day,
        // ),
        onDateTimeChanged: (DateTime newDate) {
          if (isNotDob == false) {
            if (newDate.isAfter(initialDate)) {
              AppSnackbar.show(
                isError: true,
                title: "Error",
                message: "You must be at least 18 years old",
              );
              isFutureDate = true;
            } else {
              isFutureDate = false;
              selectedDate = newDate;
            }
          } else {
            selectedDate = newDate;
          }
        },
      ),
      onConfirm: () {
        if (!isFutureDate) {
          onDateSelected(selectedDate);
        }
      },
    );
  }

  static void showFullWidthCupertinoPicker({
    required BuildContext context,
    required String title,
    required List<String> list,
    required Function(String) selectedItem,
    required String unit,
    required String defaultValue, // Add defaultValue parameter
  }) {
    int selectedIndex = list.indexOf(defaultValue);
    if (selectedIndex == -1) {
      selectedIndex = 0; // fallback if '60' not found in list
    }

    FixedExtentScrollController scrollController = FixedExtentScrollController(
      initialItem: selectedIndex,
    );

    commonDialogCard(
      title: title,
      context: context,
      widget: CupertinoPicker(
        scrollController: scrollController,
        looping: true,
        itemExtent: 50,
        squeeze: 1.0,
        diameterRatio: 2.0,
        onSelectedItemChanged: (int index) {
          selectedIndex = index;
        },
        children:
            list.map((e) {
              return Builder(
                builder: (context) {
                  return Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: e,
                        style: TextStyle(
                          fontSize: AppDimensions.font(20),
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          // TextSpan(
                          //   text: "  $unit",
                          //   style: TextStyle(
                          //     fontSize: 12,
                          //     color: Colors.black,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }).toList(),
      ),
      onConfirm: () {
        selectedItem(list[selectedIndex]);
      },
    );
  }

  static void showCupertinoDateRangePicker({
    required BuildContext context,
    required Function(DateTime start, DateTime end) onRangeSelected,
  }) {
    DateTime now = DateTime.now();
    DateTime initialDate = DateTime(now.year - 18, now.month, now.day);

    DateTime startDate = initialDate;
    DateTime endDate = initialDate;
    commonDialogCard(
      height: 500,
      title: "Select Date Range",
      context: context,
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Start Date",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.blackColor,
              fontSize: AppDimensions.font(18),
            ),
          ),
          Expanded(
            child: CupertinoDatePicker(
              itemExtent: 40,
              mode: CupertinoDatePickerMode.date,
              dateOrder: DatePickerDateOrder.dmy,
              initialDateTime: initialDate,
              minimumDate: DateTime(1925),
              maximumDate: initialDate,
              onDateTimeChanged: (DateTime newDate) {
                startDate = newDate;
              },
            ),
          ),
          const Divider(color: AppColors.historyCardColor),
          Text(
            "End Date",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.blackColor,
              fontSize: AppDimensions.font(18),
            ),
          ),
          20.verticalSpace,
          Expanded(
            child: CupertinoDatePicker(
              itemExtent: 40,
              mode: CupertinoDatePickerMode.date,
              dateOrder: DatePickerDateOrder.dmy,
              initialDateTime: initialDate,
              minimumDate: DateTime(1925),
              maximumDate: initialDate,
              onDateTimeChanged: (DateTime newDate) {
                endDate = newDate;
              },
            ),
          ),
        ],
      ),
      onConfirm: () {
        onRangeSelected(startDate, endDate);
      },
    );
  }

  Future<Map<String, dynamic>?> showMonthYearPickerDialog(
    BuildContext context, {
    required Function(String month, String year) onTop,
  }) async {
    final List<Map<String, String>> months = [
      {"monthName": "January", "value": "01"},
      {"monthName": "February", "value": "02"},
      {"monthName": "March", "value": "03"},
      {"monthName": "April", "value": "04"},
      {"monthName": "May", "value": "05"},
      {"monthName": "June", "value": "06"},
      {"monthName": "July", "value": "07"},
      {"monthName": "August", "value": "08"},
      {"monthName": "September", "value": "09"},
      {"monthName": "October", "value": "10"},
      {"monthName": "November", "value": "11"},
      {"monthName": "December", "value": "12"},
    ];
    int selectedYear = DateTime.now().year;
    int selectedMonthIndex = DateTime.now().month - 1;

    return showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppColors.btntext,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: SizedBox(
            height: 400,
            child: Column(
              children: [
                // 🔹 Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Select Month & Year",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // 🔹 Year Selector
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_left),
                        onPressed: () {
                          selectedYear--;
                          (context as Element).markNeedsBuild();
                        },
                      ),
                      Text(
                        "$selectedYear",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_right),
                        onPressed: () {
                          selectedYear++;
                          (context as Element).markNeedsBuild();
                        },
                      ),
                    ],
                  ),
                ),

                // 🔹 Months Grid
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 2,
                        ),
                    itemCount: months.length,
                    itemBuilder: (context, index) {
                      bool isSelected = index == selectedMonthIndex;
                      return GestureDetector(
                        onTap: () {
                          onTop(
                            months[index]["value"]!,
                            selectedYear.toString(),
                          );
                          Get.back();
                        },
                        // () {
                        //   // Navigator.of(context).pop({
                        //   //   "month": months[index],
                        //   //   "monthIndex": index + 1,
                        //   //   "year": selectedYear,
                        //   // });
                        // },
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? AppColors.primary
                                    : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            months[index]["monthName"].toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
