import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/home/face_drawer.dart';
import 'package:ntt_data/modules/views/home/halper/home_halper.dart';
import 'package:ntt_data/modules/views/landing/landing_controller.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key, required this.pageList});

  final List<Widget> pageList;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final _controller = Get.find<LandingController>();

  @override
  void initState() {
    super.initState();
    _controller.pageController = PageController(
      initialPage: _controller.selectedIndex.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _controller.scaffoldKey,
      extendBody: true,
      drawer: FaceDrawer(),
      body: PageView(
        controller: _controller.pageController,
        onPageChanged: (index) {
          _controller.selectedIndex.value = index;
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
                  child: CommonText.text(
                    "Face Scan",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Manrope",
                    color: AppColors.bottomTextColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      flex: 2,
                      child: InkWell(
                        onTap: () {
                          _controller.onTabTapped(0);
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              AppAssets.home,
                              color:
                                  _controller.selectedIndex.value == 0
                                      ? AppColors.primary
                                      : AppColors.bottomTextColor,
                            ),

                            CommonText.text(
                              "Home",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Manrope",
                              color:
                                  _controller.selectedIndex.value == 0
                                      ? AppColors.primary
                                      : AppColors.bottomTextColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: InkWell(
                        onTap: () {
                          _controller.onTabTapped(1);
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              AppAssets.aiAdivice,
                              color:
                                  _controller.selectedIndex.value == 1
                                      ? AppColors.primary
                                      : AppColors.bottomTextColor,
                            ),
                            CommonText.text(
                              "AI Advice",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Manrope",
                              color:
                                  _controller.selectedIndex.value == 1
                                      ? AppColors.primary
                                      : AppColors.bottomTextColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 40), // Space for FAB

                    Padding(
                      padding: AppDimensions.only(left: 30),
                      child: Flexible(
                        flex: 2,
                        child: InkWell(
                          onTap: () {
                            _controller.onTabTapped(2);
                          },
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                AppAssets.voice,
                                color:
                                    _controller.selectedIndex.value == 2
                                        ? AppColors.primary
                                        : AppColors.bottomTextColor,
                              ),
                              CommonText.text(
                                "Voice",
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Manrope",
                                color:
                                    _controller.selectedIndex.value == 2
                                        ? AppColors.primary
                                        : AppColors.bottomTextColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: InkWell(
                        onTap: () {
                          _controller.onTabTapped(3);
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              AppAssets.pulse,
                              color:
                                  _controller.selectedIndex.value == 3
                                      ? AppColors.primary
                                      : AppColors.bottomTextColor,
                            ),
                            CommonText.text(
                              "Pulse survey",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Manrope",
                              color:
                                  _controller.selectedIndex.value == 3
                                      ? AppColors.primary
                                      : AppColors.bottomTextColor,
                            ),
                          ],
                        ),
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
