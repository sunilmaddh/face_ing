import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CameraOverlayScreen(),
    );
  }
}

class CameraOverlayScreen extends StatelessWidget {
  const CameraOverlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    final double ovalWidth = screenSize.width * 0.8;
    final double ovalHeight = screenSize.height * 0.5;

    return Scaffold(
      body: Stack(
        children: [
          // ✅ Fullscreen Camera Preview (Platform View)
          Positioned.fill(
            child:
                defaultTargetPlatform == TargetPlatform.android
                    ? const AndroidView(
                      viewType:
                          'plugins.biosensesignal.com/camera_preview_view',
                      creationParams: null,
                      creationParamsCodec: StandardMessageCodec(),
                    )
                    : const Center(child: Text("Unsupported Platform")),
          ),

          // ✅ Overlay with transparent oval cutout
          Positioned.fill(
            child: CustomPaint(
              painter: OverlayWithOvalHolePainter(
                center: Offset(screenSize.width / 2, screenSize.height / 2.6),
                radiusX: ovalWidth / 2,
                radiusY: ovalHeight / 2,
                overlayColor: Colors.black.withOpacity(0.6),
              ),
            ),
          ),

          // ✅ Bottom Instruction Card
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'tanmay , Ready to Measure your Vital Signs?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xFF2E2E5D),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Sit still, ensure your face is evenly illuminated and there is no light source in the background.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Start measurement
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 14,
                      ),
                      backgroundColor: const Color(0xFF2E2E5D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "MEASURE NOW",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OverlayWithOvalHolePainter extends CustomPainter {
  final Offset center;
  final double radiusX;
  final double radiusY;
  final Color overlayColor;

  OverlayWithOvalHolePainter({
    required this.center,
    required this.radiusX,
    required this.radiusY,
    required this.overlayColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Path screenPath =
        Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final Path ovalPath =
        Path()..addOval(
          Rect.fromCenter(
            center: center,
            width: radiusX * 2,
            height: radiusY * 2,
          ),
        );

    final Path mask = Path.combine(
      PathOperation.difference,
      screenPath,
      ovalPath,
    );

    canvas.drawPath(mask, Paint()..color = overlayColor);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Animated Progress Bar',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: ProgressBarScreen(),
//     );
//   }
// }

// class ProgressBarScreen extends StatefulWidget {
//   @override
//   _ProgressBarScreenState createState() => _ProgressBarScreenState();
// }

// class _ProgressBarScreenState extends State<ProgressBarScreen> {
//   int _progress = 0;
//   Timer? _timer;
//   final int totalSeconds = 60;

//   void startTimer() {
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (_progress >= 100) {
//         _timer?.cancel();
//       } else {
//         setState(() {
//           _progress += (100 ~/ totalSeconds);
//         });
//       }
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     startTimer();
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('FA Progress Bar')),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Text(
//               //   '$_progress%',
//               //   style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
//               // ),
//               // SizedBox(height: 24),
//               FAProgressBar(
//                 currentValue: _progress.toDouble(),
//                 displayText: '%',
//                 size: 20,
//                 maxValue: 100,
//                 animatedDuration: Duration(milliseconds: 300),
//                 progressColor: Colors.green,
//                 backgroundColor: Colors.grey.shade300,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// void main() {
//   runApp(const MyApp());
// }

// /// Main App Widget
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: CameraPreviewScreen(),
//     );
//   }
// }

// /// Screen with Camera Preview and Transparent Oval Overlay
// class CameraPreviewScreen extends StatelessWidget {
//   const CameraPreviewScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(body: CameraPreviewView());
//   }
// }

// /// Widget that displays the native camera preview with overlay
// class CameraPreviewView extends StatelessWidget {
//   static const String _viewType =
//       "plugins.biosensesignal.com/camera_preview_view";

//   const CameraPreviewView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;

//     // Oval hole dimensions (responsive)
//     final double holeWidth = screenSize.width * 0.80;
//     final double holeHeight = screenSize.height * 0.55;

//     // Create platform-native camera view
//     Widget createNativeView() {
//       if (defaultTargetPlatform == TargetPlatform.android) {
//         return const AndroidView(
//           viewType: _viewType,
//           creationParams: null,
//           creationParamsCodec: StandardMessageCodec(),
//         );
//       } else if (defaultTargetPlatform == TargetPlatform.iOS) {
//         return const UiKitView(
//           viewType: _viewType,
//           creationParams: null,
//           creationParamsCodec: StandardMessageCodec(),
//         );
//       } else {
//         return const Center(child: Text("Platform not supported"));
//       }
//     }

//     return Stack(
//       children: [
//         // Native camera view (full screen)
//         Positioned.fill(child: createNativeView()),

//         // Overlay with transparent oval in center
//         Positioned.fill(
//           child: CustomPaint(
//             painter: OvalHolePainter(
//               holeWidth: holeWidth,
//               holeHeight: holeHeight,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// /// Custom painter that draws a dimmed overlay with a transparent oval in the center
// class OvalHolePainter extends CustomPainter {
//   final double holeWidth;
//   final double holeHeight;

//   OvalHolePainter({required this.holeWidth, required this.holeHeight});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint =
//         Paint()
//           ..color = Colors.black.withOpacity(0.6)
//           ..style = PaintingStyle.fill;

//     final outerRect = Rect.fromLTWH(0, 0, size.width, size.height);
//     final path = Path()..addRect(outerRect);

//     final center = Offset(size.width / 2, size.height / 2);
//     final ovalRect = Rect.fromCenter(
//       center: center,
//       width: holeWidth,
//       height: holeHeight,
//     );

//     path.addOval(ovalRect);
//     path.fillType = PathFillType.evenOdd;

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(OvalHolePainter oldDelegate) => false;
// }
