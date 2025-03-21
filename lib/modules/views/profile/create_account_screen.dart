import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/auth/auth_controller.dart';
import 'package:ntt_data/modules/views/profile/widgets/gender_widget.dart';
import 'package:ntt_data/routes/app_navigation.dart' show AppNavigation;
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/button/primary_button.dart';
import 'package:ntt_data/widgets/fields/custom_form_field.dart';

class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({super.key});

  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: PrimaryButton(
        text: AppConstents.continueBtn,
        onPressed: () {
          // _authController.selectDate(context);
           AppNavigation.to(AppRoutes.profileUpload);
        },
      ),
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: AppConstents.createAccount),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          children: [
            SizedBox(height: AppDimensions.height(0)),

            /// Name Field
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
                suffixIcon: const Icon(Icons.date_range,color: AppColors.primary,),
                label: AppConstents.dob,
                hint: "Select your date of birth", 
                controller: _authController.dateController,
              ),
            ),
            SizedBox(height: 15),

            /// Weight Field
            CustomFormField(
              keyboardType: TextInputType.number,
              label: AppConstents.weight,
              hint: "Enter your weight (kg)", 
              controller: _authController.weightController, 
            ),
            SizedBox(height: 15),

            /// Height Field
            CustomFormField(
              keyboardType: TextInputType.number,
              label: AppConstents.height,
              hint: "Enter your height (cm)",
              controller: _authController.heightController, 
            ),
          ],
        ),
      ),
    );
  }
}
