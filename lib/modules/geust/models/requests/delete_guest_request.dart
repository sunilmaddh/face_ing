class DeleteGuestRequest {
  final String userId;
  final String guestId;

  DeleteGuestRequest({required this.userId, required this.guestId});

  Map<String, dynamic> toJson() {
    return {"userId": userId, "guestId": guestId};
  }
}
