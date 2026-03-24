// To parse this JSON data, do
//
//     final webhookResponse = webhookResponseFromJson(jsonString);

import 'dart:convert';

WebhookResponse webhookResponseFromJson(String str) =>
    WebhookResponse.fromJson(json.decode(str));

String webhookResponseToJson(WebhookResponse data) =>
    json.encode(data.toJson());

class WebhookResponse {
  String? status;
  String? streamSid;
  String? message;
  String? tenant;
  String? agent;
  String? agentName;
  String? agentImage;
  WebhookResponse({
    this.status,
    this.streamSid,
    this.tenant,
    this.agent,
    this.message,
    this.agentName,
    this.agentImage,
  });
  factory WebhookResponse.fromJson(Map<String, dynamic> json) =>
      WebhookResponse(
        status: json["status"] ?? "",
        streamSid: json["stream_sid"] ?? "",
        tenant: json["tenant"] ?? "",
        agent: json["agent"] ?? "",
        message: json["message"] ?? "",
        agentName: json["agent_name"] ?? "",
        agentImage: json["agent_avtar"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "stream_sid": streamSid,
    "tenant": tenant,
    "agent": agent,
  };
}
