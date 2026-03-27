class ForgotOtpRequest {
  final String emailId;

  const ForgotOtpRequest({required this.emailId});

  Map<String, dynamic> toJson() {
    return {"emailId": emailId};
  }
}
