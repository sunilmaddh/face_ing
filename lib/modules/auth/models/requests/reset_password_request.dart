class ResetPasswordRequest {
  final String emailId;
  final String password;
  final String confirmPassword;
  final String userId;

  const ResetPasswordRequest({
    required this.emailId,
    required this.password,
    required this.confirmPassword,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      "emailId": emailId,
      "password": password,
      "confirmPassword": confirmPassword,
      "userId": userId,
    };
  }
}
