import 'package:flutter/material.dart';
import 'package:ntt_data/modules/views/home/home_screen.dart';
import 'package:ntt_data/widgets/bar/custom_bottom_navigation_bar.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomNavigationBar(
      pageList: const [
        HomeScreen(),
        ColoredBox(color: Colors.green),
        ColoredBox(color: Colors.blue),
        ColoredBox(color: Colors.red),
      ],
    );
  }
}
