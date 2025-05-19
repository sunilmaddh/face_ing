import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/geust/controller/geust_controller.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class GuestHistoryDetails extends StatelessWidget {
  GuestHistoryDetails({super.key});
  final _controller = Get.find<GeustController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onTop: () {
          AppNavigation.back();
        },
        title: "Health details",
      ),

      body: Obx(
        () => ListView.separated(
          padding: EdgeInsets.all(20),
          itemCount: _controller.binahHIstoryDetails.length,
          itemBuilder: (context, index) {
            var result = _controller.binahHIstoryDetails[index];
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
                  CommonText.text(result["value"] ?? ""),
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
