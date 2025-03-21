import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/services/profile_upload_services.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class ProfileController extends GetxController {
 RxBool isGenderType=false.obs;

  RxString selectionType="".obs;
Rx<File> profileUrl = File("").obs;
  final ProfileUploadService _uploadService = ProfileUploadService();

  Future<void> uploadProfileFromGallery() async {
    var imageUrl = await _uploadService.pickImageFromGallery();
    if (imageUrl != null) {
      profileUrl.value =File(imageUrl.path);
    } else {
      Get.snackbar("Upload Failed", "Please try again");
    }
  }
  void showDeleteUserDialog(BuildContext context, VoidCallback onConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: CommonText.text("Want to Remove the Geust?",maxLines: 2,fontSize: AppDimensions.font(18),fontWeight: FontWeight.w400,fontFamily: "Gilroy-Bold"),
        content:        CommonText.text("Are you sure you want to remove? This action cannot be undone ",maxLines: 2,fontSize: AppDimensions.font(15),fontWeight: FontWeight.w400,fontFamily: "Gilroy-Medium"),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        actions: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    height: AppDimensions.height(40),
                    width: AppDimensions.width(125),
                    child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close dialog
                                  onConfirm(); // Execute delete action
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6),)),
                                child: CommonText.text("Delete",color: AppColors.btntext),
                              ),
                  ),
                SizedBox(width: AppDimensions.width(2),),
                  SizedBox(
                    height: AppDimensions.height(40),
                    width: AppDimensions.width(125),
                    child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close dialog
                                  onConfirm(); // Execute delete action
                                },
                                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6),side: BorderSide(color: AppColors.deleteDesColor))),
                                child: CommonText.text("Delete",color: AppColors.blackColor),
                              ),
                  ),
              ],
            ),
          )
          // TextButton(
          //   onPressed: () => Navigator.pop(context), // Close dialog
          //   child: Text("Cancel", style: TextStyle(color: Colors.grey)),
          // ),
        
        ],
      );
    },
  );
}

}