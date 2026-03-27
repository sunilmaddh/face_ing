class VoiceWebhookRequest {
  final String agentId;
  final String userName;
  final bool isUserVoice;
  final bool isAgentVoice;
  final bool isUserTranscription;
  final bool isAgentTranscription;
  final bool isFullRecording;
  final bool isUserAgentVoice;
  final String sessionId;
  final String sessionToken;
  final String sessionUrl;
  final int sessionUserDuration;

  const VoiceWebhookRequest({
    required this.agentId,
    required this.userName,
    required this.isUserVoice,
    required this.isAgentVoice,
    required this.isUserTranscription,
    required this.isAgentTranscription,
    required this.isFullRecording,
    required this.isUserAgentVoice,
    required this.sessionId,
    required this.sessionToken,
    required this.sessionUrl,
    this.sessionUserDuration = 60,
  });

  /// Convert to API JSON
  Map<String, dynamic> toJson() {
    return {
      "agent_id": agentId,
      "user_name": userName,
      "is_user_voice": isUserVoice,
      "is_agent_voice": isAgentVoice,
      "is_user_transcription": isUserTranscription,
      "is_agent_transcription": isAgentTranscription,
      "is_full_recording": isFullRecording,
      "is_user_agent_voice": isUserAgentVoice,
      "session_id": sessionId,
      "session_token": sessionToken,
      "session_url": sessionUrl,
      "session_user_duration": sessionUserDuration,
    };
  }

  /// Optional: copyWith (very useful)
  VoiceWebhookRequest copyWith({
    String? agentId,
    String? userName,
    bool? isUserVoice,
    bool? isAgentVoice,
    bool? isUserTranscription,
    bool? isAgentTranscription,
    bool? isFullRecording,
    bool? isUserAgentVoice,
    String? sessionId,
    String? sessionToken,
    String? sessionUrl,
    int? sessionUserDuration,
  }) {
    return VoiceWebhookRequest(
      agentId: agentId ?? this.agentId,
      userName: userName ?? this.userName,
      isUserVoice: isUserVoice ?? this.isUserVoice,
      isAgentVoice: isAgentVoice ?? this.isAgentVoice,
      isUserTranscription: isUserTranscription ?? this.isUserTranscription,
      isAgentTranscription: isAgentTranscription ?? this.isAgentTranscription,
      isFullRecording: isFullRecording ?? this.isFullRecording,
      isUserAgentVoice: isUserAgentVoice ?? this.isUserAgentVoice,
      sessionId: sessionId ?? this.sessionId,
      sessionToken: sessionToken ?? this.sessionToken,
      sessionUrl: sessionUrl ?? this.sessionUrl,
      sessionUserDuration: sessionUserDuration ?? this.sessionUserDuration,
    );
  }
}
