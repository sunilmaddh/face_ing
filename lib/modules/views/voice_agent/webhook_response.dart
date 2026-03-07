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
  WebhookResponse({
    this.status,
    this.streamSid,
    this.tenant,
    this.agent,
    this.message,
  });
  factory WebhookResponse.fromJson(Map<String, dynamic> json) =>
      WebhookResponse(
        status: json["status"] ?? "",
        streamSid: json["stream_sid"] ?? "",
        tenant: json["tenant"] ?? "",
        agent: json["agent"] ?? "",
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "stream_sid": streamSid,
    "tenant": tenant,
    "agent": agent,
  };
}
