class StartCallRequest {
  final String tenantId;
  final String agentId;
  final String streamId;

  const StartCallRequest({
    required this.tenantId,
    required this.agentId,
    required this.streamId,
  });

  Map<String, dynamic> toJson() {
    return {"tenantId": tenantId, "agentId": agentId, "streamId": streamId};
  }
}
