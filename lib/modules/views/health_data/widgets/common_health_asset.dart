import 'package:ntt_data/core/constants/app_assets.dart';

class CommonHealthAsset {
  String getWellnessAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'high':
        return AppAssets.veryHighImage;
      case 'medium':
        return AppAssets.mediumImage;
      default:
        return AppAssets.veryLowImage;
    }
  }

  String getBreathingRateAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'normal':
        return AppAssets.veryHighImage;
      case 'high':
        return AppAssets.mediumImage;
      case 'low':
        return AppAssets.mediumImage;
      default:
        return AppAssets.mediumImage;
    }
  }

  String getPulseRateAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'normal':
        return AppAssets.veryHighImage; // marked Bad
      case 'high':
        return AppAssets.mediumImage;
      case 'low':
        return AppAssets.mediumImage;
      default:
        return AppAssets.mediumImage;
    }
  }

  String getPrqAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'normal':
        return AppAssets.veryHighImage;
      case 'high':
        return AppAssets.mediumImage;
      default:
        return AppAssets.mediumImage;
    }
  }

  String getSystolicBPAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'high':
        return AppAssets.veryLowImage;
      case 'normal':
        return AppAssets.veryHighImage;
      case 'low':
        return AppAssets.mediumImage;

      default:
        return AppAssets.mediumImage;
    }
  }

  String getDiastolicBPAsset(String vitalStatus) {
    return AppAssets.veryLowImage; // Ask Binah, default
  }

  String getOxygenSaturationAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'low':
        return AppAssets.veryLowImage;
      case 'normal':
        return AppAssets.veryHighImage;
      default:
        return AppAssets.veryHighImage;
    }
  }

  String getHemoglobinAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'medium':
        return AppAssets.veryHighImage;
      case 'normal':
        return AppAssets.veryHighImage;
      case 'high':
        return AppAssets.mediumImage;
      case 'low':
        return AppAssets.mediumImage;
      default:
        return AppAssets.mediumImage;
    }
  }

  String getHbA1cAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'high':
        return AppAssets.veryLowImage; // Green for Normal
      case 'medium':
        return AppAssets.mediumImage; // Yellow for Prediabetes risk
      case 'low':
      default:
        return AppAssets.veryHighImage; // Red for Diabetes risk
    }
  }

  String getAscvdRiskAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'low':
        return AppAssets.veryHighImage;
      case 'normal':
        return AppAssets.mediumImage;
      case 'high':
        return AppAssets.veryLowImage;
      default:
        return AppAssets.veryLowImage;
    }
  }

  String getHeartAgeAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'low':
        return AppAssets.veryHighImage;
      case 'medium':
        return AppAssets.mediumImage;
      default:
        return AppAssets.veryLowImage;
    }
  }

  String gethighBPRiskAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'low':
        return AppAssets.veryHighImage;
      case 'hight':
        return AppAssets.veryLowImage;
      default:
        return AppAssets.mediumImage;
    }
  }

  String gethighHbA1cRiskAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'low':
        return AppAssets.veryHighImage;
      default:
        return AppAssets.veryLowImage;
    }
  }

  String gethighFastingGlucoseRiskAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'low':
        return AppAssets.veryHighImage;
      default:
        return AppAssets.veryLowImage;
    }
  }

  String gethighCholesterolRiskAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'low':
        return AppAssets.veryHighImage;
      case 'medium':
        return AppAssets.mediumImage;
      default:
        return AppAssets.veryLowImage;
    }
  }

  String getLowHemoglobinRiskAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'low':
        return AppAssets.veryHighImage;
      case 'medium':
        return AppAssets.mediumImage;
      default:
        return AppAssets.veryLowImage;
    }
  }

  String getStressLevelAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'low':
        return AppAssets.veryHighImage;
      case 'normal':
        return AppAssets.lighthigh;
      case 'mild':
        return AppAssets.mediumImage;
      case 'veryhigh':
        return AppAssets.veryLowImage;
      case 'high':
        return AppAssets.lowImage;
      case 'extreme':
        return AppAssets.veryLowImage;
      default:
        return AppAssets.veryHighImage;
    }
  }

  String getStressIndexAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'low':
        return AppAssets.veryHighImage;
      case 'medium':
        return AppAssets.mediumImage;
      case 'high':
      case 'very high':
        return AppAssets.veryLowImage;
      default:
        return AppAssets.veryHighImage;
    }
  }

  String getmediumizedStressIndexAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'mild':
        return AppAssets.mediumImage;
      case 'low':
        return AppAssets.veryHighImage;
      case 'normal':
        return AppAssets.lighthigh;
      case 'high':
        return AppAssets.lowImage;
      case 'very high':
        return AppAssets.veryLowImage;

      default:
        return AppAssets.veryLowImage;
    }
  }

  String getHrvSdnnAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'normal':
        return AppAssets.veryHighImage;
      case 'low':
        return AppAssets.veryLowImage;
      case 'high':
        return AppAssets.veryHighImage;
      default:
        return AppAssets.veryHighImage;
    }
  }

  String getMeanRRiAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'normal':
        return AppAssets.mediumImage;
      case 'high':
        return AppAssets.veryHighImage;
      default:
        return AppAssets.veryLowImage;
    }
  }

  String getRmssdAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'normal':
        return AppAssets.mediumImage;
      case 'high':
        return AppAssets.veryHighImage;
      case 'low':
        return AppAssets.veryLowImage;
      default:
        return AppAssets.veryLowImage;
    }
  }

  String getRecoveryAbilityAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'medium':
        return AppAssets.mediumImage;
      case 'high':
        return AppAssets.veryHighImage;
      default:
        return AppAssets.veryLowImage;
    }
  }

  String getPnsIndexAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'low':
        return AppAssets.veryLowImage;
      case 'normal':
        return AppAssets.mediumImage;
      case 'high':
        return AppAssets.veryHighImage;
      default:
        return AppAssets.veryLowImage;
    }
  }

  String getSnsResponseAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'medium':
        return AppAssets.mediumImage;
      case 'high':
        return AppAssets.veryLowImage;
      default:
        return AppAssets.veryHighImage;
    }
  }

  String getSnsIndexAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'low':
        return AppAssets.veryHighImage;
      case 'medium':
        return AppAssets.mediumImage;
      case 'Normal':
        return AppAssets.mediumImage;
      default:
        return AppAssets.veryLowImage;
    }
  }

  String getSD1Asset(String vitalStatus) {
    return AppAssets.veryLowImage; // Ask Binah
  }

  String getSD2Asset() {
    return AppAssets.veryLowImage; // Ask Binah
  }

  String getLfHfAsset(String vitalStatus) {
    switch (vitalStatus) {
      case 'normal':
        return AppAssets.mediumImage;
      case 'high':
        return AppAssets.veryHighImage;
      default:
        return AppAssets.veryLowImage;
    }
  }

  String getRRiDataAsset() {
    return AppAssets.veryLowImage; // Ask Binah
  }
}
