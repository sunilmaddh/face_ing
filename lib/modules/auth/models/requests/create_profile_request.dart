class CreateProfileRequest {
  final String emailId;
  final String userId;
  final String name;
  final String genderType;
  final String weight;
  final String height;
  final String dob;
  final String userImage;
  final String smokerType;
  final List<Map<String, dynamic>> healthList;

  CreateProfileRequest({
    required this.emailId,
    required this.userId,
    required this.name,
    required this.genderType,
    required this.weight,
    required this.height,
    required this.dob,
    required this.userImage,
    required this.smokerType,
    required this.healthList,
  });

  Map<String, dynamic> toJson() => {
    "emailId": emailId,
    "userId": userId,
    "name": name,
    "genderType": genderType,
    "weight": weight,
    "height": height,
    "dob": dob,
    "userImage": userImage,
    "smokerType": smokerType,
    "healthList": healthList,
  };
}
