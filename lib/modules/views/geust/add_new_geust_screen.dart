import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ntt_data/binah/measurement_controller.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/constants/app_text_styles.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/core/utils/common_dialog.dart';
import 'package:ntt_data/modules/views/auth/widgets/terms_checkbox_widget.dart';
import 'package:ntt_data/modules/views/geust/controller/geust_controller.dart';
import 'package:ntt_data/modules/views/geust/guest_halper.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/button/scan_button.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';
import 'package:ntt_data/widgets/cards/profile_upload_card.dart';
import 'package:ntt_data/widgets/fields/common_dropmenu.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';
import 'package:ntt_data/widgets/fields/custom_form_field.dart';
import 'package:ntt_data/widgets/gender_widget.dart';

// ignore: must_be_immutable
class AddNewGuestScreen extends StatelessWidget {
  AddNewGuestScreen({super.key});

  final _geustController = Get.find<GeustController>();
  final controller = Get.find<MeasurementController>();
  final _formKey = GlobalKey<FormState>();

  List<String> smokerTypeList = ["Smoker", "Non Smoker"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onTop: () {
          AppNavigation.back();
        },
        title: "Add Guest",
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
                                  if (name == null || name.isEmpty) {
                                    return "Please enter name";
                                  }
                                  return null;
                                },
                                label: "Patient ID",
                                hint: "Enter your name",
                                controller: _geustController.nameTextController,
                              ),
                              SizedBox(height: 15),
                              GenderWidget(controller: _geustController),
                              SizedBox(height: 15),

                              /// Date of Birth Picker
                              InkWell(
                                onTap: () {
                                  CommonDialog.selectDate(
                                    context: context,
                                    dateController:
                                        _geustController.dobTextController,
                                  );
                                },
                                child: CustomFormField(
                                  validator: (dob) {
                                    if (dob == null || dob.isEmpty) {
                                      return "Please select DOB";
                                    }
                                    return null;
                                  },
                                  enable: false,
                                  readOnly: true,
                                  suffixIcon: const Icon(
                                    Icons.date_range,
                                    color: AppColors.primary,
                                  ),
                                  label: AppConstents.dob,
                                  hint: "Select your date of birth",
                                  controller:
                                      _geustController.dobTextController,
                                ),
                              ),
                              SizedBox(height: 15),

                              /// Weight Field
                              CustomFormField(
                                keyboardType: TextInputType.number,
                                validator: (weight) {
                                  if (weight == null || weight.isEmpty) {
                                    return "Please enter weight";
                                  }
                                  return null;
                                },
                                label: AppConstents.weight,
                                hint: "Enter your weight (kg)",
                                controller:
                                    _geustController.weightTextController,
                              ),
                              SizedBox(height: 15),

                              /// Height Field
                              CustomFormField(
                                keyboardType: TextInputType.number,
                                validator: (height) {
                                  if (height == null || height.isEmpty) {
                                    return "Please enter height";
                                  }
                                  return null;
                                },
                                label: AppConstents.height,
                                hint: "Enter your height (cm)",
                                controller:
                                    _geustController.heightTextController,
                              ),
                              SizedBox(height: 15),
                              CommonDropdown(
                                items: smokerTypeList,
                                onChanged: (value) {
                                  controller.smokerType.value = value!;
                                },
                                label: "Select Smoker type",
                                itemToString: (smokerType) => smokerType,
                              ),
                              SizedBox(height: 15),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Guest Image",
                                        style: TextStyle(
                                          fontSize: AppDimensions.font(16),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: AppTextStyles.fontFamily,
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "(optional)",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff4A4949),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              ProfileUploadCard(
                                isProfile: _geustController.isProfile,
                                profileUrl: _geustController.profileUrl,
                                onRemove: () {
                                  _geustController.isProfile.value = false;
                                  _geustController.profileUrl.value = File("");
                                },
                                onGalleryTap: () async {
                                  await _geustController
                                      .uploadProfileFromGallery("true");
                                },
                                onCameraTap: () async {
                                  _geustController.uploadProfileFromCamera(
                                    "true",
                                  );
                                },
                              ),
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
                    child: SizedBox(
                      height:
                          MediaQuery.of(context).size.height -
                          AppDimensions.height(570),
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          TermsCheckboxWidget(
                            message: AppConstents.message,
                            controller: _geustController,
                          ),
                          SizedBox(height: AppDimensions.height(30)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Align(
                                alignment: Alignment.bottomRight,
                                child: SizedBox(
                                  width: AppDimensions.width(230),
                                  child: ScanButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        var height = int.parse(
                                          _geustController
                                                  .heightTextController
                                                  .text ??
                                              "0",
                                        );
                                        if (_geustController
                                            .selectionType
                                            .isEmpty) {
                                          AppSnackbar.show(
                                            isError: true,
                                            title: "Error",
                                            message: "Please select gender",
                                          );
                                        } else if (height < 130) {
                                          AppSnackbar.show(
                                            isError: true,
                                            title: "Error",
                                            message:
                                                "Please enter a height greater than or equal to 130.",
                                          );
                                        } else if (controller
                                            .smokerType
                                            .isEmpty) {
                                          AppSnackbar.show(
                                            title: "Error",
                                            message:
                                                "Please select smoker type",
                                          );
                                        } else if (_geustController
                                            .isChecked
                                            .isFalse) {
                                          AppSnackbar.show(
                                            isError: true,
                                            title: "Error",
                                            message:
                                                "Please accept term and conditions",
                                          );
                                        } else if (controller
                                            .smokerType
                                            .isEmpty) {
                                          AppSnackbar.show(
                                            title: "Error",
                                            message:
                                                "Please select smoker type",
                                          );
                                        } else {
                                          GuestHalper().callMeasurement();
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ),

                              SizedBox(height: AppDimensions.height(10)),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: CommonText.text(
                                  "Note: ${AppConstents.notDiscription}",
                                  fontSize: AppDimensions.font(12),
                                  fontWeight: FontWeight.w500,
                                  maxLines: 2,
                                  color: Colors.grey,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ],
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
