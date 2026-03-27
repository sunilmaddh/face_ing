class VoiceCallRequest {
  final String sessionId;
  final bool isUserVoice;
  final bool isAgentVoice;
  final bool isUserTransaction;
  final bool isAgentTransaction;
  final bool isFullRecording;
  final bool isUserAgentVoice;

  const VoiceCallRequest({
    required this.sessionId,
    required this.isUserVoice,
    required this.isAgentVoice,
    required this.isUserTransaction,
    required this.isAgentTransaction,
    required this.isFullRecording,
    required this.isUserAgentVoice,
  });

  Map<String, dynamic> toJson() {
    return {
      "sessionId": sessionId,
      "isUserVoice": isUserVoice,
      "isAgentVoice": isAgentVoice,
      "isUserTranscription": isUserTransaction,
      "isAgentTranscription": isAgentTransaction,
      "isFullRecording": isFullRecording,
      "isUserAgentVoice": isUserAgentVoice,
    };
  }

  VoiceCallRequest copyWith({
    String? sessionId,
    bool? isUserVoice,
    bool? isAgentVoice,
    bool? isUserTransaction,
    bool? isAgentTransaction,
    bool? isFullRecording,
    bool? isUserAgentVoice,
  }) {
    return VoiceCallRequest(
      sessionId: sessionId ?? this.sessionId,
      isUserVoice: isUserVoice ?? this.isUserVoice,
      isAgentVoice: isAgentVoice ?? this.isAgentVoice,
      isUserTransaction: isUserTransaction ?? this.isUserTransaction,
      isAgentTransaction: isAgentTransaction ?? this.isAgentTransaction,
      isFullRecording: isFullRecording ?? this.isFullRecording,
      isUserAgentVoice: isUserAgentVoice ?? this.isUserAgentVoice,
    );
  }
}
