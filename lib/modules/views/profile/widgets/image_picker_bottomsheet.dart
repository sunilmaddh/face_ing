import 'package:flutter/material.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bottom_sheet/custom_bottom_sheet.dart';

class ImagePickerBottomsheet {
  static void showImagePickerBottomSheet({
    required VoidCallback onGalleryTap,
    required VoidCallback onCameraTap,
  }) {
    CustomBottomSheet.show(
      title: "Image type",
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Choose an option",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),

            // Gallery Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 3,
              child: ListTile(
                leading: Icon(Icons.image, color: Colors.blue),
                title: Text("Gallery"),
                onTap: () {
                  AppNavigation.back; // Close bottom sheet
                  onGalleryTap(); // Call gallery function
                },
              ),
            ),
            SizedBox(height: 10),

            // Camera Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 3,
              child: ListTile(
                leading: Icon(Icons.camera_alt, color: Colors.green),
                title: Text("Camera"),
                onTap: () {
                  AppNavigation.back;
                  onCameraTap(); // Call camera function
                },
              ),
            ),
            SizedBox(height: 10),
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
