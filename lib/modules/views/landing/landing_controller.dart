import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LandingController extends GetxController {
  static LandingController get instance => Get.find<LandingController>();
  RxInt selectedIndex = 0.obs;
  late PageController pageController;
  void onTabTapped(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final currentIndex = 0.obs;

  void openDrawer() => scaffoldKey.currentState?.openDrawer();
}
