import 'dart:io';
import 'package:biosensesignal_flutter_sdk/images/image_validity.dart';
import 'package:biosensesignal_flutter_sdk/ui/camera_preview_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ntt_data/binah/measurement_controller.dart';
import 'package:ntt_data/binah/widget_size.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';

class CameraPreview extends StatefulWidget {
  const CameraPreview({super.key, required this.controller});
  final MeasurementController controller;

  @override
  State<CameraPreview> createState() => _CameraPreviewState();
}

class _CameraPreviewState extends State<CameraPreview> {
  Size? size;

  @override
  Widget build(BuildContext context) {
    return WidgetSize(
      onChange: (newSize) => setState(() => size = newSize),
      child: SizedBox(
        width: double.infinity,
        child: AspectRatio(
          aspectRatio: 0.75, // your camera preview ratio
          child: Stack(
            children: [
              const CameraPreviewView(),
              FaceDetectionOverlay(size: size),
            ],
          ),
        ),
      ),
    );
  }
}

class FaceDetectionOverlay extends StatelessWidget {
  final Size? size;
  FaceDetectionOverlay({super.key, required this.size});

  final controller = Get.find<MeasurementController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final imageInfo = controller.imageData.value;
      final roi = imageInfo?.roi;
      if (roi == null || size == null) return const SizedBox();

      // Debug log for analysis
      print(
        "SDK ROI: left=${roi.left}, top=${roi.top}, width=${roi.width}, height=${roi.height}",
      );
      print("Image Size: ${imageInfo!.imageWidth} x ${imageInfo.imageHeight}");
      print("Widget Size: ${size!.width} x ${size!.height}");

      // --- STEP 1: Determine if ROI is normalized or pixel-based ---
      Rect roiRect;
      if (roi.left <= 1 && roi.top <= 1 && roi.width <= 1 && roi.height <= 1) {
        // Normalized ROI: multiply by image size
        roiRect = Rect.fromLTWH(
          roi.left * imageInfo.imageWidth,
          roi.top * imageInfo.imageHeight,
          roi.width * imageInfo.imageWidth,
          roi.height * imageInfo.imageHeight,
        );
      } else {
        // Already in pixels
        roiRect = Rect.fromLTWH(
          roi.left.toDouble(),
          roi.top.toDouble(),
          roi.width.toDouble(),
          roi.height.toDouble(),
        );
      }

      // --- STEP 2: Map to widget coordinates with center crop ---
      final mappedRoi = _mapToWidgetRect(
        sdkRect: roiRect,
        imageSize: Size(
          imageInfo.imageWidth.toDouble(),
          imageInfo.imageHeight.toDouble(),
        ),
        widgetSize: size!,
        isFrontCamera: true, // always front camera for measurement
      );

      // --- STEP 3: Draw ROI SVG ---
      return Positioned.fromRect(
        rect: mappedRoi,
        child: SvgPicture.asset(
          AppAssets.faceDetact,
          color:
              imageInfo.imageValidity != ImageValidity.valid
                  ? AppColors.camreraPreviewColor
                  : AppColors.btntext,
        ),
      );
    });
  }

  /// Maps SDK rectangle (ROI) to Flutter UI coordinates with aspect ratio + center crop fix
  Rect _mapToWidgetRect({
    required Rect sdkRect,
    required Size imageSize,
    required Size widgetSize,
    required bool isFrontCamera,
  }) {
    // Step 1: Determine scale factor to cover widget (BoxFit.cover behavior)
    final scaleX = widgetSize.width / imageSize.width;
    final scaleY = widgetSize.height / imageSize.height;
    final scale = scaleX > scaleY ? scaleX : scaleY;

    // Step 2: Compute scaled native frame
    final scaledWidth = imageSize.width * scale;
    final scaledHeight = imageSize.height * scale;

    // Step 3: Compute letterbox/padding offset (center crop)
    final dx = (widgetSize.width - scaledWidth) / 2;
    final dy = (widgetSize.height - scaledHeight) / 2;

    // Step 4: Map ROI coordinates
    Rect mapped = Rect.fromLTWH(
      sdkRect.left * scale + dx,
      sdkRect.top * scale + dy,
      sdkRect.width * scale,
      sdkRect.height * scale,
    );

    // Step 5: Mirror for front camera
    if (isFrontCamera) {
      mapped = Rect.fromLTWH(
        widgetSize.width - mapped.right,
        mapped.top,
        mapped.width,
        mapped.height,
      );
    }

    return mapped;
  }
}
