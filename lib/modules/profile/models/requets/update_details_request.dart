class UpdateDetailsRequest {
  final String userId;
  final String guestId;
  final String userFlag;
  final String name;
  final String gender;
  final String dob;
  final String smokerType;
  final String weight;
  final String height;
  final String email;

  const UpdateDetailsRequest({
    required this.userId,
    required this.guestId,
    required this.userFlag,
    required this.name,
    required this.gender,
    required this.dob,
    required this.smokerType,
    required this.weight,
    required this.height,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "guestId": guestId,
      "userFlag": userFlag,
      "name": name,
      "gender": gender,
      "dob": dob,
      "smokerType": smokerType,
      "weight": weight,
      "height": height,
      "email": email,
    };
  }

  factory UpdateDetailsRequest.fromJson(Map<String, dynamic> json) {
    return UpdateDetailsRequest(
      userId: json["userId"]?.toString() ?? "",
      guestId: json["guestId"]?.toString() ?? "",
      userFlag: json["userFlag"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      gender: json["gender"]?.toString() ?? "",
      dob: json["dob"]?.toString() ?? "",
      smokerType: json["smokerType"]?.toString() ?? "",
      weight: json["weight"]?.toString() ?? "",
      height: json["height"]?.toString() ?? "",
      email: json["email"]?.toString() ?? "",
    );
  }

  UpdateDetailsRequest copyWith({
    String? userId,
    String? guestId,
    String? userFlag,
    String? name,
    String? gender,
    String? dob,
    String? smokerType,
    String? weight,
    String? height,
    String? email,
  }) {
    return UpdateDetailsRequest(
      userId: userId ?? this.userId,
      guestId: guestId ?? this.guestId,
      userFlag: userFlag ?? this.userFlag,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      smokerType: smokerType ?? this.smokerType,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      email: email ?? this.email,
    );
  }
}
