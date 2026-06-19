import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/landing/controller/landing_controller.dart';
import 'package:ntt_data/modules/landing/view/face_drawer.dart';
import 'package:ntt_data/modules/home/helper/home_helper.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key, required this.pageList});

  final List<Widget> pageList;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late final LandingController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<LandingController>();
    controller.pageController = PageController(
      initialPage: controller.selectedIndex.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      extendBody: true,
      drawer: FaceDrawer(),
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (index) {
          controller.selectedIndex.value = index;
        },
        children: widget.pageList,
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: AppColors.primary,
        onPressed: () {
          HomeHalper().callMeasurement();
        },
        child: SvgPicture.asset(AppAssets.scan),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(
        () => BottomAppBar(
          padding: EdgeInsets.only(top: 18.0),
          shape: CircularNotchedRectangle(),
          notchMargin: 6,
          color: Colors.white,
          elevation: 8,
          child: SizedBox(
            height: 60,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CommonText.labelMedium(
                    "Face Scan",
                    color: AppColors.bottomTextColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.onTabTapped(0);
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            AppAssets.home,
                            // ignore: deprecated_member_use
                            color:
                                controller.selectedIndex.value == 0
                                    ? AppColors.primary
                                    : AppColors.bottomTextColor,
                          ),

                          CommonText.labelMedium(
                            "Home",
                            color:
                                controller.selectedIndex.value == 0
                                    ? AppColors.primary
                                    : AppColors.bottomTextColor,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.onTabTapped(1);
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            AppAssets.aiAdivice,
                            // ignore: deprecated_member_use
                            color:
                                controller.selectedIndex.value == 1
                                    ? AppColors.primary
                                    : AppColors.bottomTextColor,
                          ),
                          CommonText.labelMedium(
                            "AI Advice",
                            color:
                                controller.selectedIndex.value == 1
                                    ? AppColors.primary
                                    : AppColors.bottomTextColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 40), // Space for FAB

                    Padding(
                      padding: AppDimensions.only(left: 30),
                      child: InkWell(
                        onTap: () {
                          controller.onTabTapped(2);
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              AppAssets.voice,
                              // ignore: deprecated_member_use
                              color:
                                  controller.selectedIndex.value == 2
                                      ? AppColors.primary
                                      : AppColors.bottomTextColor,
                            ),
                            CommonText.labelMedium(
                              "Voice",
                              color:
                                  controller.selectedIndex.value == 2
                                      ? AppColors.primary
                                      : AppColors.bottomTextColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.onTabTapped(3);
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            AppAssets.pulse,
                            // ignore: deprecated_member_use
                            color:
                                controller.selectedIndex.value == 3
                                    ? AppColors.primary
                                    : AppColors.bottomTextColor,
                          ),
                          CommonText.labelMedium(
                            "Pulse survey",

                            color:
                                controller.selectedIndex.value == 3
                                    ? AppColors.primary
                                    : AppColors.bottomTextColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
