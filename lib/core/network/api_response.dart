class ApiResponse<T> {
  final bool success;
  final int statusCode;
  final String message;
  final T? data;
  final Map<String, dynamic>? rawBody;
  final Map<String, String>? headers;

  const ApiResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
    this.rawBody,
    this.headers,
  });

  factory ApiResponse.failure({
    required int statusCode,
    required String message,
    Map<String, dynamic>? rawBody,
    Map<String, String>? headers,
  }) {
    return ApiResponse<T>(
      success: false,
      statusCode: statusCode,
      message: message,
      rawBody: rawBody,
      headers: headers,
    );
  }

  factory ApiResponse.success({
    required int statusCode,
    required String message,
    T? data,
    Map<String, dynamic>? rawBody,
    Map<String, String>? headers,
  }) {
    return ApiResponse<T>(
      success: true,
      statusCode: statusCode,
      message: message,
      data: data,
      rawBody: rawBody,
      headers: headers,
    );
  }
}
