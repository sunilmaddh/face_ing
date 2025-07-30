import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/core/utils/common_dialog.dart';
import 'package:ntt_data/modules/views/geust/helper/guest_halper.dart';
import 'package:ntt_data/modules/views/profile/controller/profile_controller.dart';
import 'package:ntt_data/modules/views/profile/helper/profile_helper.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/button/scan_button.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';
import 'package:ntt_data/widgets/fields/common_dropdown_text_field.dart';
import 'package:ntt_data/widgets/fields/custom_form_field.dart';
import 'package:ntt_data/widgets/gender_widget.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class UpdateUserGuestDetails extends StatelessWidget {
  UpdateUserGuestDetails({super.key});
  final _profileController = Get.find<ProfileController>();
  final String guestId = Get.arguments["guestId"] ?? "";
  final String userFlag = Get.arguments["userFlag"] ?? "";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onTop: () {
          AppNavigation.back();
        },
        title: "Update Details",
      ),
      backgroundColor: AppColors.historyCardColor,
      body: SafeArea(
        child: ListView(
          children: [
            Column(
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
                                validator: (name) {
                                  return AppMethods.validateName(name);
                                },
                                label: "Patient ID",
                                hint: "Enter your name",
                                controller: _profileController.nameController,
                              ),
                              SizedBox(height: 15),
                              RadioWidget(
                                selectionType: _profileController.genderType,
                                level: 'Gender',
                                radioTextRight: 'Female',
                                radioTextLeft: 'Male',
                                onSelectionChanged: (value) {
                                  _profileController.genderType.value = value;
                                },
                              ),
                              SizedBox(height: 15),

                              /// Date of Birth Picker
                              CustomFormField(
                                keyboardType: TextInputType.datetime,
                                validator: (dob) {
                                  return AppMethods.validateDOB(dob);
                                },

                                suffixIcon: InkWell(
                                  onTap: () async {
                                    CommonDialog.showFullWidthCupertinoDatePicker(
                                      context: context,
                                      onDateSelected: (selectedDate) {
                                        String formattedDate = DateFormat(
                                          'dd/MM/yyyy',
                                        ).format(selectedDate);
                                        _profileController.dobController.text =
                                            formattedDate;
                                      },
                                    );
                                  },
                                  child: const Icon(
                                    Icons.date_range,
                                    color: AppColors.primary,
                                  ),
                                ),
                                label: AppConstents.dob,
                                hint: "Select your date of birth",
                                controller: _profileController.dobController,
                              ),
                              SizedBox(height: 15),
                              CommonDropdownTextField(
                                unit: "Kg",
                                defaultValue: "60",
                                title: "Select Your Weight (Kg)",
                                columns: 5,
                                hintText: "Enter your weight (Kg)",
                                validator: (weight) {
                                  return AppMethods.validateWeight(weight);
                                },
                                label: AppConstents.weight,
                                options: GuestHalper.weightList,

                                controller: _profileController.weightController,
                              ),

                              SizedBox(height: 15),

                              CommonDropdownTextField(
                                unit: "Cm",
                                defaultValue: "160",
                                title: "Select your height (Cm)",
                                columns: 5,
                                hintText: "Enter your height (Cm)",
                                validator: (height) {
                                  return AppMethods.validateHeight(height);
                                },
                                label: AppConstents.height,
                                options: GuestHalper.heightList,
                                controller: _profileController.heightController,
                              ),
                              SizedBox(height: 15),
                              RadioWidget(
                                selectionType: _profileController.smokerType,
                                level: 'Smoker type',
                                radioTextLeft: 'Smoker',
                                radioTextRight: 'No Smoker',
                                onSelectionChanged: (value) {
                                  _profileController.smokerType.value = value;
                                },
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.width(20.0),
                    vertical: AppDimensions.width(20.0),
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      width: AppDimensions.width(230),
                      child: ScanButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (_profileController.genderType.isEmpty) {
                              AppSnackbar.show(
                                isError: true,
                                title: "Error",
                                message: "Please select gender",
                              );
                            } else if (_profileController.smokerType.isEmpty) {
                              AppSnackbar.show(
                                isError: true,
                                title: "Error",
                                message: "Please select Smoker type",
                              );
                            } else {
                              var name = _profileController.nameController.text;
                              var gender = _profileController.genderType.value;
                              var dob = _profileController.dobController.text;
                              var smokerType =
                                  _profileController.smokerType.value;
                              var weight =
                                  _profileController.weightController.text;
                              var height =
                                  _profileController.heightController.text;
                              var userId =
                                  await IndoSharedPreference.instance
                                      .getUserId();
                              ProfileHelper().callUpdateDetailsFunction(
                                userId: userId,
                                guestId: guestId,
                                userFlag: userFlag,
                                name: name,
                                gender: gender,
                                dob: dob,
                                smokerType: smokerType,
                                weight: weight,
                                height: height,
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
