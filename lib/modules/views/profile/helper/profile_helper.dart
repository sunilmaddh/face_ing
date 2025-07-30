import 'package:get/get.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
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
    var newDob = await GuestHalper().convertDateFormate(dob);
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

  static Future<void> storeUserData({
    required String name,
    required String weight,
    required String height,
    required String gender,
    required String dob,
    required String smokerType,
  }) async {
    await Future.wait([
      IndoSharedPreference.instance.saveUserName(name),
      // IndoSharedPreference.instance.saveUserEmail(email),
      IndoSharedPreference.instance.saveGenderType(gender.toString()),
      IndoSharedPreference.instance.saveHeight(height.toString()),
      IndoSharedPreference.instance.saveWeight(weight.toString()),
      IndoSharedPreference.instance.saveAge(dob.toString()),
    ]);
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
  }) async {
    _profileController.nameController.text = name;
    _profileController.genderType.value = gender;
    _profileController.dobController.text = dob;
    _profileController.weightController.text = weight;
    _profileController.heightController.text = height;
    _profileController.smokerType.value = smokerType;
    Get.toNamed(
      AppRoutes.updateUserGuestDetails,
      arguments: {"guestId": guestId, "userFlag": userFlag},
    );
  }

  Future<void> retainedUserData() async {
    var name = await IndoSharedPreference.instance.getUserName();
    var gender = await IndoSharedPreference.instance.getGenderType();
    var dob = await IndoSharedPreference.instance.getAge();
    var weight = await IndoSharedPreference.instance.getWeight();
    var height = await IndoSharedPreference.instance.getHeight();
    var smokerType = await IndoSharedPreference.instance.getSmokerType();

    await retainedData(
      name: name,
      weight: weight,
      height: height,
      gender: gender,
      dob: dob,
      smokerType: smokerType,
      guestId: "",
      userFlag: "true",
    );
  }

  Map<String, String> extractDateAndTime(String dateTimeStr) {
    try {
      DateTime dateTime = DateTime.parse(dateTimeStr);
      // Format date and time separately
      String date = DateFormat(
        'yyyy-MM-dd',
      ).format(dateTime); // e.g. 2025-07-28
      String time = DateFormat('HH:mm:ss').format(dateTime); // e.g. 17:05:53
      return {"date": date, "time": time};
    } catch (e) {
      return {"date": "Invalid", "time": "Invalid"};
    }
  }

  Future<void> callGuestHistoryList() async {
    _guestController.getGeustHistory();
  }

  Future<void> storeImage(String userName) async {
    _authController.userUpdateName.value = userName;
    await IndoSharedPreference.instance.saveUserName(userName);
  }
}
