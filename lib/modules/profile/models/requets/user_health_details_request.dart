class UserHealthDetailsRequest {
  final String userId;
  final dynamic healthId;
  final dynamic isFullHistory;

  const UserHealthDetailsRequest({
    required this.userId,
    required this.healthId,
    required this.isFullHistory,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "healthId": healthId,
      "isFullHistory": isFullHistory,
    };
  }
}
