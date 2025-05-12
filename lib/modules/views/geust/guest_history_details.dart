import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/modules/views/geust/controller/geust_controller.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class GuestHistoryDetails extends StatelessWidget {
  GuestHistoryDetails({super.key});
  final _controller = Get.find<GeustController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Add Guest"),

      body: Obx(
        () => ListView.builder(
          itemCount: _controller.binahHIstoryDetails.length,
          itemBuilder: (context, index) {
            var result = _controller.binahHIstoryDetails[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText.text(result["key"]),
                  CommonText.text(result["value"]),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
