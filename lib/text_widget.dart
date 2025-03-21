import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:ntt_data/core/bindings/app_bindings.dart';
import 'package:ntt_data/widgets/button/primary_button.dart';

void main(){
 runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
  initialBinding: AppBindings()           ,
      home: MyWidget(),
    );
  }
}
class MyWidget extends StatelessWidget {
   MyWidget({super.key});
    final TextEditingController _text=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PrimaryButton(text: "Submit", onPressed: (){
//                 Navigator.push(
//   context,
//   MaterialPageRoute(builder: (context) => ScanningScreen()),
// );

                // AppNavigation.to(AppRoutes.scanScreen);

              //   CustomBottomSheet.show(
              // title: "Select an Option",
              // content: Column(
              //   children: [
              //     ListTile(
              //       leading: Icon(Icons.photo),
              //       title: Text("Gallery"),
              //       onTap: () => print("Gallery Selected"),
              //     ),
              //     ListTile(
              //       leading: Icon(Icons.camera),
              //       title: Text("Camera"),
              //       onTap: () => print("Camera Selected"),
              //     ),
              //   ],
              // ),);
              },color: Colors.black,),
            ),
            // SvgPicture.asset(AppAssets.onboard1),
            //                     // Image(image: AssetImage("assets/images/svg/testing.jpg")),

            // CustomFormField(label: "Email", hint: 'Please enter email', controller: _text), 

            // CustomRadioButton(value: "", groupValue: "", label: "ggggg", onChanged: (v){})
             
            
        ],),
      ),
    );
  }
}