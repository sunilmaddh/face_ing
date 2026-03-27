class StartStreamRequest {
  final String type;
  final String streamSid;
  final String transport;

  StartStreamRequest({
    this.type = "start",
    required this.streamSid,
    this.transport = "webrtc_mobile",
  });

  Map<String, dynamic> toJson() {
    return {"type": type, "stream_sid": streamSid, "transport": transport};
  }
}
