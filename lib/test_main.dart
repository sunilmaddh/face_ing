// import 'package:flutter/material.dart';
// import 'package:get/get.dart'; // Import GetX
// import 'package:dotted_border/dotted_border.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Face Detection Circle',
//       // home: FaceDetectionTestPage(),
//     );
//   }
// }

// class ProgressController extends GetxController {
//   var progress = 0.0.obs; // Reactive progress
//   var isStarted = false.obs; // Reactive flag for animation start

//   // Method to start progress animation
//   void startProgress(
//     int durationInSeconds,
//     AnimationController animationController,
//   ) {
//     isStarted.value = true; // Mark animation as started

//     animationController.addListener(() {
//       progress.value = animationController.value; // Update the progress value
//     });

//     animationController.forward(); // Start the animation
//   }
// }

// class FaceDetectionTestPage extends StatefulWidget {
//   const FaceDetectionTestPage({super.key, required this.widget});
//   final Widget widget;
//   @override
//   _FaceDetectionTestPageState createState() => _FaceDetectionTestPageState();
// }

// class _FaceDetectionTestPageState extends State<FaceDetectionTestPage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   final ProgressController progressController = Get.put(ProgressController());

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 30),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(title: const Text("Face Detection Circle")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Obx(() {
//               // Reactively update the progress and isStarted
//               return FaceDetectionCircle(
//                 progress: progressController.progress.value,
//                 isStarted: progressController.isStarted.value,
//                 widget: widget,
//               );
//             }),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 progressController.startProgress(
//                   5,
//                   _controller,
//                 ); // Start progress on button click
//               },
//               child: const Text("Start Progress"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class FaceDetectionCircle extends StatelessWidget {
//   final double progress; // 0.0 to 1.0
//   final bool isStarted;
//   final Widget widget;
//   const FaceDetectionCircle({
//     super.key,
//     required this.progress,
//     required this.isStarted,
//     required this.widget,
//   });

//   @override
//   Widget build(BuildContext context) {
//     double width = 250; // Increase width of the circle
//     double height = 300; // Increased height of the circle

//     return SizedBox(
//       width: width,
//       height: height,
//       child:
//           isStarted
//               ? Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   // Dotted border circle
//                   DottedBorder(
//                     borderType: BorderType.values.last,
//                     dashPattern: [6, 4],
//                     color: Colors.blueAccent,
//                     strokeWidth: 3,
//                     padding: EdgeInsets.zero,
//                     child: SizedBox(
//                       width: width,
//                       height: height,
//                       child: widget,
//                     ),
//                   ),
//                   // Circular progress indicator
//                   SizedBox(
//                     width: width + 10, // Slightly larger than the dotted circle
//                     height: height + 10,
//                     child: CircularProgressIndicator(
//                       value:
//                           progress, // Progress based on the animation controller
//                       strokeWidth: 6,
//                       backgroundColor: Colors.transparent,
//                       color: Colors.blueAccent,
//                     ),
//                   ),
//                   // Face icon in the center
//                 ],
//               )
//               : DottedBorder(
//                 borderType: BorderType.values.last,
//                 dashPattern: [6, 4],
//                 color: Colors.blueAccent,
//                 strokeWidth: 3,
//                 padding: EdgeInsets.zero,
//                 child: SizedBox(width: width, height: height),
//               ),
//     );
//   }
// }

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shimmer Animation Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ShimmerLoadingScreen(),
    );
  }
}

class ShimmerLoadingScreen extends StatelessWidget {
  const ShimmerLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shimmer Animation')),
      body: HomeScreen(),
      //  ListView.builder(
      //   itemCount: 6,
      //   itemBuilder: (context, index) {
      //     return const ShimmerListItem();
      //   },
      // ),
    );
  }
}

