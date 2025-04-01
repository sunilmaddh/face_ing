import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';
import 'package:pinput/pinput.dart';

class OtpFieldWidget extends StatelessWidget {
  final String title;
  final VoidCallback onVerify;
  final VoidCallback onResend;
  final RxString otp;
  final RxBool isResendEnabled;
  final RxInt timerSeconds;

  const OtpFieldWidget({
    super.key,
    required this.title,
    required this.onVerify,
    required this.onResend,
    required this.otp,
    required this.isResendEnabled,
    required this.timerSeconds,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: AppDimensions.font(16),
              fontWeight: FontWeight.w600,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Pinput(
              length: 4,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                otp.value = value;
              },
              onCompleted: (pin) {
                otp.value = pin;
              },
              defaultPinTheme: PinTheme(
                margin: EdgeInsets.symmetric(
                  horizontal: AppDimensions.padding(3),
                  vertical: AppDimensions.padding(8),
                ),
                width: AppDimensions.width(68),
                height: AppDimensions.height(66),
                textStyle: TextStyle(
                  fontSize: AppDimensions.font(20),
                  fontWeight: FontWeight.bold,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimensions.radius(15)),
                  border: Border.all(color: AppColors.borderColor),
                ),
              ),
              focusedPinTheme: PinTheme(
                width: AppDimensions.width(68),
                height: AppDimensions.height(66),
                textStyle: TextStyle(
                  fontSize: AppDimensions.font(20),
                  fontWeight: FontWeight.bold,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimensions.radius(15)),
                  border: Border.all(color: AppColors.primary),
                ),
              ),
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
          SizedBox(height: 20),
          Obx(
            () =>
                isResendEnabled.value == false
                    ? Center(
                      child: CommonText.text(
                        timerSeconds.value.toString(),
                        fontSize: AppDimensions.font(18),
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    )
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't receive the OTP?",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        TextButton(
                          onPressed: onResend,
                          child: Text(
                            "Resend OTP",
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
          ),
        ],
      ),
    );
  }
}
