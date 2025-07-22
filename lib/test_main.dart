import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';

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
        child: CommonDropdownTextFieldDemo(
          label: 'Height',
          options: ["Option 1", "Option 2", "Option 3"],
          controller: editController,
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
