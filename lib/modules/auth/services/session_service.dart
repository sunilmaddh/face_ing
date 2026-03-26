import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/modules/auth/models/login_response_model.dart';

class SessionService {
  Future<void> saveLoginSession({
    required LoginResponseModel result,
    required Map<String, String>? headers,
    required bool isFullHistory,
  }) async {
    final accessToken = headers?["accesstoken"] ?? "";
    if (accessToken.isNotEmpty) {
      await IndoSharedPreference.instance.saveAccessToken(accessToken);
    }

    if ((result.userId ?? "").isNotEmpty) {
      await IndoSharedPreference.instance.saveUserId(result.userId!);
    }

    await IndoSharedPreference.instance.saveOnBoard(
      result.onBoarded ?? "false",
    );
    final user = result.commonUserDetailsDao;
    if (user != null) {
      await AppMethods.storeUserData(
        name: user.userName ?? "",
        weight: user.userWeight ?? "",
        height: user.userHeight ?? "",
        gender: user.userGender ?? "",
        dob: user.userDob ?? "",
        email: user.userEmail ?? "",
        smokerType: user.userSmokerType ?? "",
        userImage: user.userImage ?? "",
        isFullHistory: isFullHistory,
      );
    }
  }
}
