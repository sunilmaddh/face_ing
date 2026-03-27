class LoginRequest {
  final String emailId;
  final String password;
  final String sdkType;

  const LoginRequest({
    required this.emailId,
    required this.password,
    this.sdkType = "BINAH",
  });

  Map<String, dynamic> toJson() {
    return {"emailId": emailId, "password": password, "sDKType": sdkType};
  }
}
