import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CameraPreviewView extends StatelessWidget {
  static const String _viewType =
      "plugins.biosensesignal.com/camera_preview_view";

  const CameraPreviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final double width = screenWidth * 0.80;
    final double height = screenHeight * 0.90;

    Widget createNativeView() {
      if (defaultTargetPlatform == TargetPlatform.android) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: height,
          child: const AndroidView(
            viewType: _viewType,
            creationParams: null,
            creationParamsCodec: StandardMessageCodec(),
          ),
        );
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        return SizedBox(
          width: width,
          height: height,
          child: const UiKitView(
            viewType: _viewType,
            creationParams: null,
            creationParamsCodec: StandardMessageCodec(),
          ),
        );
      } else {
        return const Center(child: Text("Platform not supported"));
      }
    }

    return Center(
      child: createNativeView(),
    );
  }
}
