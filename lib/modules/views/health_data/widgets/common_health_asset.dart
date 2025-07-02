import 'package:ntt_data/core/constants/app_assets.dart';

class CommonHealthAsset {
  String getWellnessAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'high':
        return AppAssets.goodAsset;
      case 'medium':
        return AppAssets.mediumAsset;
      default:
        return AppAssets.lowAsset;
    }
  }

  String getBreathingRateAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'normal':
        return AppAssets.goodAsset;
      case 'high':
        return AppAssets.mediumAsset;
      case 'low':
        return AppAssets.mediumAsset;
      default:
        return AppAssets.mediumAsset;
    }
  }

  String getPulseRateAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'normal':
        return AppAssets.goodAsset; // marked Bad
      case 'high':
        return AppAssets.mediumAsset;
      case 'low':
        return AppAssets.mediumAsset;
      default:
        return AppAssets.mediumAsset;
    }
  }

  String getPrqAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'medium':
        return AppAssets.goodAsset;
      case 'high':
        return AppAssets.mediumAsset;
      default:
        return AppAssets.mediumAsset;
    }
  }

  String getSystolicBPAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'high':
        return AppAssets.lowAsset;
      case 'normal':
        return AppAssets.goodAsset;
      case 'low':
        return AppAssets.mediumAsset;

      default:
        return AppAssets.mediumAsset;
    }
  }

  String getDiastolicBPAsset(String vitalStatus) {
    return AppAssets.lowAsset; // Ask Binah, default
  }

  String getOxygenSaturationAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'low':
        return AppAssets.lowAsset;
      case 'normal':
        return AppAssets.goodAsset;
      default:
        return AppAssets.goodAsset;
    }
  }

  String getHemoglobinAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'medium':
        return AppAssets.goodAsset;
      case 'normal':
        return AppAssets.goodAsset;
      case 'high':
        return AppAssets.mediumAsset;
      case 'low':
        return AppAssets.mediumAsset;
      default:
        return AppAssets.mediumAsset;
    }
  }

  String getHbA1cAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'high':
        return AppAssets.lowAsset; // Green for Normal
      case 'medium':
        return AppAssets.mediumAsset; // Yellow for Prediabetes risk
      case 'low':
      default:
        return AppAssets.goodAsset; // Red for Diabetes risk
    }
  }

  String getAscvdRiskAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'low':
        return AppAssets.goodAsset;
      case 'normal':
        return AppAssets.mediumAsset;
      case 'high':
        return AppAssets.lowAsset;
      default:
        return AppAssets.lowAsset;
    }
  }

  String getHeartAgeAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'low':
        return AppAssets.goodAsset;
      case 'medium':
        return AppAssets.mediumAsset;
      default:
        return AppAssets.lowAsset;
    }
  }

  String gethighBPRiskAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'low':
        return AppAssets.goodAsset;
      case 'hight':
        return AppAssets.lowAsset;
      default:
        return AppAssets.mediumAsset;
    }
  }

  String gethighHbA1cRiskAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'low':
        return AppAssets.goodAsset;
      default:
        return AppAssets.lowAsset;
    }
  }

  String gethighFastingGlucoseRiskAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'low':
        return AppAssets.goodAsset;
      default:
        return AppAssets.lowAsset;
    }
  }

  String gethighCholesterolRiskAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'low':
        return AppAssets.goodAsset;
      case 'medium':
        return AppAssets.mediumAsset;
      default:
        return AppAssets.lowAsset;
    }
  }

  String getLowHemoglobinRiskAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'low':
        return AppAssets.goodAsset;
      case 'medium':
        return AppAssets.mediumAsset;
      default:
        return AppAssets.lowAsset;
    }
  }

  String getStressLevelAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'low':
        return AppAssets.goodAsset;
      case 'normal':
        return AppAssets.lighthigh;
      case 'mild':
        return AppAssets.mediumAsset;
      case 'veryhigh':
        return AppAssets.lowAsset;
      case 'high':
        return AppAssets.orengeAsset;
      default:
        return AppAssets.goodAsset;
    }
  }

  String getStressIndexAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'low':
        return AppAssets.goodAsset;
      case 'medium':
        return AppAssets.mediumAsset;
      case 'high':
      case 'Very high':
        return AppAssets.lowAsset;
      default:
        return AppAssets.goodAsset;
    }
  }

  String getmediumizedStressIndexAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'Mild':
        return AppAssets.mediumAsset;
      case 'low':
        return AppAssets.goodAsset;
      case 'Normal':
        return AppAssets.lighthigh;
      case 'High':
        return AppAssets.orengeAsset;
      case 'Very High':
        return AppAssets.lowAsset;

      default:
        return AppAssets.lowAsset;
    }
  }

  String getHrvSdnnAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'Normal':
        return AppAssets.goodAsset;
      case 'low':
        return AppAssets.lowAsset;
      case 'high':
        return AppAssets.goodAsset;
      default:
        return AppAssets.goodAsset;
    }
  }

  String getMeanRRiAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'Normal':
        return AppAssets.mediumAsset;
      case 'high':
        return AppAssets.goodAsset;
      default:
        return AppAssets.lowAsset;
    }
  }

  String getRmssdAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'Normal':
        return AppAssets.mediumAsset;
      case 'high':
        return AppAssets.goodAsset;
      case 'low':
        return AppAssets.lowAsset;
      default:
        return AppAssets.lowAsset;
    }
  }

  String getRecoveryAbilityAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'medium':
        return AppAssets.mediumAsset;
      case 'high':
        return AppAssets.goodAsset;
      default:
        return AppAssets.lowAsset;
    }
  }

  String getPnsIndexAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'low':
        return AppAssets.lowAsset;
      case 'normal':
        return AppAssets.mediumAsset;
      case 'high':
        return AppAssets.goodAsset;
      default:
        return AppAssets.lowAsset;
    }
  }

  String getSnsResponseAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'medium':
        return AppAssets.mediumAsset;
      case 'high':
        return AppAssets.lowAsset;
      default:
        return AppAssets.goodAsset;
    }
  }

  String getSnsIndexAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'low':
        return AppAssets.goodAsset;
      case 'medium':
        return AppAssets.mediumAsset;
      case 'Normal':
        return AppAssets.mediumAsset;
      default:
        return AppAssets.lowAsset;
    }
  }

  String getSD1Asset(String vitalStatus) {
    return AppAssets.lowAsset; // Ask Binah
  }

  String getSD2Asset() {
    return AppAssets.lowAsset; // Ask Binah
  }

  String getLfHfAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'medium':
        return AppAssets.mediumAsset;
      case 'high':
        return AppAssets.goodAsset;
      default:
        return AppAssets.lowAsset;
    }
  }

  String getRRiDataAsset() {
    return AppAssets.lowAsset; // Ask Binah
  }
}
