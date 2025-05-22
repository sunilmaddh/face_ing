import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CameraPreviewView extends StatelessWidget {
  static const String _viewType =
      "plugins.biosensesignal.com/camera_preview_view";

  const CameraPreviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Set responsive size (adjust as needed)
    final double width = screenWidth * 0.83; // 85% of screen width
    final double height = screenHeight * 0.48; // 45% of screen height

    Widget createNativeView() {
      if (defaultTargetPlatform == TargetPlatform.android) {
        return ClipOval(
          child: SizedBox(
            width: width,
            height: height,
            child: const AndroidView(
              viewType: _viewType,
              creationParams: null,
              creationParamsCodec: StandardMessageCodec(),
            ),
          ),
        );
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        return ClipOval(
          child: SizedBox(
            width: width + 10,
            height: height + 20, // slightly taller for iOS if needed
            child: const UiKitView(
              viewType: _viewType,
              creationParams: null,
              creationParamsCodec: StandardMessageCodec(),
            ),
          ),
        );
      } else {
        return const Center(child: Text("Platform not supported"));
      }
    }

    return Center(child: createNativeView()); // Center the view in its parent
  }
}
