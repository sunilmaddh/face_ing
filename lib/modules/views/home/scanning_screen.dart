import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:lottie/lottie.dart';

class ScanningScreen extends StatefulWidget {
  const ScanningScreen({super.key});

  @override
  _ScanningScreenState createState() => _ScanningScreenState();
}

class _ScanningScreenState extends State<ScanningScreen> {
  CameraController? _controller;
  late List<CameraDescription> _cameras;
 
 
 
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _controller = CameraController(_cameras[1], ResolutionPreset.high);
    await _controller!.initialize();
    if (mounted) {
      setState(() {
        _isCameraInitialized = true;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _isCameraInitialized
          ? Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: CameraPreview(_controller!,
                  
                  ),
                ), // Camera feed
                Positioned.fill(
                  child: Center(
                    child: LottieBuilder.asset("assets/images/lottie/scan_animation.json")
                    // DottedBorder(
                    //   borderType: BorderType.RRect,
                    //   radius: Radius.circular(12),
                    //   dashPattern: [10, 5],
                    //   strokeWidth: 3,
                    //   color: Colors.white,
                    //   child: Container(
                    //     width: 250,
                    //     height: 350,
                    //     decoration: BoxDecoration(
                    //       color: Colors.transparent,
                    //       borderRadius: BorderRadius.circular(12),
                    //     ),
                    //   ),
                    // ),
                  ),
                ),
                // Positioned(
                //   bottom: 50,
                //   left: 0,
                //   right: 0,
                //   child: Center(
                //     child: FloatingActionButton(
                //       onPressed: () async {
                //         final image = await _controller!.takePicture();
                //         print("Image Path: ${image.path}");
                //       },
                //       child: Icon(Icons.camera),
                //     ),
                //   ),
                // ),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
