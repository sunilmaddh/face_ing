import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/common_dialog.dart';
import 'package:ntt_data/modules/views/auth/auth_controller.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/button/primary_button.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';
import 'package:ntt_data/widgets/fields/custom_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _authController = Get.find<AuthController>();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Future.microtask(() async {
      await IndoSharedPreference.instance.saveWalkScreen(true);
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        isLeading: false,
        onTop: () {
          AppNavigation.back();
        },
        title: "Login",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Stack(
          children: [
            SafeArea(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppDimensions.height(30)),
                    Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(AppAssets.logo),
                    ),
                    SizedBox(height: AppDimensions.height(45)),
                    CustomFormField(
                      validator: (email) {
                        if (email == null || email.isEmpty) {
                          return "Please enter email ID";
                        }
                        return null;
                      },
                      label: AppConstents.email,
                      hint: AppConstents.emailHint,
                      controller: _authController.emailController,
                    ),
                    SizedBox(height: 20),
                    CustomFormField(
                      obscureText: true,
                      validator: (password) {
                        if (password == null || password.isEmpty) {
                          return "Please enter password";
                        }
                        return null;
                      },
                      label: AppConstents.password,
                      hint: AppConstents.passHint,
                      controller: _authController.passwordController,
                    ),
                    SizedBox(height: AppDimensions.height(10)),
                    InkWell(
                      onTap: () {
                        CommonDialog().showFullWidthDialog(
                          isLoading: _authController.isLoading,
                          title: "Forgot password",
                          textController: _authController.forgotEmailController,
                          onPressed: () {
                            _authController.getForgetOtp();
                          },
                        );
                        // AppNavigation.to(AppRoutes.resetPassword);
                      },
                      child: CommonText.text(
                        AppConstents.forgotPassword,
                        fontSize: AppDimensions.font(16),
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: AppDimensions.height(100),
                child: Column(
                  children: [
                    Obx(
                      () => Align(
                        alignment: Alignment.bottomRight,
                        child: PrimaryButton(
                          isLoading: _authController.isLoading.value,
                          text: AppConstents.login,
                          // isLoading: _authController.isLoading.value,
                          onPressed: () {
                            // AppNavigation.to(AppRoutes.homeScreen);
                            if (_formKey.currentState!.validate()) {
                              _authController.userLogin();
                              // AppNavigation.to(AppRoutes.homeScreen);
                            }

                            // AppNavigation.to(AppRoutes.homeScreen);
                          },
                        ),
                      ),
                      // SizedBox(height: AppDimensions.height(20)),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     CommonText.text(
                      //       AppConstents.donThaveAccoount,
                      //       fontSize: AppDimensions.font(16),
                      //       fontWeight: FontWeight.w400,
                      //       color: AppColors.blackColor,
                      //     ),
                      //     SizedBox(width: AppDimensions.width(5)),
                      //     InkWell(
                      //       onTap: () {
                      //         AppNavigation.to(AppRoutes.createAccount);
                      //       },
                      //       child: CommonText.text(
                      //         AppConstents.signUp,
                      //         color: AppColors.primary,
                      //         fontSize: AppDimensions.font(16),
                      //         fontWeight: FontWeight.w500,
                      //       ),
                      //     ),
                      //   ],
                      // ),
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

  @override
  void dispose() {
    // TODO: implement dispose
    _authController.clearData();
    super.dispose();
  }
}
