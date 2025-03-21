import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/controllers.dart/otp_controller.dart';
import 'package:ntt_data/services/auth_services.dart';

class AuthController extends GetxController {

  final _authServices=Get.put(AuthServices());

  final emailController=TextEditingController();
  final passwordController=TextEditingController();
    final emailSignController=TextEditingController();
  final passwordSignController=TextEditingController();
    final dateController=TextEditingController();
    final confirmPasswordController=TextEditingController();
     final weightController=TextEditingController();
    final heightController=TextEditingController();
    RxBool isLoading=false.obs;
    var isChecked = false.obs;
    RxString date="".obs;
  var selectedDate = DateTime.now().obs;
  void toggleCheckbox() {
    isChecked.value = !isChecked.value;
  }

void selectDate(BuildContext context) async {
  DateTime currentDate = DateTime.now();
  DateTime minDate = DateTime(1900, 1, 1);
  DateTime maxDate = DateTime(2100, 12, 31); // ✅ Set a valid future max date

  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: currentDate.isBefore(maxDate) ? currentDate : maxDate, // ✅ Ensure within range
    firstDate: minDate,
    lastDate: maxDate,
  );

  if (pickedDate != null) {
   dateController.text=pickedDate.toString();
    print("Selected Date: $pickedDate");
  }
}

Future<void> getSingUpOtp()async{

 isLoading(true);
 var data={"emailid":emailSignController.text,
       "password":passwordSignController.text,
       "confirmPassword":confirmPasswordController.text
 };
 debugPrint(data.toString());
  try{
    Map<String, dynamic> response=await AuthServices.getSignUpOtp(data: data);
    debugPrint(response["responseBody"].toString());
    
  }catch(e){
    debugPrint(e.toString());
  }finally{
   isLoading(false);
  }
} 
// Future<void> verifySingUpOtp()async{
//  isLoading(false);
//  var data={"emailId":emailSignController.text,
//        "userid":passwordSignController.text,
//        "otp":""
//  };
//   try{
//     var response=_authServices.getSignUpOtp(data: data);
//     debugPrint(response.toString());
//   }catch(e){
//     debugPrint(e.toString());
//   }finally{
//    isLoading(false);
//   }
  
     
// } 
// Future<void> userLogin()async{
//  isLoading(false);
//  var data={"emailId":emailSignController.text,
//        "password":passwordSignController.text,
       
//  };
//   try{
//     var response=_authServices.getSignUpOtp(data: data);
//     debugPrint(response.toString());
//   }catch(e){
//     debugPrint(e.toString());
//   }finally{
//    isLoading(false);
//   }
  
     
// } 

}