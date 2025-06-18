import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/core/utils/extentions.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';
import 'package:ntt_data/widgets/test_main_expand_widget.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DemoApi(),
    );
  }
}

class DemoApi extends StatelessWidget {
  const DemoApi({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    final double ovalWidth = screenSize.width * 0.8;
    final double ovalHeight = screenSize.height * 0.5;

    return Scaffold(
      body: SafeArea(
        child: IndoCommonCard(
          vitalName: "Heart rate",
          vitalCondition: "Avg 6-10",
          vitalDescription:
              "cdfdijodihofduhfgioffoisdhudsfhdsufsdshdshfdsihofdshdfs",
          vitalHeading: "Your Heart rate is low",
        ),
      ),
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

class IndoCommonCard extends StatefulWidget {
  final String vitalName;
  final String vitalStatus;
  final String vitalValue;
  final String vitalHeading;
  final String vitalDescription;
  final String vitalCondition;
  final String vitalMass;
  final String imageAsset;
  final bool isExpand;
  final bool isVitalActive;
  final Widget expandedWidget;

  const IndoCommonCard({
    Key? key,
    this.vitalName = "",
    this.vitalStatus = "",
    this.imageAsset = "",
    this.vitalValue = "",
    this.vitalHeading = "",
    this.vitalDescription = "",
    this.vitalCondition = "",
    this.vitalMass = "",
    this.isExpand = false,
    this.isVitalActive = true,
    this.expandedWidget = const SizedBox(), // fixed default widget
  }) : super(key: key);
  @override
  State<IndoCommonCard> createState() => _CommonCardState();
}

class _CommonCardState extends State<IndoCommonCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    // String imageAsset;

    switch (widget.imageAsset) {
      case AppAssets.mediumAsset:
        statusColor = const Color(0xFFFFD700); // Yellow color
        break;
      case AppAssets.lighthigh:
        statusColor = const Color(0xFF9ED042); // Yellow color
        break;
      case AppAssets.goodAsset:
        statusColor = const Color(0xFF1BC76D); // Green color
        break;
      case AppAssets.lowAsset:
      default:
        statusColor = const Color(0xFFE53935); // Red color
    }

    return CommonCard(
      widget: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                // Left section
                Container(
                  width: 150,
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.imageAsset.isNotEmpty
                          ? SvgPicture.asset(
                            widget.imageAsset,
                            width: 37,
                            height: 37,
                          )
                          : SizedBox(),
                      const SizedBox(height: 10),
                      Text(
                        widget.vitalName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff575656),
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        widget.vitalCondition,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff575656),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: widget.vitalValue.toFirstCaps(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff4A4949),
                              ),
                            ),
                            TextSpan(
                              text:
                                  ' ${widget.vitalMass}', // Add space before vitalMass
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Divider
                Container(
                  width: 1,
                  height: 150, // Adjust height as needed
                  color: const Color(0xffD9D9D9),
                ),

                // Right section
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.vitalHeading,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff5E5D5D),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.vitalDescription,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff5E5D5D),
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 20),
                        widget.imageAsset.isNotEmpty
                            ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                widget.isVitalActive
                                    ? Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 10.5,
                                          backgroundColor: statusColor,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          widget.vitalStatus.toFirstCaps(),
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: statusColor,
                                          ),
                                        ),
                                      ],
                                    )
                                    : SizedBox(),
                                Icon(Icons.info_rounded),
                                // SvgPicture.asset(imageAsset, width: 20, height: 20),
                              ],
                            )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Expand/Collapse button ONLY if isExpand prop is true
            widget.isExpand
                ? Padding(
                  padding: const EdgeInsets.only(right: 8, bottom: 15),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child:
                          (widget.vitalName.toLowerCase() == "stress" ||
                                      widget.vitalName.toLowerCase() ==
                                          "blood pressure") &&
                                  isExpanded
                              ? const Icon(Icons.minimize_outlined)
                              : const Icon(Icons.add_outlined),
                    ),
                  ),
                )
                : const SizedBox(),

            // Show detailed card only when expanded AND vitalName is stress or blood pressure
            if (isExpanded &&
                (widget.vitalName.toLowerCase() == "stress level" ||
                    widget.vitalName == "HRV SDNN" ||
                    widget.vitalName == 'Blood Pressure'))
              widget.expandedWidget,
            // StressInfoCard(
            //   vitalName: widget.vitalName.toLowerCase(),
            //   isExpanded: isExpanded,
            //   titleText:
            //       widget.vitalName.toLowerCase() == "blood pressure"
            //           ? "Blood Pressure Systolic"
            //           : "Normalized Stress Index",
            //   statusText:
            //       widget.vitalName.toLowerCase() == "blood pressure"
            //           ? "Your Blood Pressure Systolic Index is Mild"
            //           : "Your Stress Index is Mild",
            //   valueText:
            //       widget.vitalName.toLowerCase() == "blood pressure"
            //           ? widget.vitalValue.length > 3
            //               ? widget.vitalValue.substring(0, 3)
            //               : widget.vitalValue
            //           : "5",

            //   unitText:
            //       widget.vitalName.toLowerCase() == "blood pressure"
            //           ? 'mmh'
            //           : "%",
            // ),
          ],
        ),
      ),
    );
  }
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
