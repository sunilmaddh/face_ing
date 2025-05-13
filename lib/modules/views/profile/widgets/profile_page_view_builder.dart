import 'package:flutter/material.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/modules/views/auth/auth_controller.dart';
import 'package:ntt_data/modules/views/profile/controller/profile_controller.dart';
import 'package:ntt_data/modules/views/profile/widgets/profile_page_data.dart';
import 'package:ntt_data/widgets/button/rounded_button.dart';
import 'package:ntt_data/widgets/face_progress_indicator.dart';

// ignore: must_be_immutable
class ProfilePageViewBuilder extends StatelessWidget {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
  List<dynamic> pages;
  final AuthController authController;

  ProfilePageViewBuilder({
    super.key,
    required this.pages,
    required this.authController,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FaceProgressIndicator(pages: pages, valueCurrentIndex: _currentIndex),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: pages.length,
              onPageChanged: (index) {
                _currentIndex.value = index;
              },
              itemBuilder: (context, index) {
                return ProfilePageData(
                  id: pages[index].id!,
                  question: pages[index].onBoardingQuestionName!,
                  text: pages[index].onBoardingQuestionName!,
                  list: pages[index].onBoardingOptions!,
                  authController: authController,
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomRight,
            child: ValueListenableBuilder<int>(
              valueListenable: _currentIndex,
              builder: (context, currentIndex, child) {
                return RoundedButton(
                  isAppBar: false,
                  onPressed: () {
                    if (currentIndex == pages.length - 1) {
                      // var data = AppMethods.getstoreQuestionAnswer();
                      debugPrint(authController.dataList.toString());
                      authController.profileCreation();
                      // AppNavigation.to(AppRoutes.congratulationsScreen);
                    } else {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
