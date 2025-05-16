import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/auth/auth_controller.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/button/primary_button.dart';
import 'package:ntt_data/widgets/fields/custom_form_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});
  final _authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        onTop: () {
          AppNavigation.back();
        },
        title: AppConstents.resetPassword,
      ),
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
                    obscureText: true,
                    label: AppConstents.password,
                    hint: AppConstents.passHint,
                    controller: _authController.passwordController,
                  ),
                  SizedBox(height: 20),
                  CustomFormField(
                    label: AppConstents.confirmPassword,
                    hint: AppConstents.confPassHint,
                    controller: _authController.confirmPasswordController,
                  ),
                ],
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: AppDimensions.height(100),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: PrimaryButton(
                        text: AppConstents.confirm,
                        onPressed: () {
                          _authController.resetPassword();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
