import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LandingController extends GetxController {
  RxInt selectedIndex = 0.obs;
  late PageController pageController;
  void onTabTapped(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }
}
