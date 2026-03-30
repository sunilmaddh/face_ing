import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_fonts.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/common_assets.dart';
import 'package:ntt_data/core/utils/dialog/common_dialog.dart';
import 'package:ntt_data/core/utils/dialog/dialog_halper.dart';
import 'package:ntt_data/data/services/profile_upload_services.dart';
import 'package:ntt_data/modules/home/widget/custom_circular_avatar.dart';
import 'package:ntt_data/modules/profile/controller/profile_controller.dart';
import 'package:ntt_data/modules/profile/helper/profile_helper.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/bottom_sheet/image_picker_bottomsheet.dart';
import 'package:ntt_data/widgets/circular_image_with_shimmer.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';
import 'package:shimmer/shimmer.dart';

class FaceDrawer extends StatelessWidget {
  FaceDrawer({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();

  /// Reusable ListTile builder
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
          title: CommonText.titleMedium(title, fontWeight: FontWeight.w600),
          subtitle: subtitle != null ? CommonText.text(subtitle) : null,
          trailing: trailing,
          onTap: onTap,
        ),
        const Divider(),
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
            /// ---- HEADER ----
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
                            onTap: AppNavigation.back,
                            child: SvgPicture.asset(AppAssets.backButton),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: AppDimensions.width(90),
                        child: Obx(() {
                          if (_profileController.imageProfileLoading.isTrue) {
                            return ClipOval(
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  width: 95,
                                  height: 95,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          } else {
                            return Stack(
                              children: [
                                _profileController.userImage.isNotEmpty
                                    ? CircularImageWithShimmer(
                                      size: 95,
                                      imageUrl:
                                          _profileController.userImage.value,
                                    )
                                    : CustomCircularAvatar(
                                      color: AppColors.guestIconColor,
                                      widget: CommonText.text(
                                        _profileController.userName.isNotEmpty
                                            ? _profileController.userName
                                                .substring(0, 1)
                                                .toUpperCase()
                                            : "",

                                        style: TextStyle(
                                          fontSize: AppDimensions.font(30),
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.btntext,
                                        ),
                                      ),
                                    ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    onTap: () {
                                      CommonDialog().editGuestDialog(
                                        guestOptionList:
                                            AppMethods().guestOptionList,
                                        context: context,
                                        onConfirm: (value) {
                                          if (value == "Photo") {
                                            ImagePickerBottomsheet.showImagePickerBottomSheet(
                                              onGalleryTap: () async {
                                                final file =
                                                    await ProfileUploadService()
                                                        .uploadProfileImage(
                                                          source:
                                                              ImagePickSource
                                                                  .gallery,
                                                        );
                                                if (file.path.isNotEmpty) {
                                                  await _profileController
                                                      .uploadProfile(
                                                        imagePath: file.path,
                                                      );
                                                }
                                              },
                                              onCameraTap: () async {
                                                final file =
                                                    await ProfileUploadService()
                                                        .uploadProfileImage(
                                                          source:
                                                              ImagePickSource
                                                                  .camera,
                                                        );
                                                if (file.path.isNotEmpty) {
                                                  await _profileController
                                                      .uploadProfile(
                                                        imagePath: file.path,
                                                      );
                                                }
                                              },
                                            );
                                          } else {
                                            ProfileHelper().retainedUserData(
                                              _profileController,
                                            );
                                          }
                                        },
                                        onCancel: () {},
                                      );
                                    },
                                    child: SvgPicture.asset(AppAssets.editIcon),
                                  ),
                                ),
                              ],
                            );
                          }
                        }),
                      ),
                      SizedBox(height: AppDimensions.height(20)),
                      Obx(
                        () => CommonText.titleMedium(
                          _profileController.userUpdateName.isNotEmpty
                              ? _profileController.userUpdateName.value
                              : _profileController.userName.value,

                          fontWeight: FontWeight.w400,
                          fontType: AppFontType.secondary,
                          // fontFamily: AppConfig.gilroyBold,
                        ),
                      ),
                      SizedBox(height: AppDimensions.height(10)),
                      Obx(
                        () => CommonText.labelLarge(
                          _profileController.userEmail.value,
                          fontWeight: FontWeight.w400,
                          fontType: AppFontType.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: AppDimensions.height(40)),

            /// ---- MENU ITEMS ----
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
              icon: AppAssets.logout,
              title: "Logout",
              onTap:
                  () => DialogHelper.showLogoutDialog(
                    context,
                    _profileController.isLoadingLogout.value,
                    onTop: () async {
                      await _profileController.logoutUser();
                    },
                  ),
            ),

            const Spacer(),

            /// ---- VERSION ----
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonText.text(
                  "v1.0.17",
                  style: TextStyle(
                    fontSize: AppDimensions.font(14),
                    fontWeight: FontWeight.w700,
                    fontFamily: "Open Sans",
                    color: AppColors.powerBy,
                  ),
                ),
              ],
            ),

            /// ---- POWERED BY ----
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonText.text(
                    "Powered By ",
                    style: TextStyle(
                      color: AppColors.powerBy,
                      fontSize: AppDimensions.font(20),
                      fontWeight: FontWeight.w700,
                      fontFamily: "Open Sans",
                    ),
                  ),
                  CommonAssets.svgAsset(AppAssets.faceLogo),
                ],
              ),
            ),
            SizedBox(height: AppDimensions.height(10)),
          ],
        ),
      ),
    );
  }
}
