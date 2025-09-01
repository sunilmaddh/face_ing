import 'dart:io';
import 'package:biosensesignal_flutter_sdk/images/image_validity.dart';
import 'package:biosensesignal_flutter_sdk/ui/camera_preview_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ntt_data/binah/face_detection_view.dart';
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
      onChange: (newSize) {
        // Update size only if it actually changed to avoid rebuild loops
        if (size != newSize) {
          setState(() => size = newSize);
        }
      },
      child: SizedBox(
        width: double.infinity,
        child: AspectRatio(
          aspectRatio: 0.75, // ideally match your real camera aspect ratio
          child: Stack(
            fit: StackFit.expand,
            children: [
              //Camera preview should be the background
              const CameraPreviewView(),
              // FaceDetectionView(size: size),

              // Overlay should be the foreground
              if (size != null) FaceDetectionView(size: size),
              //// ✅ Use corrected overlay
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

      // --- Step 1: Convert ROI to pixel-based Rect ---
      final bool isNormalized =
          roi.left <= 1 && roi.top <= 1 && roi.width <= 1 && roi.height <= 1;
      Rect roiRect =
          isNormalized
              ? Rect.fromLTWH(
                roi.left * imageInfo!.imageWidth,
                roi.top * imageInfo.imageHeight,
                roi.width * imageInfo.imageWidth,
                roi.height * imageInfo.imageHeight,
              )
              : Rect.fromLTWH(
                roi.left.toDouble(),
                roi.top.toDouble(),
                roi.width.toDouble(),
                roi.height.toDouble(),
              );

      // --- Step 2: Map SDK ROI to Flutter widget coordinates ---
      final mappedRoi = _mapToWidgetRect(
        sdkRect: roiRect,
        imageSize: Size(
          imageInfo!.imageWidth.toDouble(),
          imageInfo.imageHeight.toDouble(),
        ),
        widgetSize: size!,
        isFrontCamera: true, // Front camera measurement
        rotate90: true, // Most Android cameras in portrait mode need this
      );

      // --- Step 3: Draw ROI as SVG ---
      return Stack(
        children: [
          Positioned.fromRect(
            rect: mappedRoi,
            child: SvgPicture.asset(
              AppAssets.faceDetact,
              color:
                  imageInfo.imageValidity != ImageValidity.valid
                      ? AppColors.camreraPreviewColor
                      : AppColors.btntext,
            ),
          ),
        ],
      );
    });
  }

  /// Corrected ROI mapping with rotation, mirroring, and BoxFit.cover handling
  Rect _mapToWidgetRect({
    required Rect sdkRect,
    required Size imageSize,
    required Size widgetSize,
    required bool isFrontCamera,
    bool rotate90 = true,
  }) {
    // Step 1: Handle 90° rotation if needed
    Rect rotatedRect = sdkRect;
    Size rotatedImageSize = imageSize;

    if (rotate90) {
      rotatedRect = Rect.fromLTWH(
        sdkRect.top,
        imageSize.width - sdkRect.right,
        sdkRect.height,
        sdkRect.width,
      );
      rotatedImageSize = Size(imageSize.height, imageSize.width);
    }

    // Step 2: Compute scale factor for BoxFit.cover
    final scaleX = widgetSize.width / rotatedImageSize.width;
    final scaleY = widgetSize.height / rotatedImageSize.height;
    final scale = scaleX > scaleY ? scaleX : scaleY;

    // Step 3: Compute scaled frame dimensions
    final scaledWidth = rotatedImageSize.width * scale;
    final scaledHeight = rotatedImageSize.height * scale;

    // Step 4: Compute offset for center-crop
    final offsetX = (widgetSize.width - scaledWidth) / 2;
    final offsetY = (widgetSize.height - scaledHeight) / 2;

    // Step 5: Map ROI to widget coordinates
    var mapped = Rect.fromLTWH(
      rotatedRect.left * scale + offsetX,
      rotatedRect.top * scale + offsetY,
      rotatedRect.width * scale,
      rotatedRect.height * scale,
    );

    // Step 6: Mirror horizontally for front camera
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
