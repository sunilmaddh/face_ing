class UserHealthHistoryRequest {
  final String userId;
  final String guestId;
  final String isUser;

  UserHealthHistoryRequest({
    required this.userId,
    required this.guestId,
    required this.isUser,
  });

  Map<String, dynamic> toJson() {
    return {"userId": userId, "guestId": guestId, "isUser": isUser};
  }
}
