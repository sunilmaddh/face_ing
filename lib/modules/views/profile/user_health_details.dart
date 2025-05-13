import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/profile/controller/profile_controller.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class UserHealthDetails extends StatelessWidget {
  UserHealthDetails({super.key});
  final _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ""),
      body: Obx(
        () => ListView.separated(
          padding: EdgeInsets.all(20),
          itemCount: _profileController.binahHIstoryDetails.length,
          itemBuilder: (context, index) {
            var result = _profileController.binahHIstoryDetails[index];
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText.text(
                    result["key"],
                    fontSize: AppDimensions.font(14),
                    fontWeight: FontWeight.w500,
                  ),
                  CommonText.text(
                    result["value"]!,
                    // result["value"]
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(color: Color(0xffFAF7F7));
          },
        ),

        // ListView.builder(

        //   },
        // ),
      ),
    );
  }
}
