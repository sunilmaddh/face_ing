import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/auth/auth_controller.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/button/primary_button.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';
import 'package:ntt_data/widgets/fields/custom_form_field.dart';

class LoginScreen extends StatelessWidget {
  
   LoginScreen({super.key});
  final _authController=Get.find<AuthController>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         backgroundColor: Colors.white,
      appBar:CustomAppBar(title: "Login"),
       body: Padding(
      padding:EdgeInsets.symmetric(horizontal: 20,vertical: 20),     child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                 SizedBox(height:AppDimensions.height(30),),
                 CustomFormField(label:AppConstents.email, hint: AppConstents.emailHint, controller: _authController.emailController,),
            SizedBox(height: 20,),
            CustomFormField(label: AppConstents.password, hint: AppConstents.passHint, controller: _authController.passwordController,),
            SizedBox(height: AppDimensions.height(10),),
            InkWell(
              onTap: (){
                AppNavigation.to(AppRoutes.resetPassword);
              },
              child: CommonText.text(AppConstents.forgotPassword,fontSize: AppDimensions.font(16),fontWeight:FontWeight.w500,color: AppColors.primary)),
 
          ],),
           Align(
            alignment: Alignment.bottomCenter,
             child: SizedBox(
              height: AppDimensions.height(100),
              child:Column(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: PrimaryButton(text: AppConstents.login, onPressed: (){
                      AppNavigation.to(AppRoutes.homeScreen);
                    })),
                  SizedBox(height: AppDimensions.height(20),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonText.text(AppConstents.donThaveAccoount,fontSize: AppDimensions.font(16),fontWeight: FontWeight.w400,color: AppColors.blackColor),
                     SizedBox(width: AppDimensions.width(5),),
                     InkWell(
                        onTap: (){
                          AppNavigation.to(AppRoutes.singnUp);
                        },
                        child: CommonText.text(AppConstents.signUp,color: AppColors.primary,fontSize: AppDimensions.font(16),fontWeight: FontWeight.w500)),
                    ],
                  )
                ],
              ),
             ),
           )
        ],
      ),
    ),);
  }
}