import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ntt_data/core/constants/api_constants.dart';
import 'package:ntt_data/core/constants/app_logs.dart';
import 'package:ntt_data/core/network/api_endpoints.dart';
import 'package:ntt_data/core/network/api_request.dart';
import 'package:ntt_data/core/network/api_response.dart';
import 'package:ntt_data/core/network/encryption_service.dart';
import 'package:ntt_data/core/storage/secure_storage.dart';
import 'package:ntt_data/core/utils/app_logger.dart';

typedef JsonMapper<T> = T Function(Map<String, dynamic> json);

class ApiService {
  ApiService({required this.encryptionService, this.isHttps = false});

  final EncryptionService encryptionService;
  final bool isHttps;

  String get baseUrl => ApiEndpoints.baseUrl;
  String get voiceBaseUrl => ApiEndpoints.voiceBaseUrl;
  String get apiPrefix => ApiConstants.apiPrefix;

  bool get _shouldUseEncryption => kReleaseMode;

  Uri _buildUri(ApiRequest request) {
    final host = request.useVoiceBaseUrl ? voiceBaseUrl : baseUrl;
    final path =
        request.includeApiPrefix
            ? "$apiPrefix${request.endpoint}"
            : request.endpoint;

    return request.isHttps ? Uri.https(host, path) : Uri.http(host, path);
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
      AppLogger.error(AppLogs.apiError, e, s);
      return ApiResponse.failure(statusCode: -1, message: e.toString());
    }
  }

  Future<ApiResponse<T>> _sendInternal<T>(
    ApiRequest request, {
    JsonMapper<T>? fromJson,
    required bool retryOnUnauthorized,
  }) async {
    final uri = _buildUri(request);
    final accessToken = await SecureStorageService.instance.getAccessToken();

    final headers = <String, String>{
      ApiConstants.contentType: ApiConstants.applicationJson,
      ...?request.headers,
    };

    if (request.requiresAuth && accessToken.isNotEmpty) {
      headers[ApiConstants.authorization] =
          "${ApiConstants.bearer} $accessToken";
    }

    Object? finalBody = request.body;

    if (_shouldUseEncryption && request.encryptBody && request.body != null) {
      finalBody = encryptionService.encryptRequest(request.body!);
    }

    _logRequest(
      uri: uri,
      method: request.method.name,
      headers: headers,
      body: finalBody,
      isEncrypted: _shouldUseEncryption && request.encryptBody,
    );

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
      AppLogger.warning(AppLogs.tokenExpiredRefresh);

      final refreshed = await _refreshToken();

      if (refreshed) {
        AppLogger.info(AppLogs.tokenRefreshSuccess);
        return _sendInternal<T>(
          request,
          fromJson: fromJson,
          retryOnUnauthorized: false,
        );
      } else {
        AppLogger.error(AppLogs.tokenRefreshFailed);
      }
    }

    return _parseResponse<T>(response, fromJson: fromJson, request: request);
  }

  ApiResponse<T> _parseResponse<T>(
    http.Response response, {
    JsonMapper<T>? fromJson,
    ApiRequest? request,
  }) {
    final decodedBodyText = utf8.decode(response.bodyBytes);

    _logResponse(
      statusCode: response.statusCode,
      responseBody: decodedBodyText,
    );

    Map<String, dynamic> jsonBody = {};

    if (decodedBodyText.isNotEmpty) {
      try {
        final decoded = jsonDecode(decodedBodyText);
        if (decoded is Map<String, dynamic>) {
          jsonBody = decoded;
        }
      } catch (e, s) {
        AppLogger.error(AppLogs.responseJsonDecodeFailed, e, s);
      }
    }

    final message =
        jsonBody[ApiConstants.message]?.toString() ??
        jsonBody[ApiConstants.msg]?.toString() ??
        ApiConstants.requestCompleted;

    final isSuccess = response.statusCode >= 200 && response.statusCode < 300;

    Map<String, dynamic> processedBody = jsonBody;

    if (_shouldUseEncryption &&
        request?.encryptBody == true &&
        jsonBody.containsKey(ApiConstants.payload)) {
      try {
        processedBody = encryptionService.decryptResponse(jsonBody);
      } catch (e, s) {
        AppLogger.error(AppLogs.responseDecryptionFailed, e, s);
        processedBody = jsonBody;
      }
    }

    T? data;
    if (fromJson != null) {
      final candidate = processedBody[ApiConstants.data];

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
    try {
      final refreshToken =
          await SecureStorageService.instance.getRefreshToken();

      if (refreshToken.isEmpty) {
        AppLogger.warning(AppLogs.refreshTokenEmpty);
        return false;
      }

      final uri =
          isHttps
              ? Uri.https(baseUrl, ApiEndpoints().refreshToken)
              : Uri.http(baseUrl, ApiEndpoints().refreshToken);

      final headers = {
        ApiConstants.contentType: ApiConstants.applicationJson,
        ApiConstants.authorization: "${ApiConstants.bearer} $refreshToken",
      };

      AppLogger.debug(AppLogs.refreshTokenRequest);
      AppLogger.debug("${AppLogs.url}: $uri");
      AppLogger.debug("${AppLogs.headers}: ${_maskHeaders(headers)}");

      final response = await http.post(uri, headers: headers);

      final decodedText = utf8.decode(response.bodyBytes);

      AppLogger.info(AppLogs.refreshTokenResponse);
      AppLogger.info("${AppLogs.status}: ${response.statusCode}");
      AppLogger.debug("${AppLogs.response}: $decodedText");

      if (response.statusCode != 200) {
        return false;
      }

      final body = jsonDecode(decodedText);

      String? newAccessToken;
      if (body is Map<String, dynamic>) {
        newAccessToken =
            body[ApiConstants.accessToken]?.toString() ??
            body[ApiConstants.data]?[ApiConstants.accessToken]?.toString();
      }

      if (newAccessToken == null || newAccessToken.isEmpty) {
        AppLogger.warning(AppLogs.newAccessTokenMissing);
        return false;
      }

      await SecureStorageService.instance.saveAccessToken(newAccessToken);
      AppLogger.info(AppLogs.newAccessTokenSaved);

      return true;
    } catch (e, s) {
      AppLogger.error(AppLogs.refreshTokenApiFailed, e, s);
      return false;
    }
  }

  Future<ApiResponse<T>> uploadImage<T>({
    required String endpoint,
    required String filePath,
    required String imageType,
    required String guestId,
    required String isGuest,
    required T Function(Map<String, dynamic> json) fromJson,
  }) async {
    try {
      final accessToken = await SecureStorageService.instance.getAccessToken();

      final uri =
          isHttps ? Uri.https(baseUrl, endpoint) : Uri.http(baseUrl, endpoint);

      final request = http.MultipartRequest(ApiConstants.put, uri);

      request.files.add(
        await http.MultipartFile.fromPath(ApiConstants.file, filePath),
      );

      request.fields[ApiConstants.isSignup] = imageType;
      request.fields[ApiConstants.isGuest] = isGuest;
      request.fields[ApiConstants.guestId] = guestId;

      request.headers.addAll({
        ApiConstants.authorization: "${ApiConstants.bearer} $accessToken",
      });

      AppLogger.debug(AppLogs.imageUploadRequest);
      AppLogger.debug("${AppLogs.url}: $uri");
      AppLogger.debug("${AppLogs.headers}: ${_maskHeaders(request.headers)}");
      AppLogger.debug("${AppLogs.filePath}: $filePath");
      AppLogger.debug("${AppLogs.fields}: ${request.fields}");

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      AppLogger.info(AppLogs.imageUploadResponse);
      AppLogger.info("${AppLogs.status}: ${response.statusCode}");

      return _parseResponse<T>(response, fromJson: fromJson);
    } catch (e, s) {
      AppLogger.error(AppLogs.imageUploadError, e, s);
      return ApiResponse.failure(statusCode: -1, message: e.toString());
    }
  }

  void _logRequest({
    required Uri uri,
    required String method,
    required Map<String, String> headers,
    required Object? body,
    required bool isEncrypted,
  }) {
    AppLogger.debug(AppLogs.apiRequest);
    AppLogger.debug("${AppLogs.url}: $uri");
    AppLogger.debug("${AppLogs.method}: $method");
    AppLogger.debug("${AppLogs.headers}: ${_maskHeaders(headers)}");

    if (body != null) {
      if (isEncrypted) {
        AppLogger.debug("${AppLogs.body}: ${AppLogs.encrypted}");
      } else {
        AppLogger.debug("${AppLogs.body}: $body");
      }
    } else {
      AppLogger.debug("${AppLogs.body}: ${AppLogs.nullText}");
    }
  }

  void _logResponse({required int statusCode, required String responseBody}) {
    AppLogger.info(AppLogs.apiResponse);
    AppLogger.info("${AppLogs.status}: $statusCode");
    AppLogger.debug("${AppLogs.response}: $responseBody");
  }

  Map<String, String> _maskHeaders(Map<String, String> headers) {
    final masked = Map<String, String>.from(headers);

    if (masked.containsKey(ApiConstants.authorization)) {
      masked[ApiConstants.authorization] = _maskValue(
        masked[ApiConstants.authorization]!,
      );
    }

    return masked;
  }

  String _maskValue(String value) {
    if (value.isEmpty) return value;
    if (value.length <= 10) return AppLogs.masked;
    return "${value.substring(0, 5)}${AppLogs.masked}${value.substring(value.length - 5)}";
  }
}
