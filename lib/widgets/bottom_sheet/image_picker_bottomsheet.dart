import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/widgets/bottom_sheet/custom_bottom_sheet.dart';

class ImagePickerBottomsheet {
  static void showImagePickerBottomSheet({
    required VoidCallback onGalleryTap,
    required VoidCallback onCameraTap,
  }) {
    CustomBottomSheet.show(
      title: "Choose an option",
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Space evenly
          children: [
            // Gallery Card
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
                child: ListTile(
                  leading: Icon(Icons.image, color: Colors.blue),
                  title: Text("Gallery"),
                  onTap: () {
                    Get.back(); // Close bottom sheet
                    onGalleryTap(); // Call gallery function
                  },
                ),
              ),
            ),

            SizedBox(width: 10), // Horizontal spacing
            // Camera Card
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
                child: ListTile(
                  leading: Icon(Icons.camera_alt, color: Colors.green),
                  title: Text("Camera"),
                  onTap: () {
                    Get.back(); // Close bottom sheet
                    onCameraTap(); // Call camera function
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // showModalBottomSheet(
    //   context: context,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    //   ),
    //   backgroundColor: Colors.white,
    //   builder: (context) {
    //     return
    //   },
    // );
  }
}
