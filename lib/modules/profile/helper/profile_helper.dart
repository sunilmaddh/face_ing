import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/modules/profile/controller/profile_controller.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:intl/intl.dart';

class ProfileHelper {
  // final ProfileController _profileController = Get.find<ProfileController>();

  /// Prepares the details map for update
  Future<Map<String, dynamic>> updateDetailsMap({
    required String userId,
    required String guestId,
    required String userFlag,
    required String name,
    required String gender,
    required String dob,
    required String smokerType,
    required String weight,
    required String height,
    required String email,
  }) async {
    return {
      "userId": userId,
      "guestId": guestId,
      "userFlag": userFlag,
      "name": name,
      "gender": gender,
      "dob": dob,
      "smokerType": smokerType,
      "emailId": email,
      "weight": weight,
      "height": height,
    };
  }

  // /// Calls the function to update user/guest details
  // Future<void> callUpdateDetailsFunction({
  //   required String userId,
  //   required String guestId,
  //   required String userFlag,
  //   required String name,
  //   required String gender,
  //   required String dob,
  //   required String smokerType,
  //   required String weight,
  //   required String height,
  //   required String email,
  //   required ProfileController profileController
  // }) async {
  //   var newDob = await AppMethods().convertDateFormatToYY(dob);
  //   final data = await _updateDetailsMap(
  //     userId: userId,
  //     guestId: guestId,
  //     userFlag: userFlag,
  //     name: name,
  //     gender: gender,
  //     dob: newDob,
  //     smokerType: smokerType,
  //     weight: weight,
  //     height: height,
  //     email: email,
  //   );

  // }

  Future<void> retainedData({
    required ProfileController profileController,
    required String name,
    required String weight,
    required String height,
    required String gender,
    required String dob,
    required String smokerType,
    required String guestId,
    required String emailId,
    required String userFlag,
    required String levelName,
  }) async {
    var newData = await AppMethods().convertDateFormateToDD(dob);
    profileController.nameController.text = name;
    profileController.genderType.value = gender;
    profileController.dobController.text = newData;
    profileController.weightController.text = weight;
    profileController.heightController.text = height;
    profileController.smokerType.value = smokerType;
    profileController.emailController.text = emailId;
    AppNavigation.to(
      AppRoutes.updateUserGuestDetails,
      arguments: {
        AppConstents.guestId: guestId,
        AppConstents.userFlag: userFlag,
        AppConstents.nameLower: levelName,
      },
    );
  }

  Future<void> retainedUserData(ProfileController controller) async {
    var name = await IndoSharedPreference.instance.getUserName();
    var gender = await IndoSharedPreference.instance.getGenderType();
    var dob = await IndoSharedPreference.instance.getAge();
    var weight = await IndoSharedPreference.instance.getWeight();
    var height = await IndoSharedPreference.instance.getHeight();
    var smokerType = await IndoSharedPreference.instance.getSmokerType();
    var newData = await AppMethods().convertDateFormateToDD(dob);
    await retainedData(
      name: name,
      weight: weight,
      height: height,
      gender: gender,
      dob: newData,
      smokerType: smokerType,
      guestId: "",
      userFlag: "true",
      levelName: "Name",
      emailId: '',
      profileController: controller,
    );
  }

  Map<String, String> extractDateAndTime(String dateTimeStr) {
    // Supported formats list
    final formats = [
      AppConstents.yyyyMMdd_HHmmss_dash,
      AppConstents.yyyyMMdd_HHmmss_slash,
      AppConstents.ddMMyyyy_HHmmss_dash,
      AppConstents.ddMMyyyy_HHmmss_slash,
      AppConstents.yyyyMMddDash,
      AppConstents.yyyyMMddSlash,
      AppConstents.ddMMyyyyDash,
      AppConstents.ddMMyyyySlash,
    ];

    for (String format in formats) {
      try {
        DateTime dateTime = DateFormat(format).parseStrict(dateTimeStr);

        // Format output
        String date = DateFormat(AppConstents.ddMMyyyySlash).format(dateTime);
        String time = DateFormat('HH:mm:ss').format(dateTime);

        return {"date": date, "time": time};
      } catch (e) {
        // Ignore and try next format
      }
    }

    // Return fallback if no format matched
    return {"date": "Invalid", "time": "Invalid"};
  }
}
