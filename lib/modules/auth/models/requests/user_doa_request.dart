class UserDaoRequest {
  final String emailId;
  final String userId;

  const UserDaoRequest({required this.emailId, required this.userId});

  Map<String, dynamic> toJson() {
    return {"emailId": emailId, "userId": userId};
  }
}
