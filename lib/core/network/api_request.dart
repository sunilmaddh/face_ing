enum HttpMethod { get, post, put, delete }

class ApiRequest {
  final String endpoint;
  final HttpMethod method;
  final Object? body;
  final Map<String, String>? headers;
  final bool requiresAuth;
  final bool encryptBody;
  final bool useVoiceBaseUrl;
  final bool includeApiPrefix;
  final bool isHttps;

  const ApiRequest({
    required this.endpoint,
    required this.method,
    this.body,
    this.headers,
    this.requiresAuth = true,
    this.encryptBody = false,
    this.useVoiceBaseUrl = false,
    this.includeApiPrefix = false,
    this.isHttps = false,
  });
}
