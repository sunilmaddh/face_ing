import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ntt_data/binah/measurement_controller.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/storage/storage_helper.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/core/utils/common_dialog.dart';
import 'package:ntt_data/data/repository/services/native_caller_services.dart';
import 'package:ntt_data/modules/views/auth/widgets/terms_checkbox_widget.dart';
import 'package:ntt_data/modules/views/geust/controller/geust_controller.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/button/scan_button.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';
import 'package:ntt_data/widgets/fields/custom_form_field.dart';
import 'package:ntt_data/widgets/gender_widget.dart';

class AddNewGuestScreen extends StatelessWidget {
  AddNewGuestScreen({super.key});

  final _geustController = Get.find<GeustController>();
  final controller = Get.find<MeasurementController>();
  final _formKey = GlobalKey<FormState>();

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
                                label: "Patiant Id",
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
                          AppDimensions.height(590),
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          TermsCheckboxWidget(
                            message:
                                "This application is not a medical device. Measurement results cannot be used for the diagnosis, treatment or prevention of disease.If you are unsure about your health, please use medical equipment to measure the exact value.",
                            controller: _geustController,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: SizedBox(
                              width: AppDimensions.width(230),
                              child: ScanButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    if (_geustController
                                        .selectionType
                                        .isEmpty) {
                                      AppSnackbar.show(
                                        isError: true,
                                        title: "Error",
                                        message: "Please select gender",
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
                                    } else {
                                      var userID =
                                          await IndoSharedPreference.instance
                                              .getUserId();
                                      var accessToken =
                                          await IndoSharedPreference.instance
                                              .getAccessToken();

                                      Map<String, dynamic> data = {
                                        "userId": userID,
                                        "name":
                                            _geustController
                                                .nameTextController
                                                .text,
                                        "gender":
                                            _geustController
                                                .selectionType
                                                .value,
                                        "dob":
                                            _geustController
                                                .dobTextController
                                                .text, // Keep as string unless using DateTime
                                        "weight":
                                            _geustController
                                                .weightTextController
                                                .text,
                                        "height":
                                            _geustController
                                                .heightTextController
                                                .text,
                                        "emailId":
                                            _geustController
                                                .dobTextController
                                                .text,
                                        "token": accessToken,
                                        "scanType": "guest-user",
                                      };

                                      NativeCaller.startFaceScan(data);
                                    }
                                  }
                                },
                              ),
                            ),
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
