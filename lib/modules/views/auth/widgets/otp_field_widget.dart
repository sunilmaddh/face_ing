import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/controllers.dart/otp_controller.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/button/primary_button.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';
import 'package:pinput/pinput.dart';

class OtpFieldWidget extends StatelessWidget {
   OtpFieldWidget({super.key});

   final OTPController otpController = Get.put(OTPController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: PrimaryButton(text: "Verify", onPressed: (){
        AppNavigation.to(AppRoutes.createAccount);
      }),
      appBar: CustomAppBar(title: "Verify"),
      body: Padding(
        padding:  EdgeInsets.all(AppDimensions.padding(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText.text("Enter otp",fontSize: AppDimensions.font(16),fontWeight:FontWeight.w600),
            Align(
              alignment: Alignment.center,
              child: Pinput( 
                length: 4,
                keyboardType: TextInputType.number,
                // onChanged: (value) => otpController.setOTP(value),
                // onCompleted: (pin) => otpController.verifyOTP(),
                defaultPinTheme: PinTheme(
                  margin: EdgeInsets.symmetric(horizontal:AppDimensions.padding(3),vertical: AppDimensions.padding(8)),
                  width:AppDimensions.width(68),
                  height: AppDimensions.height(66),
                  textStyle: TextStyle(fontSize: AppDimensions.font(20), fontWeight: FontWeight.bold),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppDimensions.radius(15)),
                    border: Border.all(color: AppColors.borderColor),
                  ),
                ),
                focusedPinTheme: PinTheme(
                  width:AppDimensions.width(68),
                  height: AppDimensions.height(66),
                  textStyle: TextStyle(fontSize: AppDimensions.font(20), fontWeight: FontWeight.bold),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppDimensions.radius(15)),
                    border: Border.all(color: AppColors.primary),
                  ),
                ),
                crossAxisAlignment: CrossAxisAlignment.center,
               
              ),
            ),
            SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(
                  otpController.isResendEnabled.value
                      ? "Didn't receive the OTP?"
                      : "Resend OTP in ${otpController.timerSeconds.value}s",
                  style: TextStyle(fontSize: 16, color: Colors.grey,fontWeight: FontWeight.w700),
                )),
            SizedBox(height: 10),
            Obx(() => TextButton(
               
                  onPressed: otpController.isResendEnabled.value
                      ? otpController.resendOTP
                      : null,
                  child: Text(
                    "Resend OTP",
                    style: TextStyle(
                      fontSize: 15,
                      
                      color: otpController.isResendEnabled.value
                          ? AppColors.primary
                          : Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )),
          ],
        ),
           
          ],
        ),
      ),
    );
  }
}