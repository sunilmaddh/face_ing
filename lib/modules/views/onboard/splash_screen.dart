import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/storage/storage_helper.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
    // requestCameraPermission();
  }

  // Future<void> requestCameraPermission() async {
  //   PermissionStatus status = await Permission.camera.status;

  //   if (status.isDenied || status.isRestricted) {
  //     status = await Permission.camera.request();
  //   }

  //   if (status.isGranted) {
  //     print("Camera permission granted");
  //     // Proceed with camera usage
  //   } else if (status.isPermanentlyDenied) {
  //     // Show dialog and navigate to settings
  //     openAppSettings();
  //   } else {
  //     print("Camera permission denied");
  //   }
  // }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));
    final userId = await StorageHelper.read("userId") ?? "";
    final isWalk = await StorageHelper.read("isWalkThrough") ?? "";
    final isOnboard = await StorageHelper.read("isOnboard") ?? "";

    if (isWalk != "isWalk") {
      AppNavigation.off(AppRoutes.onboardScreen);
    } else if (userId.isNotEmpty && isOnboard != "isOnboard") {
      AppNavigation.offAll(AppRoutes.createAccount);
    } else if (userId.isNotEmpty && isOnboard == "isOnboard") {
      AppNavigation.off(AppRoutes.homeScreen);
    } else {
      AppNavigation.off(AppRoutes.loginScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: SvgPicture.asset(AppAssets.logo)));
  }
}
