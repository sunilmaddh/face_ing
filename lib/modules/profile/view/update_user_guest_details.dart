import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/base/base_view.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/api_constants.dart';
import 'package:ntt_data/core/constants/app_strings.dart';
import 'package:ntt_data/core/constants/date_formats.dart';
import 'package:ntt_data/core/constants/validation_strings.dart';
import 'package:ntt_data/core/storage/app_preferences.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/dialog/common_dialog.dart';
import 'package:ntt_data/core/utils/enum/enums.dart';
import 'package:ntt_data/core/utils/enum/gender_enum.dart';
import 'package:ntt_data/core/utils/extensions/extentions.dart';
import 'package:ntt_data/modules/geust/helper/guest_halper.dart';
import 'package:ntt_data/modules/profile/controller/profile_controller.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/button/primary_button.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';
import 'package:ntt_data/widgets/fields/common_dropdown_text_field.dart';
import 'package:ntt_data/widgets/fields/custom_form_field.dart';
import 'package:ntt_data/widgets/gender_widget.dart';
import 'package:intl/intl.dart';

class UpdateUserGuestDetails extends BaseView<ProfileController> {
  UpdateUserGuestDetails({super.key});

  final String guestId = Get.arguments[ApiConstants.guestId] ?? "";
  final String name = Get.arguments[ApiConstants.nameKey] ?? "";
  final String userFlag = Get.arguments[ApiConstants.userFlag] ?? "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  bool get useDefaultLoader => false;

  @override
  Widget buildView(BuildContext context, ProfileController controller) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.updateDetailsTitle),
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
                                validator: AppMethods.validateName,
                                label: name,
                                hint: ValidationStrings.enterNameHint,
                                controller: controller.nameController,
                              ),

                              if (guestId.isNotEmpty) ...[
                                const SizedBox(height: 15),
                                CustomFormField(
                                  validator: AppMethods.validateEmail,
                                  label: AppStrings.emailLevel,
                                  hint: ValidationStrings.emailHint,
                                  controller: controller.emailController,
                                ),
                              ],

                              const SizedBox(height: 15),

                              RadioWidget(
                                selectionType: controller.genderType,
                                level: AppStrings.genderLevel,
                                radioTextRight: Gender.female.value,
                                radioTextLeft: Gender.male.value,
                                onSelectionChanged: (value) {
                                  controller.genderType.value = value;
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
                                          DateFormats.ddMMyyyySlash,
                                        ).format(selectedDate);
                                        controller.dobController.text =
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
                                hint: ValidationStrings.selectDobHint,
                                controller: controller.dobController,
                              ),

                              const SizedBox(height: 15),

                              CommonDropdownTextField(
                                unit: "Kg",
                                defaultValue: "60",
                                title: AppStrings.selectWeightLevel,
                                columns: 5,
                                hintText: ValidationStrings.enterWeightHint,
                                validator: AppMethods.validateWeight,
                                label: AppStrings.weight,
                                options: GuestHelper.weightList,
                                controller: controller.weightController,
                              ),

                              const SizedBox(height: 15),

                              CommonDropdownTextField(
                                unit: "Cm",
                                defaultValue: "160",
                                title: AppStrings.selectHeightLevel,
                                columns: 5,
                                hintText: ValidationStrings.enterHeightHint,
                                validator: AppMethods.validateHeight,
                                label: AppStrings.height,
                                options: GuestHelper.heightList,
                                controller: controller.heightController,
                              ),

                              const SizedBox(height: 15),

                              RadioWidget(
                                selectionType: controller.smokerType,
                                level: AppStrings.smokerLevel,
                                radioTextLeft: Smoker.smoker.value,
                                radioTextRight: Smoker.nonSmoker.value,
                                onSelectionChanged: (value) {
                                  controller.smokerType.value = value;
                                },
                              ),

                              const SizedBox(height: 15),
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
                      width: AppDimensions.width(130),
                      child: PrimaryButton(
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) return;

                          if (controller.genderType.isEmpty) {
                            controller.setError(ValidationStrings.selectGender);
                            return;
                          }

                          if (controller.smokerType.isEmpty) {
                            controller.setError(
                              ValidationStrings.selectSmokerType,
                            );
                            return;
                          }

                          final userId = AppPreferences.instance.getUserId();

                          controller.callUpdateApi(
                            userId: userId,
                            guestId: guestId,
                            userFlag: userFlag,
                            name: controller.nameController.text,
                            gender: controller.genderType.value,
                            dob: controller.dobController.text,
                            smokerType: controller.smokerType.value,
                            weight: controller.weightController.text,
                            height: controller.heightController.text,
                            email: controller.emailController.text,
                          );
                        },
                        text: AppStrings.update,
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
