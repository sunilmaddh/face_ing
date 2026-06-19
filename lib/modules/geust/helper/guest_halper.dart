import 'package:biosensesignal_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vital_signs_results.dart';
import 'package:ntt_data/modules/binah/handler/vital_sign_helper.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/modules/binah/widgets/getvitalStatus.dart';

class GuestHelper {
  Future<double> calculateAge(String dob) async {
    return await AppMethods().calculateAge(dob);
  }

  bool isAdult(double age) => age >= 18;

  static bool isValidInput(String input) {
    final regex = RegExp(r'^[a-zA-Z0-9 .]+$');
    return regex.hasMatch(input);
  }

  Future<Map<String, Map<String, dynamic>>> mapData({
    required String userId,
    required String name,
    required String gender,
    required String dob,
    required String weight,
    required String height,
    required String email,
    required String guestImage,
    required String smokerType,
    required VitalSignsResults vitalSignResult,
  }) async {
    var newDob = await AppMethods().convertDateFormatToYY(dob);
    var data = {
      "guestDao": {
        "userId": userId,
        "name": name,
        "gender": gender,
        "dob": newDob,
        "weight": weight,
        "height": height,
        "emailId": email,
        "smokerType": smokerType,
        "guestImage": guestImage,
      },
      "binahDetails": await getBinahVitalData(vitalSignResult: vitalSignResult),
    };
    return data;
  }

  Future<Map<String, dynamic>> userMapData({
    required String userId,
    required String guestId,
    required String isUser,
    required VitalSignsResults vitalSignResult,
  }) async {
    var data = {
      "userId": userId,
      "guestId": guestId,
      "userFlag": isUser,
      "binahDetails": await getBinahVitalData(vitalSignResult: vitalSignResult),
    };
    return data;
  }

  final statusHelper = Getvitalstatus();
  Future<Map<String, dynamic>> getBinahVitalData({
    required VitalSignsResults vitalSignResult,
  }) async {
    var binahData = {
      "healthInfoMap": {
        "pulseRate": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.pulseRate),
          "vitalConfidece": VitalSignHelper().vitalSignPulseRateConfidence(),
        },
        "respirationRate": {
          "vitalValue": statusHelper.getVitalValue(
            VitalSignTypes.respirationRate,
          ),
          "vitalConfidence": VitalSignHelper().vitalSignBreathingConfidence(),
        },
        "oxygenSaturation": {
          "vitalValue": statusHelper.getVitalValue(
            VitalSignTypes.oxygenSaturation,
          ),
          "vitalConfidence": "",
        },
        "sdnn": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.sdnn),
          "vitalConfidence": VitalSignHelper().vitalSignSDNNConfidence(),
        },
        "stressLevel": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.stressLevel),
          "vitalConfidence": "",
        },
        "rri": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.rri),
          "vitalConfidence": VitalSignHelper().vitalSignRriConfidence(),
        },
        "bloodPressure": {
          "vitalValue": statusHelper.getVitalValue(
            VitalSignTypes.bloodPressure,
          ),
          "vitalConfidence": "",
        },
        "stressIndex": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.stressIndex),
          "vitalConfidence": "",
        },
        "meanRri": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.meanRri),
          "vitalConfidence": VitalSignHelper().vitalSignMeanRriConfidence(),
        },
        "rmssd": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.rmssd),
          "vitalConfidence": "",
        },
        "sd1": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.sd1),
          "vitalConfidence": "",
        },
        "sd2": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.sd2),
          "vitalConfidence": "",
        },
        "prq": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.prq),
          "vitalConfidence": VitalSignHelper().vitalSignPrqConfidence(),
        },
        "pnsIndex": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.pnsIndex),
          "vitalConfidence": "",
        },
        "pnsZone": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.pnsZone),
          "vitalConfidence": "",
        },
        "snsIndex": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.snsIndex),
          "vitalConfidence": "",
        },
        "snsZone": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.snsZone),
          "vitalConfidence": "",
        },
        "wellnessIndex": {
          "vitalValue": statusHelper.getVitalValue(
            VitalSignTypes.wellnessIndex,
          ),
          "vitalConfidence": "",
        },
        "wellnessLevel": {
          "vitalValue": statusHelper.getVitalValue(
            VitalSignTypes.wellnessLevel,
          ),
          "vitalConfidence": "",
        },
        "lfhf": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.lfhf),
          "vitalConfidence": "",
        },
        "hemoglobin": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.hemoglobin),
          "vitalConfidence": "",
        },
        "hemoglobinA1C": {
          "vitalValue": statusHelper.getVitalValue(
            VitalSignTypes.hemoglobinA1C,
          ),
          "vitalConfidence": "",
        },
        "highHemoglobinA1CRisk": {
          "vitalValue": statusHelper.getVitalValue(
            VitalSignTypes.highHemoglobinA1CRisk,
          ),
          "vitalConfidence": "",
        },
        "highBloodPressureRisk": {
          "vitalValue": statusHelper.getVitalValue(
            VitalSignTypes.highBloodPressureRisk,
          ),
          "vitalConfidence": "",
        },
        "ascvdRisk": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.ascvdRisk),
          "vitalConfidence": "",
        },
        "normalizedStressIndex": {
          "vitalValue": statusHelper.getVitalValue(
            VitalSignTypes.normalizedStressIndex,
          ),
          "vitalConfidence": "",
        },
        "heartAge": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.heartAge),
          "vitalConfidence": "",
        },
        "highTotalCholesterolRisk": {
          "vitalValue": statusHelper.getVitalValue(
            VitalSignTypes.highTotalCholesterolRisk,
          ),
          "vitalConfidence": "",
        },
        "highFastingGlucoseRisk": {
          "vitalValue": statusHelper.getVitalValue(
            VitalSignTypes.highFastingGlucoseRisk,
          ),
          "vitalConfidence": "",
        },
        "lowHemoglobinRisk": {
          "vitalValue": statusHelper.getVitalValue(
            VitalSignTypes.lowHemoglobinRisk,
          ),
          "vitalConfidence": "",
        },
      },
    };

    return binahData;
  }

  static List<String> weightList = List.generate(
    116,
    (index) => (index + 40).toString(),
  );
  static List<String> smokerTypeList = ["Smoker", "Non Smoker"];
  static List<String> heightList = List.generate(
    101,
    (index) => (index + 130).toString(),
  );

  final RegExp dateRegex = RegExp(r'^[0-9/]+$');
}
