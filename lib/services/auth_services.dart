import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ntt_data/core/utils/api_endpoints.dart';
import 'package:ntt_data/services/base_api_services.dart';

class AuthServices {
  final apiEndpoints=ApiEndpoints();
  static final BaseClient _baseClient = BaseClient();

  static Future<Map<String, dynamic>> getSignUpOtp({required var data}) async {
    // int mobileNum = int.parse(mobileNumber);
    // var data = {"Mobile": mobileNumber};
    http.Response? response = await _baseClient
        .postData(ApiEndpoints.signUp,data: data);
    debugPrint(
        "ResponseCode: ${response!.statusCode}= ResponseBody${response.body}");
    Map<String, dynamic> responseData = {
      'responseCode': response.statusCode,
      'responseBody': response.body
    };
    if (response.statusCode == 200) {
      var resjson = response.body;
   
    }
    return responseData;
  }

//   static Future<Map<String, dynamic>> getMyCropsList(int mobileNumber) async {
//     var data = {"Mobile": mobileNumber};
//     http.Response? response = await _baseClient
//         .postData(AppApiEndpoints.AGRO_MY_CROP_LIST, data: data);
//     debugPrint(
//         "ResponseCode: ${response!.statusCode}= ResponseBody${response.body}");
//     Map<String, dynamic> responseData = {
//       'responseCode': response.statusCode,
//       'responseBody': response.body
//     };
//     if (response.statusCode == 200) {
//       var resjson = response.body;
//       responseData.putIfAbsent(
//           'response', () => agroMyCropListFromJson(resjson));
//     }

//     return responseData;
//   }

//   static Future<Map<String, dynamic>> getMyCropsDetails(int cropId) async {
//     // var data = {"Mobile": mobileNumber};
//     http.Response? response = await _baseClient
//         .getData(AppApiEndpoints.AGRO_MY_CROP_DETAILS + "/$cropId");
//     debugPrint(
//         "ResponseCode: ${response!.statusCode}= ResponseBody${response.body}");
//     Map<String, dynamic> responseData = {
//       'responseCode': response.statusCode,
//       'responseBody': response.body
//     };
//     if (response.statusCode == 200) {
//       var resjson = response.body;
//       responseData.putIfAbsent(
//           'response', () => agroCropDetailsFromJson(resjson));
//     }

//     return responseData;
//   }

//   static Future<Map<String, dynamic>> deleteCropData(
//       int myCropId, int mobileNumber) async {
//     // var data = {"Mobile": mobileNumber};
//     http.Response? response = await _baseClient.deleteCropData(
//         AppApiEndpoints.AGRO_MY_CROP_DELETE + "/$myCropId/$mobileNumber");
//     debugPrint(
//         "ResponseCode: ${response!.statusCode}= ResponseBody${response.body}");
//     Map<String, dynamic> responseData = {
//       'responseCode': response.statusCode,
//       'responseBody': response.body
//     };
//     // if (response.statusCode == 200) {
//     //   var resjson = response.body;
//     //   responseData.putIfAbsent(
//     //       'response', () => agroCropDetailsFromJson(resjson));
//     // }

//     return responseData;
//   }

// //This method is srvice api method .It is used for update owner details.
//   static Future<Map<String, dynamic>> updateOwnerDetails(
//       {required var data}) async {
//     http.Response? response = await _baseClient
//         .postData(AppApiEndpoints.UPDATE_OWNER_DETAILS, data: data);
//     debugPrint(
//         "ResponseCode: ${response!.statusCode}= ResponseBody${response.body}");
//     Map<String, dynamic> responseData = {
//       'responseCode': response.statusCode,
//       'responseBody': response.body
//     };
//     if (response.statusCode == 200) {
//       var resjson = response.body;
//       responseData.putIfAbsent(
//           'response', () => agroOwnerDetailsModalFromJson(resjson));
//     }

//     return responseData;
//   }

//   static Future<Map<String, dynamic>> getAllCrops() async {
//     //  var data = {'mobile': mobileNumber, 'otp': otp};
//     http.Response? response = await _baseClient.getData(
//       AppApiEndpoints.ALL_CROPS,
//     );
//     debugPrint(
//         "ResponseCode: ${response!.statusCode}= ResponseBody${response.body}");
//     Map<String, dynamic> responseData = {
//       'responseCode': response.statusCode,
//       'responseBody': response.body
//     };
//     if (response.statusCode == 200) {
//       var resjson = response.body;
//       responseData.putIfAbsent(
//           'response', () => agroAllCropsModalFromJson(resjson));
//     }

//     return responseData;
//   }

//   static Future<Map<String, dynamic>> getAllSeeds(int cropId) async {
//     var data = {"Crop_Id": cropId};
//     http.Response? response =
//         await _baseClient.postData(AppApiEndpoints.ALL_SEEDS, data: data);
//     debugPrint(
//         "ResponseCode: ${response!.statusCode}= ResponseBody${response.body}");
//     Map<String, dynamic> responseData = {
//       'responseCode': response.statusCode,
//       'responseBody': response.body
//     };
//     if (response.statusCode == 200) {
//       var resjson = response.body;
//       responseData.putIfAbsent(
//           'response', () => agroAllSeedsModalFromJson(resjson));
//     }
//     return responseData;
//   }

//   static Future<Map<String, dynamic>> filterSeed(
//       int cropId, String seed) async {
//     http.Response? response = await _baseClient
//         .getData(AppApiEndpoints.SEARCH_SEED + "/$cropId" + "/$seed");
//     debugPrint(
//         "ResponseCode: ${response!.statusCode}= ResponseBody${response.body}");
//     Map<String, dynamic> responseData = {
//       'responseCode': response.statusCode,
//       'responseBody': response.body
//     };
//     if (response.statusCode == 200) {
//       var resjson = response.body;
//       responseData.putIfAbsent(
//           'response', () => agroAllSeedsModalFromJson(resjson));
//     }

//     return responseData;
//   }

//   //This method is srvice api method .It is used for update crop details.
//   static Future<Map<String, dynamic>> updateCropDetails(
//       {required var data}) async {
//     http.Response? response = await _baseClient
//         .postData(AppApiEndpoints.UPDATE_CROP_DETAILS, data: data);
//     debugPrint(
//         "ResponseCode: ${response!.statusCode}= ResponseBody${response.body}");
//     Map<String, dynamic> responseData = {
//       'responseCode': response.statusCode,
//       'responseBody': response.body
//     };
//     // if (response.statusCode == 200) {
//     //   var resjson = response.body;
//     //   responseData.putIfAbsent(
//     //       'response', () => agroOwnerDetailsModalFromJson(resjson));
//     // }

//     return responseData;
//   }

// //This method is srvice api method .It is used for add new  crop.
//   static Future<Map<String, dynamic>> addNewCrop({required var data}) async {
//     http.Response? response =
//         await _baseClient.postData(AppApiEndpoints.ADD_NEW_CROP, data: data);
//     debugPrint(
//         "ResponseCode: ${response!.statusCode}= ResponseBody${response.body}");
//     Map<String, dynamic> responseData = {
//       'responseCode': response.statusCode,
//       'responseBody': response.body
//     };
//     // if (response.statusCode == 200) {
//     //   var resjson = response.body;
//     //   responseData.putIfAbsent(
//     //       'response', () => agroMyCropListFromJson(resjson));
//     // }

//     return responseData;
//   }

//   static Future<Map<String, dynamic>> uploadDocument(
//     File? imagePath,
//   ) async {
//     http.Response? response = await _baseClient.uploadImage(
//         AppApiEndpoints.UPLOAD_IMAGE, imagePath!.path);
//     debugPrint(
//         "ResponseCode: ${response!.statusCode}= ResponseBody${response.body}");
//     Map<String, dynamic> responseData = {
//       'responseCode': response.statusCode,
//     };
//     if (response.statusCode == 200) {
//       var resjson = response.body;
//       responseData.putIfAbsent(
//           'response', () => agroUploadImageFromJson(resjson));
//     }
//     return responseData;
//   }

  // Future<Map<String, dynamic>> getSignUpOtp({required var data})async{
  //   return await postRequest(ApiEndpoints.signUp,data: data);  
  // }
  // Future<Map<String, dynamic>> verifySignUpOtp({required var data})async{
  //   return await postRequest(ApiEndpoints.verifySignUpOtp,data: data);  
  // }
  //  Future<Map<String, dynamic>> profileCreation({required var data})async{
  //   return await postRequest(ApiEndpoints.continueSignUp,data: data);  
  // }
  //  Future<Map<String, dynamic>> userLogin({required var data})async{
  //   return await postRequest(ApiEndpoints.login,data: data);  
  // }
  //  Future<Map<String, dynamic>> getForgotOtp({required var data})async{
  //   return await postRequest(ApiEndpoints.getforgetOtp,data: data);  
  // }
  //  Future<Map<String, dynamic>> verifyForgotOtp({required var data})async{
  //   return await postRequest(ApiEndpoints.verifyForgotOtp,data: data);  
  // }

}