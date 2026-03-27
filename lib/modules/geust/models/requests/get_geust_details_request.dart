class GetGuestDetailsRequest {
  final String userId;
  final String guestId;
  final String healthId;
  final bool isFullHistory;

  GetGuestDetailsRequest({
    required this.userId,
    required this.guestId,
    required this.healthId,
    required this.isFullHistory,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "guestId": guestId,
      "healthId": healthId,
      "isFullHistory": isFullHistory,
    };
  }
}
