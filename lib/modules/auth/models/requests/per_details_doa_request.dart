class PerDetailsDaoRequest {
  final String userEmail;
  final String password;
  final String userName;
  final String userGender;
  final String userWeight;
  final String userHeight;
  final String userDOB;
  final String userImage;
  final String smokerType;

  const PerDetailsDaoRequest({
    required this.userEmail,
    this.password = "",
    required this.userName,
    required this.userGender,
    required this.userWeight,
    required this.userHeight,
    required this.userDOB,
    required this.userImage,
    required this.smokerType,
  });

  Map<String, dynamic> toJson() {
    return {
      "userEmail": userEmail,
      "password": password,
      "userName": userName,
      "userGender": userGender,
      "userWeight": userWeight,
      "userHeight": userHeight,
      "userDOB": userDOB,
      "userImage": userImage,
      "smokerType": smokerType,
    };
  }
}
