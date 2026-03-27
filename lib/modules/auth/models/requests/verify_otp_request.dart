class VerifyForgotOtpRequest {
  final String emailId;
  final String otp;
  final String userId;

  const VerifyForgotOtpRequest({
    required this.emailId,
    required this.otp,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {"emailId": emailId, "otp": otp, "userId": userId};
  }
}