class ShimmerListItem extends StatelessWidget {
  const ShimmerListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer(
            duration: const Duration(seconds: 2),
            interval: const Duration(seconds: 0),
            color: Colors.white,
            colorOpacity: 0.3,
            enabled: true,
            direction: const ShimmerDirection.fromLTRB(),
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer(
                  duration: const Duration(seconds: 2),
                  child: Container(
                    height: 16,
                    color: Colors.grey[300],
                    margin: const EdgeInsets.only(bottom: 8),
                  ),
                ),
                Shimmer(
                  duration: const Duration(seconds: 2),
                  child: Container(
                    height: 14,
                    width: 150,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String thumbText = "0";
  double _progress = 0.0;
  Timer? _timer;

  void _startProgress() {
    _timer?.cancel();
    _progress = 0.0;
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _progress += 0.01;
        if (_progress >= 1.0) {
          _progress = 1.0;
          _timer?.cancel();
        }
        thumbText = (_progress * 100).toStringAsFixed(0);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Circular SeekBar')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomCircularSeekBar(
            thumbText: thumbText,
            progress: _progress,
            onChanged: (value) {
              setState(() {
                thumbText = (value * 100).toStringAsFixed(0);
              });
            },
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: _startProgress,
            child: const Text("Start Timer"),
          ),
        ],
      ),
    );
  }
}

class CustomCircularSeekBar extends StatefulWidget {
  final double size;
  final double width;
  final double height;
  final double strokeWidth;
  final Color trackColor;
  final Color progressColor;
  final Color thumbColor;
  final String thumbText;
  final double progress;
  final Function(double) onChanged;

  const CustomCircularSeekBar({
    super.key,
    this.size = 200,
    this.height = 200,
    this.width = 200,
    this.strokeWidth = 10,
    this.trackColor = Colors.grey,
    this.progressColor = Colors.blue,
    this.thumbColor = Colors.red,
    this.thumbText = "",
    this.progress = 0.0,
    required this.onChanged,
  });

  @override
  State<CustomCircularSeekBar> createState() => _CircularSeekBarState();
}

class _CircularSeekBarState extends State<CustomCircularSeekBar> {
  double get _angle => widget.progress * 2 * pi;

  Offset _polarToCartesian(double angle) {
    final radius = widget.size / 2;
    final x = radius + radius * cos(angle - pi / 2);
    final y = radius + radius * sin(angle - pi / 2);
    return Offset(x, y);
  }

  double _globalToAngle(Offset globalPosition) {
    final local = (context.findRenderObject() as RenderBox).globalToLocal(
      globalPosition,
    );
    final center = Offset(widget.size / 2, widget.size / 2);
    final dx = local.dx - center.dx;
    final dy = local.dy - center.dy;
    final angle = atan2(dy, dx) + pi / 2;
    return (angle < 0) ? (2 * pi + angle) : angle;
  }

  @override
  Widget build(BuildContext context) {
    final thumbOffset = _polarToCartesian(_angle);

    return GestureDetector(
      onPanUpdate: (details) {
        final angle = _globalToAngle(details.globalPosition);
        final progress = angle / (2 * pi);
        widget.onChanged(progress);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: widget.width,
            height: widget.height,
            child: CustomPaint(
              painter: _CircularSeekBarPainter(
                angle: _angle,
                strokeWidth: widget.strokeWidth,
                trackColor: widget.trackColor,
                progressColor: widget.progressColor,
              ),
            ),
          ),
          Positioned(
            left: thumbOffset.dx - widget.strokeWidth,
            top: thumbOffset.dy - widget.strokeWidth,
            child: Container(
              alignment: Alignment.center,
              width: widget.strokeWidth * 2,
              height: widget.strokeWidth * 2,
              decoration: BoxDecoration(
                color: widget.thumbColor,
                shape: BoxShape.circle,
              ),
              child: Text(
                widget.thumbText,
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircularSeekBarPainter extends CustomPainter {
  final double angle;
  final double strokeWidth;
  final Color trackColor;
  final Color progressColor;

  _CircularSeekBarPainter({
    required this.angle,
    required this.strokeWidth,
    required this.trackColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final trackPaint =
        Paint()
          ..color = trackColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth;

    final progressPaint =
        Paint()
          ..color = progressColor
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, trackPaint);

    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rect, -pi / 2, angle, false, progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
