import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ntt_data/core/base/base_view.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/api_constants.dart';
import 'package:ntt_data/core/constants/app_fonts.dart';
import 'package:ntt_data/core/constants/app_strings.dart';
import 'package:ntt_data/core/constants/date_formats.dart';
import 'package:ntt_data/core/constants/validation_strings.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/dialog/common_dialog.dart';
import 'package:ntt_data/core/utils/enum/enums.dart';
import 'package:ntt_data/core/utils/enum/gender_enum.dart';
import 'package:ntt_data/core/utils/extensions/extentions.dart';
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
      appBar: CustomAppBar(
        onTop: AppNavigation.back,
        title: AppStrings.addGuest,
      ),
      backgroundColor: AppColors.historyCardColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(AppDimensions.padding(20)),
                child: CommonCard(
                  widget: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          CustomFormField(
                            validator: AppMethods.validateName,
                            label: AppStrings.patientId,
                            hint: ValidationStrings.enterName,
                            controller: controller.nameTextController,
                          ),
                          const SizedBox(height: 15),

                          RadioWidget(
                            selectionType: controller.selectionType,
                            level: AppStrings.gender,
                            radioTextRight: Gender.female.value,
                            radioTextLeft: Gender.male.value,
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
                                  onDateSelected: (date) {
                                    controller
                                        .dobTextController
                                        .text = DateFormat(
                                      DateFormats.ddMMyyyySlash,
                                    ).format(date);
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
                            controller: controller.dobTextController,
                          ),

                          const SizedBox(height: 15),

                          CommonDropdownTextField(
                            unit: AppStrings.kg,
                            defaultValue: AppStrings.defaultWeight,
                            title: AppStrings.selectWeightLevel,
                            columns: 5,
                            hintText: ValidationStrings.enterWeightHint,
                            validator: AppMethods.validateWeight,
                            label: AppStrings.weight,
                            options: GuestHelper.weightList,
                            controller: controller.weightTextController,
                          ),

                          const SizedBox(height: 15),

                          CommonDropdownTextField(
                            unit: AppStrings.cm,
                            defaultValue: AppStrings.defaultHeight,
                            title: AppStrings.selectHeightLevel,
                            columns: 5,
                            hintText: ValidationStrings.enterHeightHint,
                            validator: AppMethods.validateHeight,
                            label: AppStrings.height,
                            options: GuestHelper.heightList,
                            controller: controller.heightTextController,
                          ),

                          const SizedBox(height: 15),

                          CustomFormField(
                            validator: AppMethods.validateEmail,
                            label: AppStrings.emailOptional,
                            hint: ValidationStrings.enterEmailIdHint,
                            controller: controller.emailTextController,
                          ),

                          const SizedBox(height: 15),

                          RadioWidget(
                            selectionType: measurementController.selectionType,
                            level: AppStrings.smokerLevel,
                            radioTextLeft: Smoker.smoker.value,
                            radioTextRight: Smoker.nonSmoker.value,
                            onSelectionChanged: (value) {
                              measurementController.selectionType.value = value;
                            },
                          ),

                          const SizedBox(height: 15),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: AppStrings.guestImage,
                                    style: TextStyle(
                                      fontSize: AppDimensions.font(16),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppFonts.primary,
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " ${AppStrings.optional}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xff4A4949),
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
                ),
              ),

              SizedBox(height: AppDimensions.height(48)),

              CommonCard(
                widget: Padding(
                  padding: AppDimensions.only(right: 20, bottom: 20),
                  child: Column(
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
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) return;

                              if (controller.selectionType.isEmpty) {
                                controller.setError(
                                  ValidationStrings.selectGender,
                                );
                                return;
                              }

                              if (measurementController.selectionType.isEmpty) {
                                controller.setError(
                                  ValidationStrings.selectSmoker,
                                );
                                return;
                              }

                              if (controller.isChecked.isFalse) {
                                controller.setError(AppStrings.acceptTerms);
                                return;
                              }

                              controller.startMeasurement();
                            },
                          ),
                        ),
                      ),

                      10.verticalSpace,

                      Padding(
                        padding: AppDimensions.only(left: 20),
                        child: CommonText.labelMedium(
                          "${AppStrings.notePrefix} ${AppStrings.noteDescription}",
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
