import 'package:awesome_datetime_picker/awesome_datetime_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/geust/guest_halper.dart';
import 'package:ntt_data/widgets/button/primary_button.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppConstents.deviceSize,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Face.ing',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(backgroundColor: AppColors.btntext),
        ),
        home: DemoApi(),
        initialRoute: "demo_api",
        // getPages: AppPages.getPages,
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: DemoApi(),
//     );
//   }
// }

class DemoApi extends StatelessWidget {
  DemoApi({super.key});

  final editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    final double ovalWidth = screenSize.width * 0.8;
    final double ovalHeight = screenSize.height * 0.5;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            PrimaryButton(
              text: "Ok",
              onPressed: () {
                showCupertinoPickerDialog(context);
                // showFullWidthCupertinoDatePicker(
                //   context: context,
                //   initialDate: DateTime.now(),
                //   minDate: DateTime(1930),
                //   maxDate: DateTime.now(),
                //   onDateSelected: (picked) {
                //     print("Date Picked: $picked");
                //   },
                // );
                // showCupertinoDatePickerDialog(
                //   context: context,
                //   initialDate: DateTime.now(),
                //   minDate: DateTime(2000),
                //   maxDate: DateTime(2030),
                //   onDateSelected: (selectedDate) {
                //     print("Selected date: $selectedDate");
                //   },
                // );
                // showFullWidthListDialog(
                //   context,
                //   GuestHalper.heightList,
                //   5,
                //   "Select your Height",
                // );
              },
            ),

