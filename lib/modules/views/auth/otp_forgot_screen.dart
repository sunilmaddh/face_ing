import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/modules/views/auth/auth_controller.dart';
import 'package:ntt_data/modules/views/auth/widgets/otp_field_widget.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/button/primary_button.dart';

class OtpForgotScreen extends StatelessWidget {
  OtpForgotScreen({super.key});
  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: PrimaryButton(text: "Verify", onPressed: () {}),
      appBar: CustomAppBar(title: "Otp screen"),
      body: OtpFieldWidget(
        title: "Enter OTP",
        onVerify: () {
          _authController.verifyForgotOtp();
        },
        onResend: () {},
        otp: _authController.otp,
        isResendEnabled: false.obs,
        timerSeconds: 0.obs,
      ),
    );
  }
}
