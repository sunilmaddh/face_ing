import 'package:get/get.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/modules/views/auth/auth_controller.dart';
import 'package:ntt_data/modules/views/geust/controller/geust_controller.dart';
import 'package:ntt_data/modules/views/geust/helper/guest_halper.dart';
import 'package:ntt_data/modules/views/profile/controller/profile_controller.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:intl/intl.dart';

class ProfileHelper {
  final ProfileController _profileController = Get.find<ProfileController>();

  final _guestController = Get.find<GeustController>();
  final _authController = Get.find<AuthController>();

  /// Prepares the details map for update
  Future<Map<String, dynamic>> _updateDetailsMap({
    required String userId,
    required String guestId,
    required String userFlag,
    required String name,
    required String gender,
    required String dob,
    required String smokerType,
    required String weight,
    required String height,
  }) async {
    return {
      "userId": userId,
      "guestId": guestId,
      "userFlag": userFlag,
      "name": name,
      "gender": gender,
      "dob": dob,
      "smokerType": smokerType,
      "weight": weight,
      "height": height,
    };
  }

  /// Calls the function to update user/guest details
  Future<void> callUpdateDetailsFunction({
    required String userId,
    required String guestId,
    required String userFlag,
    required String name,
    required String gender,
    required String dob,
    required String smokerType,
    required String weight,
    required String height,
  }) async {
    var newDob = await AppMethods().convertDateFormatToYY(dob);
    final data = await _updateDetailsMap(
      userId: userId,
      guestId: guestId,
      userFlag: userFlag,
      name: name,
      gender: gender,
      dob: newDob,
      smokerType: smokerType,
      weight: weight,
      height: height,
    );
    _callUpdateUGDetails(data: data, userFlag: userFlag);
  }

  /// Sends the details to the ProfileController
  void _callUpdateUGDetails({
    required Map<String, dynamic> data,
    required String userFlag,
  }) {
    _profileController.updateDetailsUG(data: data, userFlag: userFlag);
  }

  Future<void> retainedData({
    required String name,
    required String weight,
    required String height,
    required String gender,
    required String dob,
    required String smokerType,
    required String guestId,
    required String userFlag,
    required String levelName,
  }) async {
    var newData = await AppMethods().convertDateFormateToDD(dob);
    _profileController.nameController.text = name;
    _profileController.genderType.value = gender;
    _profileController.dobController.text = newData;
    _profileController.weightController.text = weight;
    _profileController.heightController.text = height;
    _profileController.smokerType.value = smokerType;

    Get.toNamed(
      AppRoutes.updateUserGuestDetails,
      arguments: {"guestId": guestId, "userFlag": userFlag, "name": levelName},
    );
  }

  Future<void> retainedUserData() async {
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
    );
  }

  Map<String, String> extractDateAndTime(String dateTimeStr) {
    // Supported formats list
    final formats = [
      "yyyy-MM-dd HH:mm:ss",
      "yyyy/MM/dd HH:mm:ss",
      "dd-MM-yyyy HH:mm:ss",
      "dd/MM/yyyy HH:mm:ss",
      "yyyy-MM-dd",
      "yyyy/MM/dd",
      "dd-MM-yyyy",
      "dd/MM/yyyy",
    ];

    for (String format in formats) {
      try {
        DateTime dateTime = DateFormat(format).parseStrict(dateTimeStr);

        // Format output
        String date = DateFormat('dd/MM/yyyy').format(dateTime);
        String time = DateFormat('HH:mm:ss').format(dateTime);

        return {"date": date, "time": time};
      } catch (e) {
        // Ignore and try next format
      }
    }

    // Return fallback if no format matched
    return {"date": "Invalid", "time": "Invalid"};
  }

  Future<void> callGuestHistoryList() async {
    _guestController.getGeustHistory();
  }

  Future<void> storeImage(String userName) async {
    _authController.userUpdateName.value = userName;
    await IndoSharedPreference.instance.saveUserName(userName);
  }
}
