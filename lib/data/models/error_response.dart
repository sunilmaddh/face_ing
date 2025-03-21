// // To parse this JSON data, do
// //
// //     final errorResponse = errorResponseFromJson(jsonString);

// import 'dart:convert';

// ErrorResponse errorResponseFromJson(String str) => ErrorResponse.fromJson(json.decode(str));

// String errorResponseToJson(ErrorResponse data) => json.encode(data.toJson());

// class ErrorResponse {
//     String message,
//      emailId,
//      otp,
//      userId,
//      sdkInfo;
     
//     bool success;

//     ErrorResponse({
//         required this.message,
//         required this.emailId,
//         required this.otp,
//         required this.userId,
//         required this.sdkInfo,
//         required this.success,
//     });

//     factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
//         message: json["message"],
//         emailId: json["emailId"],
//         otp: json["otp"],
//         userId: json["userId"],
//         sdkInfo: json["sdkInfo"],
//         success: json["success"],
//     );

//     Map<String, dynamic> toJson() => {
//         "message": message,
//         "emailId": emailId,
//         "otp": otp,
//         "userId": userId,
//         "sdkInfo": sdkInfo,
//         "commonUserDetailsDao": commonUserDetailsDao,
//         "success": success,
//     };
// }
