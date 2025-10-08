import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _selectedIndex);
  }

  void onTabTapped(int index) {
    setState(() => _selectedIndex = index);
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: pageController,
        onPageChanged: (index) => setState(() => _selectedIndex = index),
        children: const [
          ColoredBox(color: Colors.red),
          ColoredBox(color: Colors.green),
          ColoredBox(color: Colors.blue),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: AppColors.primary,
        onPressed: () => onTabTapped(1),
        child: SvgPicture.asset(AppAssets.scan),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.only(top: 18.0),
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        color: Colors.white,
        elevation: 8,
        child: SizedBox(
          height: 60,
          child: Stack(
            children: [
              Flexible(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: CommonText.text(
                    "Face Scan",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Manrope",
                    color: AppColors.bottomTextColor,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    flex: 2,
                    child: InkWell(
                      onTap: () {
                        onTabTapped(0);
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            AppAssets.home,
                            color:
                                _selectedIndex == 0
                                    ? AppColors.primary
                                    : AppColors.bottomTextColor,
                          ),

                          CommonText.text(
                            "Home",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Manrope",
                            color:
                                _selectedIndex == 0
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
                        onTabTapped(1);
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            AppAssets.aiAdivice,
                            color:
                                _selectedIndex == 1
                                    ? AppColors.primary
                                    : AppColors.bottomTextColor,
                          ),
                          CommonText.text(
                            "AI Advice",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Manrope",
                            color:
                                _selectedIndex == 1
                                    ? AppColors.primary
                                    : AppColors.bottomTextColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 40), // Space for FAB

                  Flexible(
                    flex: 2,
                    child: InkWell(
                      onTap: () {
                        onTabTapped(2);
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            AppAssets.voice,
                            color:
                                _selectedIndex == 2
                                    ? AppColors.primary
                                    : AppColors.bottomTextColor,
                          ),
                          CommonText.text(
                            "Voice",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Manrope",
                            color:
                                _selectedIndex == 2
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
                        onTabTapped(3);
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            AppAssets.pulse,
                            color:
                                _selectedIndex == 3
                                    ? AppColors.primary
                                    : AppColors.bottomTextColor,
                          ),
                          CommonText.text(
                            "Pulse survey",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Manrope",
                            color:
                                _selectedIndex == 3
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
    );
  }
}
