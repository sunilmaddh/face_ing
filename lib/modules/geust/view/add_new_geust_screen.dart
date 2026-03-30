import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ntt_data/core/base/base_view.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/api_constants.dart';
import 'package:ntt_data/core/constants/app_fonts.dart';
import 'package:ntt_data/core/constants/app_strings.dart';
import 'package:ntt_data/core/constants/app_text_styles.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/dialog/common_dialog.dart';
import 'package:ntt_data/modules/auth/widgets/terms_checkbox_widget.dart';
import 'package:ntt_data/modules/binah/controllers/measurement_controller.dart';
import 'package:ntt_data/modules/geust/controller/geust_controller.dart';
import 'package:ntt_data/modules/geust/helper/guest_halper.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/button/scan_button.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';
import 'package:ntt_data/widgets/fields/common_dropdown_text_field.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';
import 'package:ntt_data/widgets/fields/custom_form_field.dart';
import 'package:ntt_data/widgets/gender_widget.dart';

class AddNewGuestScreen extends BaseView<GeustController> {
  AddNewGuestScreen({super.key});

  final MeasurementController measurementController =
      Get.find<MeasurementController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  bool get useDefaultLoader => true;

  @override
  Widget buildView(BuildContext context, GeustController controller) {
    return Scaffold(
      appBar: CustomAppBar(onTop: AppNavigation.back, title: "Add Guest"),
      backgroundColor: AppColors.historyCardColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(AppDimensions.padding(20.0)),
                child: CommonCard(
                  widget: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            CustomFormField(
                              validator: AppMethods.validateName,
                              label: "Patient ID",
                              hint: "Enter your name",
                              controller: controller.nameTextController,
                            ),
                            const SizedBox(height: 15),
                            RadioWidget(
                              selectionType: controller.selectionType,
                              level: 'Gender',
                              radioTextRight: 'Female',
                              radioTextLeft: 'Male',
                              onSelectionChanged: (value) {
                                controller.selectionType.value = value;
                              },
                            ),
                            const SizedBox(height: 15),
                            CustomFormField(
                              keyboardType: TextInputType.datetime,
                              validator: AppMethods.validateDOB,
                              suffixIcon: InkWell(
                                onTap: () {
                                  CommonDialog.showFullWidthCupertinoDatePicker(
                                    context: context,
                                    onDateSelected: (selectedDate) {
                                      final formattedDate = DateFormat(
                                        'dd/MM/yyyy',
                                      ).format(selectedDate);
                                      controller.dobTextController.text =
                                          formattedDate;
                                    },
                                  );
                                },
                                child: const Icon(
                                  Icons.date_range,
                                  color: AppColors.primary,
                                ),
                              ),
                              label: AppStrings.dob,
                              hint: "Select your date of birth",
                              controller: controller.dobTextController,
                            ),
                            const SizedBox(height: 15),
                            CommonDropdownTextField(
                              unit: "Kg",
                              defaultValue: "60",
                              title: "Select Your Weight (Kg)",
                              columns: 5,
                              hintText: "Enter your weight (Kg)",
                              validator: AppMethods.validateWeight,
                              label: AppStrings.weight,
                              options: GuestHelper.weightList,
                              controller: controller.weightTextController,
                            ),
                            const SizedBox(height: 15),
                            CommonDropdownTextField(
                              unit: "Cm",
                              defaultValue: "160",
                              title: "Select Your Height (Cm)",
                              columns: 5,
                              hintText: "Enter your height (Cm)",
                              validator: AppMethods.validateHeight,
                              label: AppStrings.height,
                              options: GuestHelper.heightList,
                              controller: controller.heightTextController,
                            ),
                            const SizedBox(height: 15),
                            CustomFormField(
                              validator: AppMethods.validateEmail,
                              label: "Email Id (Optional)",
                              hint: "Enter your email id",
                              controller: controller.emailTextController,
                            ),
                            const SizedBox(height: 15),
                            RadioWidget(
                              selectionType:
                                  measurementController.selectionType,
                              level: 'Smoker type',
                              radioTextLeft: 'Smoker',
                              radioTextRight: 'No Smoker',
                              onSelectionChanged: (value) {
                                measurementController.selectionType.value =
                                    value;
                              },
                            ),
                            const SizedBox(height: 15),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Guest Image ",
                                      style: TextStyle(
                                        fontSize: AppDimensions.font(16),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: AppFonts.primary,
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: "(Optional)",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff4A4949),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppDimensions.height(48)),
              CommonCard(
                widget: Padding(
                  padding: EdgeInsets.only(
                    right: AppDimensions.width(20.0),
                    bottom: AppDimensions.width(20.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TermsCheckboxWidget(
                        message: ApiConstants.message,
                        controller: controller,
                      ),
                      SizedBox(height: AppDimensions.height(30)),
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          width: AppDimensions.width(230),
                          child: ScanButton(
                            onPressed: () async {
                              if (!_formKey.currentState!.validate()) return;

                              if (controller.selectionType.isEmpty) {
                                controller.setError("Please select gender");
                                return;
                              }

                              if (measurementController.selectionType.isEmpty) {
                                controller.setError(
                                  "Please select smoker type",
                                );
                                return;
                              }

                              if (controller.isChecked.isFalse) {
                                controller.setError(
                                  "Please accept terms and conditions",
                                );
                                return;
                              }
                              controller.startMeasurement();
                            },
                          ),
                        ),
                      ),
                      10.verticalSpace,
                      Padding(
                        padding: AppDimensions.only(left: 20.0),
                        child: CommonText.labelMedium(
                          "Note: ${AppStrings.noteDescription}",
                          maxLines: 2,
                          color: Colors.grey,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
