import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
