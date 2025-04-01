import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/modules/views/auth/auth_controller.dart';
import 'package:ntt_data/modules/views/auth/widgets/terms_checkbox_widget.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/button/primary_button.dart';
import 'package:ntt_data/widgets/fields/custom_form_field.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final _authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: AppConstents.signUp),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Stack(
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppDimensions.height(30)),
                  CustomFormField(
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return "Please enter email ID";
                      }
                      return null;
                    },
                    label: AppConstents.email,
                    hint: AppConstents.emailHint,
                    controller: _authController.emailSignController,
                  ),
                  SizedBox(height: 20),
                  CustomFormField(
                    obscureText: true,
                    validator: (pass) {
                      if (pass == null || pass.isEmpty) {
                        return "Please enter password";
                      }
                      return null;
                    },
                    label: AppConstents.password,
                    hint: AppConstents.passHint,
                    controller: _authController.passwordSignController,
                  ),
                  SizedBox(height: 20),
                  CustomFormField(
                    validator: (confPass) {
                      if (confPass == null || confPass.isEmpty) {
                        return "Please enter confirm password";
                      } else if (_authController.passwordSignController.text !=
                          _authController.confirmPasswordController.text) {
                        return "Confirm password should be same as password";
                      }
                      return null;
                    },
                    label: AppConstents.confirmPassword,
                    hint: AppConstents.confPassHint,
                    controller: _authController.confirmPasswordController,
                  ),
                  SizedBox(height: AppDimensions.height(10)),
                  TermsCheckboxWidget(
                    authController: _authController,
                    message:
                        "Accept to the legal terms by clicking on the check box to be able to provide services",
                  ),
                ],
              ),
            ),
            Obx(
              () => Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: AppDimensions.height(100),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: PrimaryButton(
                          isLoading: _authController.isLoading.value,
                          text: AppConstents.signUp,
                          onPressed: () {
                            // AppNavigation.to(AppRoutes.otpFieldWidget);
                            if (_formKey.currentState!.validate()) {
                              if (_authController.isChecked.value) {
                                _authController.getSingUpOtp();
                              } else {
                                AppSnackbar.show(
                                  title: "Term & Conditons",
                                  message: "Please select term & conditions",
                                );
                              }
                            }
                          },
                        ),
                      ),
                      SizedBox(height: AppDimensions.height(20)),
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
