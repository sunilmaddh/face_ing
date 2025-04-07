import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/common_assets.dart';
import 'package:ntt_data/data/repository/services/native_caller_services.dart';
import 'package:ntt_data/modules/views/home/face_drawer.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/button/scan_button.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: FaceDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          _scaffoldKey.currentState!.openDrawer();
                        },
                        child: CommonAssets.svgAsset(
                          AppAssets.homeMenu,
                          width: 60,
                          height: 60,
                        ),
                      ), // Keeps at the start
                    ),
                  ),
                  Expanded(
                    flex: 2, // More space for centering
                    child: Align(
                      alignment: Alignment.center,
                      child: CommonAssets.svgAsset(
                        AppAssets.faceLogo,
                      ), // Keeps in the center
                    ),
                  ),
                  Expanded(child: SizedBox()), // Balancing the layout
                ],
              ),

              SizedBox(height: AppDimensions.height(60)),
              CommonAssets.svgAsset(AppAssets.scanIllustration),
              SizedBox(height: AppDimensions.height(30)),
              CommonText.text(
                AppConstents.scanDiscri,
                fontSize: AppDimensions.font(18),
                fontWeight: FontWeight.w500,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 110),
              ScanButton(
                width: 193,
                onPressed: () {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    NativeCaller.startFaceScan();
                  });
                  // .then((v) {
                  //   AppNavigation.to(AppRoutes.analyzingHealthData);
                  // });

                  // AppNavigation.to(AppRoutes.analyzingHealthData);
                  //  AppNavigation.to(AppRoutes.scanScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
