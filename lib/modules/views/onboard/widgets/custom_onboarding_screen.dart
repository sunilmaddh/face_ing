import 'package:flutter/material.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/storage/storage_helper.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/onboard/onboarding_page_view.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/button/primary_button.dart';
import 'package:ntt_data/widgets/face_progress_indicator.dart';

// ignore: must_be_immutable
class CustomOnboardingScreen extends StatelessWidget {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
  List<dynamic> pages;

  CustomOnboardingScreen({super.key, required this.pages});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: pages.length,
              onPageChanged: (index) {
                _currentIndex.value = index;
              },
              itemBuilder: (context, index) {
                return OnboardingPageView(
                  image: pages[index]["image"],
                  title: pages[index]["title"],
                  description: pages[index]["description"],
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppDimensions.padding(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FaceProgressIndicator(
                  pages: pages,
                  valueCurrentIndex: _currentIndex,
                ),
                SizedBox(height: 20),
                ValueListenableBuilder<int>(
                  valueListenable: _currentIndex,
                  builder: (context, currentIndex, child) {
                    return PrimaryButton(
                      onPressed: () {
                        if (currentIndex == pages.length - 1) {
                          IndoSharedPreference.instance.saveWalkScreen(true);
                          AppNavigation.to(AppRoutes.loginScreen);
                        } else {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        }
                      },

                      text:
                          currentIndex == pages.length - 1
                              ? 'Get started'
                              : 'Next',
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
