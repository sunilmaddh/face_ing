import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/modules/auth/controllers/auth_controller.dart';
import 'package:ntt_data/modules/auth/widgets/otp_field_widget.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/button/primary_button.dart';

class OtpForgotScreen extends StatelessWidget {
  OtpForgotScreen({super.key});
  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(
        () => PrimaryButton(
          isLoading: _authController.isLoading.value,
          text: "Verify",
          onPressed: () {
            if (_authController.otp.value.length != 4) {
              AppSnackbar.show(
                title: "Incorrect OTP",
                message: "Please enter correct otp",
              );
            } else {
              _authController.verifyForgotOtp();
            }
          },
        ),
      ),
      appBar: CustomAppBar(
        onTop: () {
          AppNavigation.back();
        },
        title: "Otp screen",
      ),
      body: OtpFieldWidget(
        title: "Enter OTP",

        onResend: () {
          _authController.getForgetOtp();
        },
        otp: _authController.otp,
        isResendEnabled: _authController.isResendEnabled,
        timerSeconds: _authController.timerSeconds,
      ),
    );
  }
}
