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
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
             SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            
            // Custom Content
            Expanded(child: content),

            // Close Button
          
          ],
        ),
      ),
      isDismissible: isDismissible,
      backgroundColor: Colors.transparent,
    );
  }
}
