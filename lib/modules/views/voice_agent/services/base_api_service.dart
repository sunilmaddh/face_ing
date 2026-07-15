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
      // "https://dev.sourcebytes.ai/api/v1/voice_agent/web/voice/webhook/05fe806e-7dc0-465c-9305-3c3fafced082/",
      "https://app.sourcebytes.ai/api/v1/voice_agent/web/voice/webhook/2b7ba806-33a3-45d8-bce3-3352c81c38b0/",
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
