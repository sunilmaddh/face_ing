class UserHistoryRequest {
  final String userId;
  final String userFlag;

  const UserHistoryRequest({required this.userId, required this.userFlag});

  Map<String, dynamic> toJson() {
    return {"userId": userId, "userFlag": userFlag};
  }
}
