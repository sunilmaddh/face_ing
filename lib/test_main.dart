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
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

/// Main App Widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CameraPreviewScreen(),
    );
  }
}

/// Screen with Camera Preview and Transparent Oval Overlay
class CameraPreviewScreen extends StatelessWidget {
  const CameraPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: CameraPreviewView());
  }
}

/// Widget that displays the native camera preview with overlay
class CameraPreviewView extends StatelessWidget {
  static const String _viewType =
      "plugins.biosensesignal.com/camera_preview_view";

  const CameraPreviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    // Oval hole dimensions (responsive)
    final double holeWidth = screenSize.width * 0.80;
    final double holeHeight = screenSize.height * 0.55;

    // Create platform-native camera view
    Widget createNativeView() {
      if (defaultTargetPlatform == TargetPlatform.android) {
        return const AndroidView(
          viewType: _viewType,
          creationParams: null,
          creationParamsCodec: StandardMessageCodec(),
        );
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        return const UiKitView(
          viewType: _viewType,
          creationParams: null,
          creationParamsCodec: StandardMessageCodec(),
        );
      } else {
        return const Center(child: Text("Platform not supported"));
      }
    }

    return Stack(
      children: [
        // Native camera view (full screen)
        Positioned.fill(child: createNativeView()),

        // Overlay with transparent oval in center
        Positioned.fill(
          child: CustomPaint(
            painter: OvalHolePainter(
              holeWidth: holeWidth,
              holeHeight: holeHeight,
            ),
          ),
        ),
      ],
    );
  }
}

/// Custom painter that draws a dimmed overlay with a transparent oval in the center
class OvalHolePainter extends CustomPainter {
  final double holeWidth;
  final double holeHeight;

  OvalHolePainter({required this.holeWidth, required this.holeHeight});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.black.withOpacity(0.6)
          ..style = PaintingStyle.fill;

    final outerRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final path = Path()..addRect(outerRect);

    final center = Offset(size.width / 2, size.height / 2);
    final ovalRect = Rect.fromCenter(
      center: center,
      width: holeWidth,
      height: holeHeight,
    );

    path.addOval(ovalRect);
    path.fillType = PathFillType.evenOdd;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(OvalHolePainter oldDelegate) => false;
}
