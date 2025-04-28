import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:dotted_border/dotted_border.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Face Detection Circle',
      home: FaceDetectionTestPage(),
    );
  }
}

class ProgressController extends GetxController {
  var progress = 0.0.obs; // Reactive progress
  var isStarted = false.obs; // Reactive flag for animation start

  // Method to start progress animation
  void startProgress(
    int durationInSeconds,
    AnimationController animationController,
  ) {
    isStarted.value = true; // Mark animation as started

    animationController.addListener(() {
      progress.value = animationController.value; // Update the progress value
    });

    animationController.forward(); // Start the animation
  }
}

class FaceDetectionTestPage extends StatefulWidget {
  const FaceDetectionTestPage({super.key});

  @override
  _FaceDetectionTestPageState createState() => _FaceDetectionTestPageState();
}

class _FaceDetectionTestPageState extends State<FaceDetectionTestPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final ProgressController progressController = Get.put(ProgressController());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Face Detection Circle")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              // Reactively update the progress and isStarted
              return FaceDetectionCircle(
                progress: progressController.progress.value,
                isStarted: progressController.isStarted.value,
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                progressController.startProgress(
                  5,
                  _controller,
                ); // Start progress on button click
              },
              child: const Text("Start Progress"),
            ),
          ],
        ),
      ),
    );
  }
}

class FaceDetectionCircle extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final bool isStarted;
  const FaceDetectionCircle({
    super.key,
    required this.progress,
    required this.isStarted,
  });

  @override
  Widget build(BuildContext context) {
    double width = 250; // Increase width of the circle
    double height = 300; // Increased height of the circle

    return SizedBox(
      width: width,
      height: height,
      child:
          isStarted
              ? Stack(
                alignment: Alignment.center,
                children: [
                  // Dotted border circle
                  DottedBorder(
                    borderType: BorderType.values.last,
                    dashPattern: [6, 4],
                    color: Colors.blueAccent,
                    strokeWidth: 3,
                    padding: EdgeInsets.zero,
                    child: Container(width: width, height: height),
                  ),
                  // Circular progress indicator
                  SizedBox(
                    width: width + 10, // Slightly larger than the dotted circle
                    height: height + 10,
                    child: CircularProgressIndicator(
                      value:
                          progress, // Progress based on the animation controller
                      strokeWidth: 6,
                      backgroundColor: Colors.transparent,
                      color: Colors.blueAccent,
                    ),
                  ),
                  // Face icon in the center
                ],
              )
              : DottedBorder(
                borderType: BorderType.values.last,
                dashPattern: [6, 4],
                color: Colors.blueAccent,
                strokeWidth: 3,
                padding: EdgeInsets.zero,
                child: Container(width: width, height: height),
              ),
    );
  }
}
