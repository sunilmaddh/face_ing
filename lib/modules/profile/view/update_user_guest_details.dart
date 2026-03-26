import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/base/base_view.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/dialog/common_dialog.dart';
import 'package:ntt_data/core/utils/enum/enums.dart';
import 'package:ntt_data/core/utils/enum/gender_enum.dart';
import 'package:ntt_data/core/utils/extensions/extentions.dart';
import 'package:ntt_data/modules/geust/helper/guest_halper.dart';
import 'package:ntt_data/modules/profile/controller/profile_controller.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/button/primary_button.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';
import 'package:ntt_data/widgets/fields/common_dropdown_text_field.dart';
import 'package:ntt_data/widgets/fields/custom_form_field.dart';
import 'package:ntt_data/widgets/gender_widget.dart';
import 'package:intl/intl.dart';

class UpdateUserGuestDetails extends BaseView<ProfileController> {
  UpdateUserGuestDetails({super.key});

  final String guestId = Get.arguments[AppConstents.guestId] ?? "";
  final String name = Get.arguments[AppConstents.nameLower] ?? "";
  final String userFlag = Get.arguments[AppConstents.userFlag] ?? "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  bool get useDefaultLoader => false;

  @override
  Widget buildView(BuildContext context, ProfileController controller) {
    return Scaffold(
      appBar: CustomAppBar(
        onTop: AppNavigation.back,
        title: AppConstents.updateDetailsTitle,
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
                                validator: AppMethods.validateName,
                                label: name,
                                hint: AppConstents.enterNameHint,
                                controller: controller.nameController,
                              ),

                              if (guestId.isNotEmpty) ...[
                                const SizedBox(height: 15),
                                CustomFormField(
                                  validator: AppMethods.validateEmail,
                                  label: AppConstents.emailLevel,
                                  hint: AppConstents.emailHint,
                                  controller: controller.emailController,
                                ),
                              ],

                              const SizedBox(height: 15),

                              RadioWidget(
                                selectionType: controller.genderType,
                                level: AppConstents.genderLevel,
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
                                          AppConstents.ddMMyyyySlash,
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
                                label: AppConstents.dob,
                                hint: AppConstents.selectDobHint,
                                controller: controller.dobController,
                              ),

                              const SizedBox(height: 15),

                              CommonDropdownTextField(
                                unit: "Kg",
                                defaultValue: "60",
                                title: AppConstents.selectWeightLevel,
                                columns: 5,
                                hintText: AppConstents.enterWeightHint,
                                validator: AppMethods.validateWeight,
                                label: AppConstents.weight,
                                options: GuestHelper.weightList,
                                controller: controller.weightController,
                              ),

                              const SizedBox(height: 15),

                              CommonDropdownTextField(
                                unit: "Cm",
                                defaultValue: "160",
                                title: AppConstents.selectHeightLevel,
                                columns: 5,
                                hintText: AppConstents.enterHeightHint,
                                validator: AppMethods.validateHeight,
                                label: AppConstents.height,
                                options: GuestHelper.heightList,
                                controller: controller.heightController,
                              ),

                              const SizedBox(height: 15),

                              RadioWidget(
                                selectionType: controller.smokerType,
                                level: AppConstents.smokerLevel,
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
                            controller.setError(AppConstents.selectGender);
                            return;
                          }

                          if (controller.smokerType.isEmpty) {
                            controller.setError(AppConstents.selectSmokerType);
                            return;
                          }

                          final userId =
                              await IndoSharedPreference.instance.getUserId();

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
                        text: AppConstents.update,
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
