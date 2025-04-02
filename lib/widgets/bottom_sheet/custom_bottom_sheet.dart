import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomSheet {
  static void show({
    required String title,
    required Widget content,
    bool isDismissible = true,
  }) {
    Get.bottomSheet(
      Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Custom Content
            Flexible(child: content),

            SizedBox(height: 10), // Add spacing at the bottom
          ],
        ),
      ),
      isDismissible: isDismissible,
      backgroundColor: Colors.transparent,
    );
  }
}
