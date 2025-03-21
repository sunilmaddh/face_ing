import 'dart:io';
import 'package:image_picker/image_picker.dart';
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
}
