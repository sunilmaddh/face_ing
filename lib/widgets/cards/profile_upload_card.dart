import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/widgets/bottom_sheet/image_picker_bottomsheet.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class ProfileUploadCard extends StatelessWidget {
  final RxBool isProfile;
  final Rx<File> profileUrl;
  final VoidCallback onRemove;
  final Future<void> Function() onGalleryTap;
  final Future<void> Function() onCameraTap;

  const ProfileUploadCard({
    super.key,
    required this.isProfile,
    required this.profileUrl,
    required this.onRemove,
    required this.onGalleryTap,
    required this.onCameraTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.height(190),
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Obx(
            () =>
                isProfile.isTrue
                    ? Container(
                      height: AppDimensions.height(180),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppColors.dottedBorderColor,
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.file(
                              profileUrl.value,
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Card(
                              child: InkWell(
                                onTap: onRemove,
                                child: Icon(
                                  Icons.close_rounded,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    : DottedBorder(
                      options: RectDottedBorderOptions(
                        dashPattern: [6, 5],
                        strokeWidth: 3.0,
                        color: AppColors.dottedBorderColor,
                      ),
                      child: Container(
                        height: AppDimensions.height(161),
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9.0),
                          color: AppColors.uploadCardColor,
                        ),
                        child: InkWell(
                          onTap: () {
                            ImagePickerBottomsheet.showImagePickerBottomSheet(
                              onGalleryTap: onGalleryTap,
                              onCameraTap: onCameraTap,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppAssets.upload,
                                height: AppDimensions.height(26.3),
                                width: AppDimensions.width(24),
                              ),
                              const SizedBox(width: 5.0),
                              CommonText.text(
                                "Upload Profile Image",
                                fontSize: AppDimensions.font(16),
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff263238),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
          ),
        ],
      ),
    );
  }
}
