import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/common_dialog.dart';
import 'package:ntt_data/modules/views/auth/auth_controller.dart';
import 'package:ntt_data/modules/views/profile/controller/profile_controller.dart';
import 'package:ntt_data/routes/app_navigation.dart' show AppNavigation;
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/bottom_sheet/image_picker_bottomsheet.dart';
import 'package:ntt_data/widgets/button/primary_button.dart';
import 'package:ntt_data/widgets/fields/common_dropmenu.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';
import 'package:ntt_data/widgets/fields/custom_form_field.dart';
import 'package:ntt_data/widgets/gender_widget.dart';

// ignore: must_be_immutable
class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({super.key});

  final AuthController _authController = Get.find<AuthController>();
  final _profileController = Get.find<ProfileController>();

  final _formKey = GlobalKey<FormState>();

  List<String> smokerTypeList = ["Smoker", "Non Smoker"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        onTop: () {
          AppNavigation.back();
        },
        title: AppConstents.createAccount,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(height: AppDimensions.height(0)),

                /// Name Field
                CustomFormField(
                  validator: (name) {
                    if (name == null || name.isEmpty) {
                      return "Please enter name";
                    }
                    return null;
                  },
                  label: AppConstents.name,
                  hint: "Enter your name",
                  controller: _authController.nameController,
                ),
                SizedBox(height: 15),

                RadioWidget(
                  controller: _authController,
                  level: 'Gender',
                  radioTextRight: 'Female',
                  radioTextLeft: 'Male',
                ),
                SizedBox(height: 15),

                /// Date of Birth Picker
                CustomFormField(
                  readOnly: true,
                  suffixIcon: IconButton(
                    onPressed: () {
                      CommonDialog.selectDate(
                        context: context,
                        dateController: _authController.dateController,
                      );
                    },
                    icon: Icon(Icons.date_range, color: AppColors.primary),
                  ),
                  label: AppConstents.dob,
                  hint: "Select your date of birth",
                  controller: _authController.dateController,
                ),
                SizedBox(height: 15),

                /// Weight Field
                CustomFormField(
                  validator: (weight) {
                    if (weight == null || weight.isEmpty) {
                      return "Please enter weight";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  label: AppConstents.weight,
                  hint: "Enter your weight (kg)",
                  controller: _authController.weightController,
                ),
                SizedBox(height: 15),

                /// Height Field
                CustomFormField(
                  validator: (height) {
                    if (height == null || height.isEmpty) {
                      return "Please enter height";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  label: AppConstents.height,
                  hint: "Enter your height (cm)",
                  controller: _authController.heightController,
                ),
                SizedBox(height: 15),
                CommonDropdown(
                  items: smokerTypeList,
                  onChanged: (selectedValue) {
                    _authController.smokerType.value = selectedValue.toString();
                  },
                  label: "Select smoker type",
                  itemToString: (smoker) => smoker,
                ),

                SizedBox(height: 15),
                SizedBox(
                  height: AppDimensions.height(190),
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Obx(
                        () =>
                            _authController.isProfile.isTrue
                                ? Container(
                                  height: AppDimensions.height(180),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: AppColors.dottedBorderColor,
                                    borderRadius: BorderRadius.circular(9.0),
                                  ),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.file(
                                          _authController.profileUrl.value,
                                          fit: BoxFit.fill,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Card(
                                          child: InkWell(
                                            onTap: () {
                                              _authController.isProfile.value =
                                                  false;
                                              _authController
                                                  .profileUrl
                                                  .value = File("");
                                            },
                                            child: Icon(
                                              Icons.close_rounded,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                : DottedBorder(
                                  dashPattern: [6, 5],
                                  strokeWidth: 3.0,
                                  borderType: BorderType.RRect,
                                  radius: Radius.circular(10),
                                  color: AppColors.dottedBorderColor,
                                  child: Container(
                                    height: AppDimensions.height(161),
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9.0),
                                      color: AppColors.uploadCardColor,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        ImagePickerBottomsheet.showImagePickerBottomSheet(
                                          onGalleryTap: () async {
                                            await _authController
                                                .uploadProfileFromGallery(
                                                  "true",
                                                );
                                          },
                                          onCameraTap: () async {
                                            await _authController
                                                .uploadProfileFromCamera(
                                                  "true",
                                                );
                                          },
                                        );
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            AppAssets.upload,
                                            height: AppDimensions.height(26.3),
                                            width: AppDimensions.width(24),
                                          ),
                                          SizedBox(width: 5.0),
                                          CommonText.text(
                                            "Upload file",
                                            fontSize: AppDimensions.font(16),
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff263238),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: PrimaryButton(
                    text: AppConstents.continueBtn,
                    onPressed: () {
                      debugPrint(_authController.userId.value);
                      if (_formKey.currentState!.validate()) {
                        _profileController.getMedicalQeustionList();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
