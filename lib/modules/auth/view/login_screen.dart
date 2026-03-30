import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ntt_data/core/base/base_view.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_strings.dart';
import 'package:ntt_data/core/constants/validation_strings.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/dialog/common_dialog.dart';
import 'package:ntt_data/modules/auth/controllers/auth_controller.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/button/primary_button.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';
import 'package:ntt_data/widgets/fields/custom_form_field.dart';

class LoginScreen extends BaseView<AuthController> {
  LoginScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget buildView(BuildContext context, AuthController controller) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        isLeading: false,
        onTop: () {
          AppNavigation.back();
        },
        title: AppStrings.login,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      MediaQuery.of(context).size.height -
                      kToolbarHeight -
                      MediaQuery.of(context).padding.top -
                      40,
                ),
                child: IntrinsicHeight(
                  child: Column(
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
                            return ValidationStrings.pleaseEnterEmail;
                          }
                          return null;
                        },
                        label: AppStrings.email,
                        hint: ValidationStrings.emailHint,
                        controller: controller.emailController,
                      ),
                      const SizedBox(height: 20),
                      CustomFormField(
                        obscureText: true,
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return ValidationStrings.enterPassword;
                          }
                          return null;
                        },
                        label: AppStrings.password,
                        hint: ValidationStrings.passHint,
                        controller: controller.passwordController,
                      ),
                      SizedBox(height: AppDimensions.height(10)),
                      InkWell(
                        onTap: () {
                          CommonDialog().showFullWidthDialog(
                            isLoading: controller.isLoading,
                            title: ValidationStrings.forgotPasswordTitle,
                            textController: controller.forgotEmailController,
                            onPressed: () {
                              controller.getForgetOtp();
                            },
                          );
                        },
                        child: CommonText.titleMedium(
                          AppStrings.forgotPassword,
                          color: AppColors.primary,
                        ),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: PrimaryButton(
                          isLoading: controller.isLoading.value,
                          text: AppStrings.login,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              controller.userLogin();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