            // SizedBox(height: 30),
            // PrimaryButton(
            //   text: "Date Picker",
            //   onPressed: () async {
            //     // showAwesomeDatePickerDialog(
            //     //   context: context,
            //     //   minDate: AwesomeDate(year: 2025, month: 2, day: 15),
            //     //   maxDate: AwesomeDate(year: 2026, month: 10, day: 10),
            //     //   onChanged: (AwesomeDate date) {
            //     //     print("Selected: ${date.day}/${date.month}/${date.year}");
            //     //   },
            //     // );
            //     await DatePicker.showSimpleDatePicker(
            //       itemTextStyle: TextStyle(
            //         fontSize: AppDimensions.font(18),
            //         fontWeight: FontWeight.w700,
            //         fontFamily: "Manrope",
            //       ),
            //       context,
            //       // initialDate: DateTime(2020),
            //       firstDate: DateTime(1930),
            //       lastDate: DateTime.now(),
            //       pickerMode: DateTimePickerMode.date,
            //       dateFormat: "dd-MMMM-yyyy",
            //       locale: DateTimePickerLocale.en_us,
            //     );
            //   },
            // ),
          ],
        ),
      ),
      //  IndoCommonCard(
      //   vitalName: "Heart rate",
      //   vitalCondition: "Avg 6-10",
      //   vitalDescription:
      //       "cdfdijodihofduhfgioffoisdhudsfhdsufsdshdshfdsihofdshdfs",
      //   vitalHeading: "Your Heart rate is low",
      // ),
    );
  }

  void showCupertinoPickerDialog(BuildContext context) {
    List<String> items = List.generate(20, (index) => 'Item ${index + 1}');
    int selectedIndex = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Select Item"),
          content: SizedBox(
            height: 150,
            child: CupertinoPicker(
              itemExtent: 32,
              onSelectedItemChanged: (int index) {
                selectedIndex = index;
              },
              children: items.map((e) => Text(e)).toList(),
            ),
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                debugPrint('Selected: ${items[selectedIndex]}');
              },
            ),
          ],
        );
      },
    );
  }

  void showFullWidthCupertinoDatePicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime minDate,
    required DateTime maxDate,
    required Function(DateTime) onDateSelected,
  }) {
    DateTime selectedDate = initialDate;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.all(
            16,
          ), // Controls margin from screen edges
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Select Date",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: AppDimensions.height(250),
                  width: double.infinity,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: initialDate,
                    minimumDate: minDate,
                    maximumDate: maxDate,
                    onDateTimeChanged: (DateTime newDate) {
                      selectedDate = newDate;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: AppDimensions.height(45),
                          // width:
                          //     isShowCancelButton
                          //         ? AppDimensions.width(120)
                          //         : AppDimensions.width(240),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context); // Close dialog
                              // onConfirm(); // Execute delete action
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: CommonText.text(
                              "OK",
                              color: AppColors.btntext,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: AppDimensions.width(20)),
                      // isShowCancelButton
                      //     ? SizedBox(width: AppDimensions.width(10))
                      //     : SizedBox.shrink(),
                      Expanded(
                        child: SizedBox(
                          height: AppDimensions.height(45),

                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context); // Close dialog
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.btntext,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),

                                side: BorderSide(
                                  color: AppColors.deleteDesColor,
                                ),
                              ),
                            ),
                            child: CommonText.text(
                              "Cancel",
                              color: AppColors.backArrowColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     PrimaryButton(
                //       onPressed: () => Navigator.of(context).pop(),
                //       text: 'OK',
                //     ),
                //     CupertinoButton(
                //       child: const Text("Done"),
                //       onPressed: () {
                //         Navigator.of(context).pop();
                //         onDateSelected(selectedDate);
                //       },
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showCenteredCupertinoDatePicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime minDate,
    required DateTime maxDate,
    required Function(DateTime) onDateSelected,
  }) {
    DateTime selectedDate = initialDate;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Select Date"),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: initialDate,
              minimumDate: minDate,
              maximumDate: maxDate,
              onDateTimeChanged: (DateTime newDate) {
                selectedDate = newDate;
              },
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
              child: const Text("Done"),
              onPressed: () {
                Navigator.of(context).pop();
                onDateSelected(selectedDate);
              },
            ),
          ],
        );
      },
    );
  }

  void showCupertinoDateDialog({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime minDate,
    required DateTime maxDate,
    required Function(DateTime) onDateSelected,
  }) {
    DateTime selectedDate = initialDate;

    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Select Date"),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: initialDate,
              minimumDate: minDate,
              maximumDate: maxDate,
              onDateTimeChanged: (DateTime newDate) {
                selectedDate = newDate;
              },
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                onDateSelected(selectedDate);
              },
            ),
          ],
        );
      },
    );
  }

  void showCupertinoDatePickerDialog({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime minDate,
    required DateTime maxDate,
    required Function(DateTime) onDateSelected,
  }) {
    showCupertinoModalPopup(
      context: context,
      builder:
          (_) => Container(
            height: 300,
            color: Colors.white,
            child: Column(
              children: [
                // Done button
                Container(
                  height: 50,
                  color: Colors.grey[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CupertinoButton(
                        child: const Text("Done"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          onDateSelected(tempPickedDate);
                        },
                      ),
                    ],
                  ),
                ),

                // CupertinoDatePicker
                Expanded(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: initialDate,
                    minimumDate: minDate,
                    maximumDate: maxDate,
                    onDateTimeChanged: (DateTime newDate) {
                      tempPickedDate = newDate;
                    },
                  ),
                ),
              ],
            ),
          ),
    );
  }

  DateTime tempPickedDate = DateTime.now(); // Temporary variable

  void showListDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: AlertDialog(
            title: Text(title, textAlign: TextAlign.center),
            content: AwesomeDatePicker(
              dateFormat: AwesomeDateFormat.dMMy,
              minDate: AwesomeDate(year: 2025, month: 2, day: 15),
              maxDate: AwesomeDate(year: 2026, month: 10, day: 10),
              onChanged: (AwesomeDate date) {
                print(
                  "----Date changed : ${date.day}/${date.month}/${date.year}\n",
                );
              },
            ),
          ),
        );
      },
    );
  }

  void showCupertinoSpinnerDialog(BuildContext context) {
    List<String> items = List.generate(50, (index) => 'Item ${index + 1}');
    int selectedIndex = 0;

    showCupertinoModalPopup(
      context: context,
      builder:
          (_) => Container(
            height: 300,
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: Column(
              children: [
                // Toolbar with Done button
                Container(
                  color: CupertinoColors.secondarySystemBackground.resolveFrom(
                    context,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        child: const Text('Cancel'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      CupertinoButton(
                        child: const Text('Done'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          debugPrint('Selected: ${items[selectedIndex]}');
                        },
                      ),
                    ],
                  ),
                ),

                // Cupertino Spinner (Picker)
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 40,
                    scrollController: FixedExtentScrollController(
                      initialItem: 0,
                    ),
                    onSelectedItemChanged: (int index) {
                      selectedIndex = index;
                    },
                    children:
                        items
                            .map(
                              (item) => Center(
                                child: Text(
                                  item,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  void showCupertinoListDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Select an Item'),
          content: SizedBox(
            height: 250, // Set height for the scrollable list
            child: CupertinoScrollbar(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Close dialog
                      print('Selected item $index');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      child: Text(
                        'Item ${index + 1}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void showAwesomeDatePickerDialog({
    required BuildContext context,
    required AwesomeDate minDate,
    required AwesomeDate maxDate,
    required Function(AwesomeDate) onChanged,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Flexible(
              child: AwesomeDatePicker(
                dateFormat: AwesomeDateFormat.dMMy,
                minDate: minDate,
                maxDate: maxDate,
                onChanged: onChanged,
              ),
            ),
          ),
        );
      },
    );
  }

  void showFullWidthListDialog(
    BuildContext context,
    List<String> items,
    int columns,
    String title,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int rows = (items.length / columns).ceil();
        return Dialog(
          insetPadding: const EdgeInsets.all(16), // Control outer margin
          child: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width, // 90% of screen width
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: AppDimensions.font(18),
                        fontWeight: FontWeight.w700,
                        fontFamily: "Manrope",
                      ),
                    ),
                    SizedBox(height: AppDimensions.height(15)),
                    Column(
                      children: List.generate(rows, (rowIndex) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(columns, (colIndex) {
                            int itemIndex = rowIndex * columns + colIndex;
                            if (itemIndex < items.length) {
                              return Expanded(
                                child: InkWell(
                                  onTap: () {
                                    items[itemIndex];
                                    debugPrint(
                                      "Select Height ${items[itemIndex]}",
                                    );
                                    Get.back();
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(6),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.borderColor,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        items[itemIndex],
                                        style: TextStyle(
                                          fontSize: AppDimensions.font(14),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Gilroy-Medium",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return const Expanded(child: SizedBox());
                            }
                          }),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CommonDropdownTextFieldDemo extends StatelessWidget {
  final String label;
  final List<String> options;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final double borderRadius;
  final Color borderColor;
  final void Function(String?)? onChanged;

  const CommonDropdownTextFieldDemo({
    super.key,
    required this.label,
    required this.options,
    required this.controller,
    this.onChanged,
    this.borderColor = AppColors.textFieldColor,
    this.borderRadius = 8.0,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: (value) {},
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: AppColors.primary, width: 1),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor, width: 1),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: AppDimensions.height(12),
          horizontal: AppDimensions.width(15.0),
        ),
        suffixIcon: PopupMenuButton<String>(
          icon: Icon(Icons.arrow_drop_down),
          onSelected: (String value) {
            controller.text = value;
            debugPrint(controller.text);
          },
          itemBuilder: (BuildContext context) {
            return options.map((String option) {
              return PopupMenuItem<String>(value: option, child: Text(option));
            }).toList();
          },
        ),
      ),
    );
  }
}

class DateTimePickerDemo extends StatelessWidget {
  const DateTimePickerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return TimePickerSpinnerPopUp(
      mode: CupertinoDatePickerMode.monthYear,
      initTime: DateTime.now(),
      minTime: DateTime.now().subtract(const Duration(days: 10)),
      maxTime: DateTime.now().add(const Duration(days: 10)),
      barrierColor: Colors.black12, //Barrier Color when pop up show
      minuteInterval: 1,
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      cancelText: 'Cancel',
      confirmText: 'OK',
      enable: true,
      radius: 10,
      pressType: PressType.singlePress,
      timeFormat: 'dd/MM/yyyy',
      // Customize your time widget
      // timeWidgetBuilder: (dateTime) {},
      locale: const Locale('vi'),
      onChange: (dateTime) {
        // Implement your logic with select dateTime
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(title: Text(widget.title)),
      body: Stack(
        children: [
          Positioned(
            left: 30,
            top: 60,
            child: TimePickerSpinnerPopUp(
              mode: CupertinoDatePickerMode.monthYear,
              initTime: DateTime.now(),
              minTime: DateTime.now().subtract(const Duration(days: 10)),
              maxTime: DateTime.now().add(const Duration(days: 10)),
              barrierColor: Colors.black12, //Barrier Color when pop up show
              minuteInterval: 1,
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
              cancelText: 'Cancel',
              confirmText: 'OK',
              enable: true,
              radius: 10,
              pressType: PressType.singlePress,
              timeFormat: 'dd/MM/yyyy',
              // Customize your time widget
              // timeWidgetBuilder: (dateTime) {},
              locale: const Locale('vi'),
              onChange: (dateTime) {
                // Implement your logic with select dateTime
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CupertinoListExample extends StatelessWidget {
  const CupertinoListExample({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Cupertino List'),
      ),
      child: SafeArea(
        child: ListView.separated(
          itemCount: 30,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            return CupertinoListTile(
              title: Text(
                'Item ${index + 1}',
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text('Details for item ${index + 1}'),
              leading: const Icon(CupertinoIcons.circle),
              trailing: const Icon(CupertinoIcons.forward),
              onTap: () {
                print('Tapped Item ${index + 1}');
              },
            );
          },
        ),
      ),
    );
  }
}
