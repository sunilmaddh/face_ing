import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/auth/auth_controller.dart';
import 'package:ntt_data/modules/views/auth/widgets/terms_checkbox_widget.dart';
import 'package:ntt_data/modules/views/profile/widgets/gender_widget.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/button/scan_button.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';
import 'package:ntt_data/widgets/fields/custom_form_field.dart';

class AddNewGuestScreen extends StatelessWidget {
  AddNewGuestScreen({super.key});

  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Add New Guest"),
      backgroundColor: AppColors.historyCardColor,
      body: SafeArea(
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
                    child: Column(
                      children: [
                        CustomFormField(
                          label: AppConstents.name,
                          hint: "Enter your name",
                          controller: _authController.emailSignController,
                        ),
                        SizedBox(height: 15),
                        GenderWidget(),
                        SizedBox(height: 15),
                        /// Date of Birth Picker
                        InkWell(
                          onTap: () {
                            _authController.selectDate(context);
                          },
                          child: CustomFormField(
                            enable: false,
                            readOnly: true,
                            suffixIcon: const Icon(Icons.date_range, color: AppColors.primary),
                            label: AppConstents.dob,
                            hint: "Select your date of birth",
                            controller: _authController.dateController,
                          ),
                        ),
                        SizedBox(height: 15),
                        /// Weight Field
                        CustomFormField(
                          label: AppConstents.weight,
                          hint: "Enter your weight (kg)",
                          controller: _authController.weightController,
                        ),
                        SizedBox(height: 15),
                        /// Height Field
                        CustomFormField(
                          label: AppConstents.height,
                          hint: "Enter your height (cm)",
                          controller: _authController.heightController,
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
                padding: EdgeInsets.only(
                  right: AppDimensions.width(20.0),
                  bottom: AppDimensions.width(20.0),
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 668,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      TermsCheckboxWidget(
                        authController: _authController,
                        message: "I have read and agree with the Terms & Conditions",
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                          width: AppDimensions.width(193),
                          child: ScanButton(
                            onPressed: () {},
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
      ),
    );
  }
}
