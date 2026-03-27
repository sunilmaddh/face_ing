import 'package:biosensesignal_flutter_sdk/vital_signs/vital_signs_results.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/modules/geust/helper/guest_halper.dart';

class AddGuestRequest {
  final String userId;
  final String name;
  final String gender;
  final String dob;
  final String weight;
  final String height;
  final String email;
  final String guestImage;
  final String smokerType;
  final VitalSignsResults vitalSignResult;

  AddGuestRequest({
    required this.userId,
    required this.name,
    required this.gender,
    required this.dob,
    required this.weight,
    required this.height,
    required this.email,
    required this.guestImage,
    required this.smokerType,
    required this.vitalSignResult,
  });

  /// Main API body
  Future<Map<String, dynamic>> toJson() async {
    final newDob = await AppMethods().convertDateFormatToYY(dob);

    return {
      "guestDao": _guestDao(newDob),
      "binahDetails": await _binahDetails(),
    };
  }

  /// Guest basic details
  Map<String, dynamic> _guestDao(String newDob) {
    return {
      "userId": userId,
      "name": name,
      "gender": gender,
      "dob": newDob,
      "weight": weight,
      "height": height,
      "emailId": email,
      "smokerType": smokerType,
      "guestImage": guestImage,
    };
  }

  /// Binah SDK data (reuse your existing logic)
  Future<Map<String, dynamic>> _binahDetails() async {
    return await GuestHelper().getBinahVitalData(
      vitalSignResult: vitalSignResult,
    );
  }
}
