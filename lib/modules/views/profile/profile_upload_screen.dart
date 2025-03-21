import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ntt_data/controllers.dart/profile_controller.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/button/primary_button.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class ProfileUploadScreen extends StatelessWidget {
   ProfileUploadScreen({super.key});
  final _profileController=Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         backgroundColor: Colors.white,
      appBar: CustomAppBar(title: AppConstents.upload),
       body: SafeArea(
         child: Padding(
               padding:EdgeInsets.symmetric(horizontal: 20,vertical: 20),     child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Align(
                alignment: Alignment.centerRight,
                child: CommonText.text(AppConstents.uploadPhotoHeading,color: AppColors.profileTitleColor,fontSize: AppDimensions.font(16),fontWeight: FontWeight.w500)),
                 SizedBox(height: AppDimensions.height(60),),
               Obx(()=>SizedBox(
                height: AppDimensions.height(190),
                width: AppDimensions.width(220),
                 child: Stack(
                   children: [
                     Container(height: AppDimensions.height(161),
                     padding: EdgeInsets.all(8.0),
                     width: AppDimensions.width(206),
                     decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9.0),
                      color: AppColors.uploadCardColor),
                      child:_profileController.profileUrl!=null?Image.file(_profileController.profileUrl.value,fit:BoxFit.cover,): SvgPicture.asset("assets/images/svg/profile.svg"),
                      ),
                        InkWell(
                          onTap: (){
                              _profileController.uploadProfileFromGallery();
                          },
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle),
                              child: Icon(Icons.add,color: 
                               AppColors.btntext),
                            ),
                          ),
                        )
                   ],
                 ),
               ))
            
            ],),
             Align(
              alignment: Alignment.bottomCenter,
               child: SizedBox(
                height: AppDimensions.height(100),
                child:Column(
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: PrimaryButton(text: AppConstents.upload, onPressed: (){
                        AppNavigation.to(AppRoutes.healthMenu);
                      })),
                   
                  ],
                ),
               ),
             )
          ],
               ),
             ),
       ),);
  }
}