class AppLogs {
  const AppLogs._();

  static const apiRequest = "➡️ API REQUEST";
  static const apiResponse = "✅ API RESPONSE";
  static const apiError = "❌ API ERROR";

  static const refreshTokenRequest = "➡️ REFRESH TOKEN REQUEST";
  static const refreshTokenResponse = "✅ REFRESH TOKEN RESPONSE";

  static const imageUploadRequest = "➡️ IMAGE UPLOAD REQUEST";
  static const imageUploadResponse = "✅ IMAGE UPLOAD RESPONSE";
  static const imageUploadError = "❌ IMAGE UPLOAD ERROR";

  static const tokenExpiredRefresh =
      "🔄 Access token expired. Attempting refresh token...";
  static const tokenRefreshSuccess =
      "✅ Token refreshed successfully. Retrying request...";
  static const tokenRefreshFailed = "❌ Token refresh failed";
  static const refreshTokenEmpty = "⚠️ Refresh token is empty";
  static const newAccessTokenMissing =
      "⚠️ New access token not found in refresh response";
  static const newAccessTokenSaved = "✅ New access token saved successfully";
  static const refreshTokenApiFailed = "❌ Refresh token API failed";

  static const responseJsonDecodeFailed = "❌ Response JSON decode failed";
  static const responseDecryptionFailed = "❌ Response decryption failed";
  static const invalidDecryptedResponseFormat =
      "Invalid decrypted response format";

  static const url = "URL";
  static const method = "Method";
  static const headers = "Headers";
  static const body = "Body";
  static const response = "Response";
  static const status = "Status";
  static const filePath = "File Path";
  static const fields = "Fields";

  static const encrypted = "[ENCRYPTED]";
  static const nullText = "null";
  static const masked = "***";
  static const throwException =
      "AppPreferences not initialized. Call AppPreferences.instance.init() first.";
}
