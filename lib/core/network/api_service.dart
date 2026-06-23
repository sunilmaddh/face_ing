import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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
  ApiService({required this.encryptionService, this.isHttps = false, Dio? dio})
    : _dio = dio ?? Dio() {
    _setupDio();
  }

  final EncryptionService encryptionService;
  final bool isHttps;
  final Dio _dio;

  String get baseUrl => ApiEndpoints.baseUrl;
  String get voiceBaseUrl => ApiEndpoints.voiceBaseUrl;
  String get apiPrefix => ApiConstants.apiPrefix;

  bool get _shouldUseEncryption => kReleaseMode;

  void _setupDio() {
    _dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      responseType: ResponseType.plain,
      validateStatus: (_) => true,
      headers: {ApiConstants.contentType: ApiConstants.applicationJson},
    );
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
    } on DioException catch (e, s) {
      AppLogger.error(AppLogs.apiError, e, s);

      return ApiResponse.failure(
        statusCode: e.response?.statusCode ?? -1,
        message: _handleDioError(e),
        rawBody: _safeDecode(e.response?.data),
        headers: _convertHeaders(e.response?.headers),
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
    final headers = await _buildHeaders(request);
    final body = _prepareBody(request);

    _logRequest(
      uri: uri,
      method: request.method.name.toUpperCase(),
      headers: headers,
      body: body,
      isEncrypted: _shouldUseEncryption && request.encryptBody,
    );

    final response = await _dio.requestUri<dynamic>(
      uri,
      data:
          _canSendBody(request.method) && body != null
              ? jsonEncode(body)
              : null,
      options: Options(
        method: request.method.name.toUpperCase(),
        headers: headers,
        responseType: ResponseType.plain,
        validateStatus: (_) => true,
      ),
    );

    if (_isUnauthorized(response) &&
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
      }

      AppLogger.error(AppLogs.tokenRefreshFailed);
    }

    return _parseResponse<T>(response, fromJson: fromJson, request: request);
  }

  Uri _buildUri(ApiRequest request) {
    final host = request.useVoiceBaseUrl ? voiceBaseUrl : baseUrl;

    final path =
        request.includeApiPrefix
            ? "$apiPrefix${request.endpoint}"
            : request.endpoint;

    return request.isHttps ? Uri.https(host, path) : Uri.http(host, path);
  }

  Future<Map<String, String>> _buildHeaders(ApiRequest request) async {
    final accessToken = await SecureStorageService.instance.getAccessToken();

    final headers = <String, String>{
      ApiConstants.contentType: ApiConstants.applicationJson,
      ...?request.headers,
    };

    if (request.requiresAuth && accessToken.isNotEmpty) {
      headers[ApiConstants.authorization] =
          "${ApiConstants.bearer} $accessToken";
    }

    return headers;
  }

  Object? _prepareBody(ApiRequest request) {
    if (request.body == null) return null;

    if (_shouldUseEncryption && request.encryptBody) {
      return encryptionService.encryptRequest(request.body!);
    }

    return request.body;
  }

  bool _canSendBody(HttpMethod method) {
    return method == HttpMethod.post || method == HttpMethod.put;
  }

  bool _isUnauthorized(Response<dynamic> response) {
    return response.statusCode == 401;
  }

  ApiResponse<T> _parseResponse<T>(
    Response<dynamic> response, {
    JsonMapper<T>? fromJson,
    ApiRequest? request,
  }) {
    final statusCode = response.statusCode ?? -1;
    final decodedBodyText = _responseBodyToString(response.data);

    _logResponse(statusCode: statusCode, responseBody: decodedBodyText);

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

    Map<String, dynamic> processedBody = jsonBody;

    if (_shouldUseEncryption &&
        request?.encryptBody == true &&
        jsonBody.containsKey(ApiConstants.payload)) {
      try {
        processedBody = encryptionService.decryptResponse(jsonBody);
      } catch (e, s) {
        AppLogger.error(AppLogs.responseDecryptionFailed, e, s);
      }
    }

    final message =
        processedBody[ApiConstants.message]?.toString() ??
        processedBody[ApiConstants.msg]?.toString() ??
        ApiConstants.requestCompleted;

    T? data;

    if (fromJson != null) {
      final candidate = processedBody[ApiConstants.data];

      if (candidate is Map<String, dynamic>) {
        data = fromJson(candidate);
      } else if (processedBody.isNotEmpty) {
        data = fromJson(processedBody);
      }
    }

    final isSuccess = statusCode >= 200 && statusCode < 300;

    if (isSuccess) {
      return ApiResponse.success(
        statusCode: statusCode,
        message: message,
        data: data,
        rawBody: processedBody,
        headers: _convertHeaders(response.headers),
      );
    }

    return ApiResponse.failure(
      statusCode: statusCode,
      message: message,
      rawBody: processedBody,
      headers: _convertHeaders(response.headers),
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

      final response = await _dio.postUri<dynamic>(
        uri,
        options: Options(
          headers: headers,
          responseType: ResponseType.plain,
          validateStatus: (_) => true,
        ),
      );

      final statusCode = response.statusCode ?? -1;
      final decodedText = _responseBodyToString(response.data);

      AppLogger.info(AppLogs.refreshTokenResponse);
      AppLogger.info("${AppLogs.status}: $statusCode");
      AppLogger.debug("${AppLogs.response}: $decodedText");

      if (statusCode != 200) {
        return false;
      }

      final decoded = jsonDecode(decodedText);

      String? newAccessToken;

      if (decoded is Map<String, dynamic>) {
        newAccessToken =
            decoded[ApiConstants.accessToken]?.toString() ??
            decoded[ApiConstants.data]?[ApiConstants.accessToken]?.toString();
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
    required JsonMapper<T> fromJson,
  }) async {
    try {
      final accessToken = await SecureStorageService.instance.getAccessToken();

      final uri =
          isHttps ? Uri.https(baseUrl, endpoint) : Uri.http(baseUrl, endpoint);

      final headers = {
        ApiConstants.authorization: "${ApiConstants.bearer} $accessToken",
      };

      final formData = FormData.fromMap({
        ApiConstants.file: await MultipartFile.fromFile(filePath),
        ApiConstants.isSignup: imageType,
        ApiConstants.isGuest: isGuest,
        ApiConstants.guestId: guestId,
      });

      AppLogger.debug(AppLogs.imageUploadRequest);
      AppLogger.debug("${AppLogs.url}: $uri");
      AppLogger.debug("${AppLogs.headers}: ${_maskHeaders(headers)}");
      AppLogger.debug("${AppLogs.filePath}: $filePath");

      final response = await _dio.putUri<dynamic>(
        uri,
        data: formData,
        options: Options(
          headers: headers,
          contentType: Headers.multipartFormDataContentType,
          responseType: ResponseType.plain,
          validateStatus: (_) => true,
        ),
      );

      AppLogger.info(AppLogs.imageUploadResponse);
      AppLogger.info("${AppLogs.status}: ${response.statusCode}");

      return _parseResponse<T>(response, fromJson: fromJson);
    } on DioException catch (e, s) {
      AppLogger.error(AppLogs.imageUploadError, e, s);

      return ApiResponse.failure(
        statusCode: e.response?.statusCode ?? -1,
        message: _handleDioError(e),
        rawBody: _safeDecode(e.response?.data),
        headers: _convertHeaders(e.response?.headers),
      );
    } catch (e, s) {
      AppLogger.error(AppLogs.imageUploadError, e, s);

      return ApiResponse.failure(statusCode: -1, message: e.toString());
    }
  }

  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiConstants.connectionTimeout;

      case DioExceptionType.sendTimeout:
        return ApiConstants.requestSendTimeout;

      case DioExceptionType.receiveTimeout:
        return ApiConstants.responseTimeout;

      case DioExceptionType.badCertificate:
        return ApiConstants.invalidCertificate;

      case DioExceptionType.cancel:
        return ApiConstants.requestCancelled;

      case DioExceptionType.connectionError:
        return ApiConstants.noInternet;

      case DioExceptionType.badResponse:
        return error.response?.statusMessage ?? ApiConstants.somethingWentWrong;

      case DioExceptionType.unknown:
        return ApiConstants.somethingWentWrong;
    }
  }

  String _responseBodyToString(dynamic data) {
    if (data == null) return "";

    if (data is String) {
      return data;
    }

    if (data is List<int>) {
      return utf8.decode(data);
    }

    return jsonEncode(data);
  }

  Map<String, dynamic> _safeDecode(dynamic data) {
    try {
      final text = _responseBodyToString(data);

      if (text.isEmpty) return {};

      final decoded = jsonDecode(text);

      if (decoded is Map<String, dynamic>) {
        return decoded;
      }

      return {ApiConstants.data: decoded};
    } catch (_) {
      return {};
    }
  }

  Map<String, String> _convertHeaders(Headers? headers) {
    if (headers == null) return {};

    return headers.map.map((key, value) => MapEntry(key, value.join(",")));
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

    if (body == null) {
      AppLogger.debug("${AppLogs.body}: ${AppLogs.nullText}");
      return;
    }

    if (isEncrypted) {
      AppLogger.debug("${AppLogs.body}: ${AppLogs.encrypted}");
    } else {
      AppLogger.debug("${AppLogs.body}: $body");
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

    if (value.length <= 10) {
      return AppLogs.masked;
    }

    return "${value.substring(0, 5)}${AppLogs.masked}${value.substring(value.length - 5)}";
  }
}
