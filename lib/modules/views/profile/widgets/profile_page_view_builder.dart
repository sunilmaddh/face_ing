import 'package:flutter/material.dart';
import 'package:ntt_data/modules/views/profile/widgets/profile_page_data.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/button/rounded_button.dart';
import 'package:ntt_data/widgets/face_progress_indicator.dart';

// ignore: must_be_immutable
class ProfilePageViewBuilder extends StatelessWidget {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
  List<dynamic> pages;

  ProfilePageViewBuilder({super.key, required this.pages});
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
                  text: pages[index]["text"],
                  list: pages[index]["options"],
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
                    AppNavigation.to(AppRoutes.congratulationsScreen);
                  },

                  // currentIndex == pages.length - 1
                  //     ? () {

                  //         Navigator.pushReplacementNamed(context, '/home');
                  //       }
                  //     : () {
                  //         _pageController.nextPage(
                  //             duration: Duration(milliseconds: 500), curve: Curves.ease);
                  //       },
                  // text: currentIndex == pages.length - 1 ? 'Get Started' : 'Next'
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
