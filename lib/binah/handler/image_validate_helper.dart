import 'package:biosensesignal_flutter_sdk/images/image_data.dart'
    as sdk_image_data;
import 'package:biosensesignal_flutter_sdk/images/image_validity.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ImageValidityHelper {
  final RxBool showImageValidity;
  final Rx<sdk_image_data.ImageData>
  imageData; // Replace `dynamic` with your actual ImageData type
  final Function(String message) handleValid;
  final Function(String message) handleInvalid;

  ImageValidityHelper({
    required this.showImageValidity,
    required this.imageData,
    required this.handleValid,
    required this.handleInvalid,
  });

  void onImageDataReceived(dynamic imageData) {
    this.imageData.value = imageData;
    debugPrint("Image validity: ${imageData.imageValidity}");

    showImageValidity.value = true;

    switch (imageData.imageValidity) {
      case ImageValidity.valid:
        handleValid("Perfect! Please hold it.");
        break;

      case ImageValidity.invalidDeviceOrientation:
        handleInvalid("Return to portrait mode.");
        break;

      case ImageValidity.invalidRoi:
      case ImageValidity.faceTooFar:
        handleInvalid("Please move your face closer to the camera.");
        break;

      case ImageValidity.tiltedHead:
        handleInvalid(
          "Make sure your head is upright and centered in the frame.",
        );
        break;

      case ImageValidity.unevenLight:
        handleInvalid(
          "Ensure your face is clearly visible with no shadows or bright spots.",
        );
        break;

      default:
        handleInvalid("Unknown Error");
        break;
    }
  }
}
