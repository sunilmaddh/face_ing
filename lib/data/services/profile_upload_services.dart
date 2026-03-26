// import 'dart:io';
// import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:image/image.dart' as img;

import 'dart:io';

enum ImagePickSource { camera, gallery }

class ProfileUploadService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImageFromCamera() async {
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) return null; // User canceled
    return File(image.path);
  }

  Future<File?> pickImageFromGallery() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null; // User canceled
    return File(image.path);
  }

  //   Future<void> uploadUserProfileImage({
  //     required ImagePickSource source,
  //     required String imageType,
  //   }) async {
  //     await _uploadProfileImage(
  //       source: source,
  //       imageType: imageType,
  //       guestId: '',
  //       isGuest: false,
  //       uploadRequest: ({
  //         required File file,
  //         required String userId,
  //         required String imageType,
  //         required String guestId,
  //         required bool isGuest,
  //       }) async {
  //         return await authServices.uploadDocument(
  //           file,
  //           userId,
  //           imageType,
  //           guestId,
  //           isGuest.toString(),
  //         );
  //       },
  //     );
  //   }

  //   Future<void> uploadGuestProfileImage({
  //     required ImagePickSource source,
  //     required String imageType,
  //     required String guestId,
  //   }) async {
  //     await _uploadProfileImage(
  //       source: source,
  //       imageType: imageType,
  //       guestId: guestId,
  //       isGuest: true,
  //       uploadRequest: ({
  //         required File file,
  //         required String userId,
  //         required String imageType,
  //         required String guestId,
  //         required bool isGuest,
  //       }) async {
  //         return await guestService.uploadDocument(
  //           file,
  //           userId,
  //           imageType,
  //           guestId,
  //           isGuest.toString(),
  //         );
  //       },
  //     );
  //   }

  Future<File> uploadProfileImage({required ImagePickSource source}) async {
    try {
      final pickedImage =
          source == ImagePickSource.camera
              ? await pickImageFromCamera()
              : await pickImageFromGallery();

      if (pickedImage == null) {
        return File("");
      }

      final file = File(pickedImage.path);
      return await fixExifRotation(file);
    } catch (e) {
      debugPrint("_uploadProfileImage error: $e");
      return File("");
    } finally {}
  }

  Future<File> fixExifRotation(File file) async {
    final bytes = await file.readAsBytes();
    final image = img.decodeImage(bytes);
    if (image == null) return file;

    final fixed = img.bakeOrientation(image);
    return await file.writeAsBytes(img.encodeJpg(fixed));
  }
}

//  final userId = await IndoSharedPreference.instance.getUserId();

//     final responseData = await uploadRequest(
//       file: profileUrl.value,
//       userId: userId,
//       imageType: imageType,
//       guestId: guestId,
//       isGuest: isGuest,
//     );

//     final int statusCode = responseData["responseCode"] ?? 0;
//     debugPrint("upload statusCode: $statusCode");

//     if (statusCode != 200) {
//       Get.snackbar("Upload Failed", "Please try again");
//       return;
//     }

//     final result = responseData["response"];
//     uploadImageResponseModel.value = result;

//     final imagePath = uploadImageResponseModel.value.imagePath ?? "";

//     if (isGuest) {
//       Get.find<GuestController>().guestImage.value = imagePath;
//       if (guestId.isNotEmpty) {
//         profileUrl.value = File("");
//       }
//     } else {
//       userImage.value = imagePath;
//       await IndoSharedPreference.instance.saveUserImage(imagePath);
//     }

//     AppSnackbar.show(title: "Success", message: "Profile uploaded");
