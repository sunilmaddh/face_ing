// import 'dart:convert';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ntt_data/core/network/api_request.dart';
import 'package:ntt_data/core/network/api_response.dart';
import 'package:ntt_data/core/network/encryption_service.dart';

import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/utils/api_endpoints.dart';

typedef JsonMapper<T> = T Function(Map<String, dynamic> json);

class ApiService {
  ApiService({required this.encryptionService, this.isHttps = false});

  final EncryptionService encryptionService;
  final bool isHttps;

  String get baseUrl => ApiEndpoints.baseUrl;
  String get voiceBaseUrl => ApiEndpoints.voiceBaseUrl;
  String get apiPrefix => "/api";

  Uri _buildUri(ApiRequest request) {
    final host = request.useVoiceBaseUrl ? voiceBaseUrl : baseUrl;
    final path =
        request.includeApiPrefix
            ? "$apiPrefix${request.endpoint}"
            : request.endpoint;

    if (request.isHttps) {
      return Uri.https(host, path);
    }
    return Uri.http(host, path);
  }

  Future<ApiResponse<T>> send<T>(
    ApiRequest request, {
    JsonMapper<T>? fromJson,
  }) async {
    try {
      return await _sendInternal<T>(
        request,
        fromJson: fromJson,
        retryOnUnauthorized: true,
      );
    } catch (e, s) {
      debugPrint("API ERROR: $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(statusCode: -1, message: e.toString());
    }
  }

  Future<ApiResponse<T>> _sendInternal<T>(
    ApiRequest request, {
    JsonMapper<T>? fromJson,
    required bool retryOnUnauthorized,
  }) async {
    final uri = _buildUri(request);
    final accessToken = await IndoSharedPreference.instance.getAccessToken();

    final headers = <String, String>{
      "Content-Type": "application/json",
      ...?request.headers,
    };

    if (request.requiresAuth && accessToken != null && accessToken.isNotEmpty) {
      headers["Authorization"] = "Bearer $accessToken";
    }

    Object? finalBody = request.body;
    if (request.encryptBody && request.body != null) {
      finalBody = encryptionService.encryptRequest(request.body!);
    }

    debugPrint("REQUEST URI: $uri");
    debugPrint("REQUEST METHOD: ${request.method.name}");
    debugPrint("REQUEST HEADERS: $headers");
    debugPrint("REQUEST BODY: $finalBody");

    late http.Response response;

    switch (request.method) {
      case HttpMethod.get:
        response = await http.get(uri, headers: headers);
        break;

      case HttpMethod.post:
        response = await http.post(
          uri,
          headers: headers,
          body: finalBody == null ? null : jsonEncode(finalBody),
        );
        break;

      case HttpMethod.put:
        response = await http.put(
          uri,
          headers: headers,
          body: finalBody == null ? null : jsonEncode(finalBody),
        );
        break;

      case HttpMethod.delete:
        response = await http.delete(uri, headers: headers);
        break;
    }

    if (response.statusCode == 401 &&
        retryOnUnauthorized &&
        request.requiresAuth) {
      final refreshed = await _refreshToken();
      if (refreshed) {
        return _sendInternal<T>(
          request,
          fromJson: fromJson,
          retryOnUnauthorized: false,
        );
      }
    }

    return _parseResponse<T>(response, fromJson: fromJson);
  }

  ApiResponse<T> _parseResponse<T>(
    http.Response response, {
    JsonMapper<T>? fromJson,
  }) {
    final decodedBodyText = utf8.decode(response.bodyBytes);
    debugPrint("RESPONSE [${response.statusCode}]: $decodedBodyText");

    Map<String, dynamic> jsonBody = {};
    if (decodedBodyText.isNotEmpty) {
      final decoded = jsonDecode(decodedBodyText);
      if (decoded is Map<String, dynamic>) {
        jsonBody = decoded;
      }
    }

    final message =
        jsonBody["message"]?.toString() ??
        jsonBody["msg"]?.toString() ??
        "Request completed";

    final isSuccess = response.statusCode >= 200 && response.statusCode < 300;

    Map<String, dynamic> processedBody = jsonBody;
    if (jsonBody.containsKey("payload")) {
      try {
        processedBody = encryptionService.decryptResponse(jsonBody);
      } catch (_) {
        processedBody = jsonBody;
      }
    }

    T? data;
    if (fromJson != null) {
      final candidate = processedBody["data"];
      if (candidate is Map<String, dynamic>) {
        data = fromJson(candidate);
      } else if (processedBody.isNotEmpty) {
        data = fromJson(processedBody);
      }
    }

    if (isSuccess) {
      return ApiResponse.success(
        statusCode: response.statusCode,
        message: message,
        data: data,
        rawBody: processedBody,
        headers: response.headers,
      );
    }

    return ApiResponse.failure(
      statusCode: response.statusCode,
      message: message,
      rawBody: processedBody,
      headers: response.headers,
    );
  }

  Future<bool> _refreshToken() async {
    final refreshToken = await IndoSharedPreference.instance.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) return false;

    final uri =
        isHttps
            ? Uri.https(baseUrl, ApiEndpoints().refreshToken)
            : Uri.http(baseUrl, ApiEndpoints().refreshToken);

    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $refreshToken",
      },
    );

    if (response.statusCode != 200) {
      return false;
    }

    final decodedText = utf8.decode(response.bodyBytes);
    final body = jsonDecode(decodedText);

    String? newAccessToken;
    if (body is Map<String, dynamic>) {
      newAccessToken =
          body["accessToken"]?.toString() ??
          body["data"]?["accessToken"]?.toString();
    }

    if (newAccessToken == null || newAccessToken.isEmpty) {
      return false;
    }

    await IndoSharedPreference.instance.saveAccessToken(newAccessToken);
    return true;
  }

  Future<ApiResponse<Map<String, dynamic>>> uploadImage({
    required String endpoint,
    required String filePath,
    required String imageType,
    required String guestId,
    required String isGuest,
  }) async {
    try {
      final accessToken = await IndoSharedPreference.instance.getAccessToken();
      final uri =
          isHttps ? Uri.https(baseUrl, endpoint) : Uri.http(baseUrl, endpoint);

      final request = http.MultipartRequest('PUT', uri);

      request.files.add(await http.MultipartFile.fromPath('file', filePath));
      request.fields["isSignup"] = imageType;
      request.fields["isGuest"] = isGuest;
      request.fields["guestId"] = guestId;

      request.headers.addAll({"Authorization": "Bearer $accessToken"});

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      return _parseResponse<Map<String, dynamic>>(
        response,
        fromJson: (json) => json,
      );
    } catch (e) {
      return ApiResponse.failure(statusCode: -1, message: e.toString());
    }
  }
}
