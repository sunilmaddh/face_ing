import 'package:ntt_data/core/constants/api_constants.dart';
import 'package:ntt_data/core/constants/date_formats.dart';
import 'package:ntt_data/core/storage/app_preferences.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/modules/profile/controller/profile_controller.dart';
import 'package:ntt_data/modules/profile/models/requets/update_details_request.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:intl/intl.dart';

class ProfileHelper {
  // final ProfileController _profileController = Get.find<ProfileController>();

  /// Prepares the details map for update
  Future<UpdateDetailsRequest> updateDetailsRequest({
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
    return UpdateDetailsRequest(
      userId: userId,
      guestId: guestId,
      userFlag: userFlag,
      name: name,
      gender: gender,
      dob: dob,
      smokerType: smokerType,
      weight: weight,
      height: height,
      email: email,
    );
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
        ApiConstants.guestId: guestId,
        ApiConstants.userFlag: userFlag,
        ApiConstants.nameKey: levelName,
      },
    );
  }

  Future<void> retainedUserData(ProfileController controller) async {
    var name = AppPreferences.instance.getUserName();
    var gender = AppPreferences.instance.getGenderType();
    var dob = AppPreferences.instance.getAge();
    var weight = AppPreferences.instance.getWeight();
    var height = AppPreferences.instance.getHeight();
    var smokerType = AppPreferences.instance.getSmokerType();
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
      DateFormats.yyyyMMddHHmmssDash,
      DateFormats.yyyyMMddHHmmssSlash,
      DateFormats.ddMMyyyyHHmmssDash,
      DateFormats.ddMMyyyyHHmmssSlash,
      DateFormats.yyyyMMddDash,
      DateFormats.yyyyMMddSlash,
      DateFormats.ddMMyyyyDash,
      DateFormats.ddMMyyyySlash,
    ];

    for (String format in formats) {
      try {
        DateTime dateTime = DateFormat(format).parseStrict(dateTimeStr);

        // Format output
        String date = DateFormat(DateFormats.ddMMyyyySlash).format(dateTime);
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
