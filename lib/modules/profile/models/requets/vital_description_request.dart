class VitalDescriptionRequest {
  final dynamic vitalKey;

  const VitalDescriptionRequest({required this.vitalKey});

  Map<String, dynamic> toJson() {
    return {"vitalKey": vitalKey};
  }
}
