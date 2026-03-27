import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_strings.dart';
import 'package:ntt_data/core/constants/app_text_styles.dart';
import 'package:ntt_data/core/constants/date_formats.dart';
import 'package:ntt_data/core/constants/validation_strings.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/dialog/common_dialog.dart';
import 'package:ntt_data/core/utils/enum/enums.dart';
import 'package:ntt_data/core/utils/enum/gender_enum.dart';
import 'package:ntt_data/core/utils/extensions/extentions.dart';
import 'package:ntt_data/data/services/profile_upload_services.dart';
import 'package:ntt_data/modules/auth/controllers/auth_controller.dart';
import 'package:ntt_data/modules/geust/helper/guest_halper.dart';
import 'package:ntt_data/routes/app_navigation.dart' show AppNavigation;
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/bottom_sheet/image_picker_bottomsheet.dart';
import 'package:ntt_data/widgets/button/primary_button.dart';
import 'package:ntt_data/widgets/fields/common_dropdown_text_field.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';
import 'package:ntt_data/widgets/fields/custom_form_field.dart';
import 'package:ntt_data/widgets/gender_widget.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({super.key});
  final AuthController _authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        onTop: () {
          AppNavigation.back();
        },
        title: AppStrings.createAccount,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              children: [
                SizedBox(height: AppDimensions.height(0)),
                CustomFormField(
                  validator: (name) {
                    return AppMethods.validateName(name);
                  },
                  label: AppStrings.name,
                  hint: ValidationStrings.enterNameHint,
                  controller: _authController.nameController,
                ),
                SizedBox(height: 15),
                RadioWidget(
                  level: AppStrings.genderLevel,
                  radioTextLeft: Gender.male.value,
                  radioTextRight: Gender.female.value,
                  onSelectionChanged: (value) {
                    _authController.selectionType.value = value;
                  },
                  selectionType: _authController.selectionType,
                ),
                SizedBox(height: 15),
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
                            DateFormats.ddMMyyyySlash,
                          ).format(selectedDate);
                          _authController.dateController.text = formattedDate;
                        },
                      );
                    },
                    child: const Icon(
                      Icons.date_range,
                      color: AppColors.primary,
                    ),
                  ),
                  label: AppStrings.dob,
                  hint: ValidationStrings.selectDobHint,
                  controller: _authController.dateController,
                ),
                SizedBox(height: 15),
                CommonDropdownTextField(
                  unit: "Kg",
                  defaultValue: "60",
                  title: AppStrings.selectWeightLevel,
                  columns: 5,
                  hintText: ValidationStrings.enterWeightHint,
                  validator: (weight) {
                    return AppMethods.validateWeight(weight);
                  },
                  label: AppStrings.weight,
                  options: GuestHelper.weightList,

                  controller: _authController.weightController,
                ),

                SizedBox(height: 15),

                CommonDropdownTextField(
                  unit: "cm",
                  defaultValue: "160",
                  title: AppStrings.selectHeightLevel,
                  columns: 5,
                  hintText: ValidationStrings.enterHeightHint,
                  validator: (height) {
                    return AppMethods.validateHeight(height);
                  },
                  label: AppStrings.height,
                  options: GuestHelper.heightList,
                  controller: _authController.heightController,
                ),
                SizedBox(height: 15),
                RadioWidget(
                  selectionType: _authController.smokerType,
                  level: AppStrings.smokerLevel,
                  radioTextLeft: Smoker.smoker.value,
                  radioTextRight: Smoker.nonSmoker.value,
                  onSelectionChanged: (value) {
                    _authController.smokerType.value = value;
                  },
                ),
                SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: AppStrings.userImageLevel,
                          style: TextStyle(
                            fontSize: AppDimensions.font(16),
                            fontWeight: FontWeight.w500,
                            fontFamily: AppTextStyles.fontFamily,
                            color: AppColors.blackColor,
                          ),
                        ),
                        TextSpan(
                          text: AppStrings.optional,
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
                                            final file =
                                                await ProfileUploadService()
                                                    .uploadProfileImage(
                                                      source:
                                                          ImagePickSource
                                                              .gallery,
                                                    );
                                            if (file.path.isNotEmpty) {
                                              _authController.profileUrl.value =
                                                  file;
                                              await _authController
                                                  .uploadProfile(
                                                    imagePath: file.path,
                                                  );
                                            }
                                          },
                                          onCameraTap: () async {
                                            final file =
                                                await ProfileUploadService()
                                                    .uploadProfileImage(
                                                      source:
                                                          ImagePickSource
                                                              .camera,
                                                    );

                                            if (file.path.isNotEmpty) {
                                              _authController.profileUrl.value =
                                                  file;
                                              await _authController
                                                  .uploadProfile(
                                                    imagePath: file.path,
                                                  );
                                            }
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
                    text: AppStrings.continueBtn,
                    onPressed: () {
                      debugPrint(_authController.userId.value);
                      if (_formKey.currentState!.validate()) {
                        _authController.getMedicalQuestionList();
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
