import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/common_assets.dart';
import 'package:ntt_data/modules/views/home/widgets/custom_circular_avatar.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class FaceDrawer extends StatelessWidget {
  FaceDrawer({super.key});

  void editProfilePicture() {
    // TODO: Implement profile picture editing functionality
  }

  Widget _buildListTile({
    required String icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          leading: SvgPicture.asset(
            icon,
            width: AppDimensions.width(20),
            height: AppDimensions.height(20),
          ),
          title: CommonText.text(
            title,
            fontSize: AppDimensions.font(16),
            fontWeight: FontWeight.w600,
          ),
          subtitle: subtitle != null ? CommonText.text(subtitle) : null,
          trailing: trailing,
          onTap: onTap,
        ),
        Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimensions.width(342),
      child: Drawer(
        backgroundColor: AppColors.btntext,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.drawerHeaderColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(bottom: AppDimensions.height(60)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              AppNavigation.back();
                            },
                            child: SvgPicture.asset(AppAssets.backButton),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: AppDimensions.width(90),
                        child: Stack(
                          children: [
                            CustomCircularAvatar(),
                            Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: editProfilePicture,
                                child: SvgPicture.asset(AppAssets.editIcon),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppDimensions.height(20)),
                      CommonText.text(
                        "Sunil Maddheshiya",
                        fontSize: AppDimensions.font(16),
                        fontWeight: FontWeight.w400,
                        fontFamily: AppConstents.gilroyBold,
                      ),
                      SizedBox(height: AppDimensions.height(10)),
                      CommonText.text(
                        "sunil.maddheshiya@example.com",
                        fontSize: AppDimensions.font(14),
                        fontWeight: FontWeight.w400,
                        fontFamily: AppConstents.gilroyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: AppDimensions.height(40)),

            /// **Reusable List Tiles**
            _buildListTile(
              icon: AppAssets.userIcon,
              title: "Guest User",
              subtitle: "Guest user data",
              onTap: () => Get.toNamed(AppRoutes.geustUserHistory),
            ),
            _buildListTile(
              icon: AppAssets.history,
              title: "History",
              subtitle: "User history data",
              onTap: () => AppNavigation.to(AppRoutes.userHistoryList),
            ),
            _buildListTile(
              icon: AppAssets.notification,
              title: "Push Notification",
              subtitle: "Manage notifications and more",
              trailing: Switch(
                value: true,
                onChanged: (value) {
                  // Handle switch toggle logic
                },
              ),
              onTap: () {},
            ),
            _buildListTile(
              icon: AppAssets.logout,
              title: "Logout",
              onTap: () => AppMethods().logout(),
            ),

            Spacer(),

            /// **Powered By Section**
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonText.text(
                  "Powered BY",
                  color: AppColors.powerBy,
                  fontSize: AppDimensions.font(20),
                  fontWeight: FontWeight.w700,
                  fontFamily: "Open Sans",
                ),
                CommonAssets.svgAsset(AppAssets.faceLogo),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
