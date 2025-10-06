import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:ntt_data/core/bindings/app_bindings.dart';
import 'package:ntt_data/widgets/button/primary_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(initialBinding: AppBindings(), home: MyWidget());
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PrimaryButton(
                text: "Submit",
                onPressed: () {},
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
