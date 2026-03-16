import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ntt_data/core/storage/indo_shared_preference.dart';

class BaseVoiceApiService {
  Future<Map<String, dynamic>> postRequest({
    required dynamic data,
    required String userName,
  }) async {
    var accessToken = await IndoSharedPreference.instance.getAccessToken();
    final uri = Uri.parse(
      "https://dev.sourcebytes.ai/api/v1/voice_agent/web/voice/webhook/909ea670-d488-4601-bc8a-01627516631f/",
      //"https://fafb-2406-7400-111-b2f7-d58-a53-90f1-b1a9.ngrok-free.app/api/v1/voice_agent/web/voice/webhook/7ac589c3-3afc-4ae7-8cb3-97ce7fe4f79b/",
    );

    debugPrint("URL: $uri");

    try {
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: jsonEncode(data),
      );

      debugPrint("Status: ${response.statusCode}");
      debugPrint("Body: ${response.body}");

      return {"statusCode": response.statusCode, "responseBody": response.body};
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
