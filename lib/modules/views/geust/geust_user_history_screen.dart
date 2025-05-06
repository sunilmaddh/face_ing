import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/profile/vitals_data_screen.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/button/rounded_button.dart';
import 'package:ntt_data/widgets/fields/custom_form_field.dart';

// ignore: must_be_immutable
class GeustUserHistoryScreen extends StatelessWidget {
  GeustUserHistoryScreen({super.key});
  final _searchController = TextEditingController();
  List<Widget> tabWidgets = [
    Tab(text: "Vitals"),
    Tab(text: "Wellness"),
    Tab(text: "Additional"),
  ];

  List<Widget> tabBarWidgets = [VitalsDataScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: RoundedButton(
        onPressed: () {
          AppNavigation.to(AppRoutes.addNewGeustScreen);
        },
        isAdd: true,
        isAppBar: false,
        size: AppDimensions.height(58),
      ),
      appBar: CustomAppBar(title: "Geust user"),
      body: Padding(
        padding: EdgeInsets.all(AppDimensions.padding(15)),
        child: Column(
          children: [
            CustomFormField(
              prefixIcon: Icon(Icons.search, color: AppColors.searchColor),
              label: "",
              hint: "Type to search",
              controller: _searchController,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
