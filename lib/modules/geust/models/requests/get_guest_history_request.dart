class GetGuestHistoryRequest {
  final String userId;

  GetGuestHistoryRequest({required this.userId});

  Map<String, dynamic> toJson() {
    return {"userId": userId};
  }
}
