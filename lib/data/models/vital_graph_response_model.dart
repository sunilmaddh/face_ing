class VitalGraphResponseModel {
  String? dateRange;
  Wellness? wellness;
  Wellness? vitalSigns;
  Wellness? hemoglobin;
  Wellness? risk;
  Wellness? stress;
  Wellness? hRVSDNN;
  Wellness? zoneIndex;
  String? msg;
  String? success;

  VitalGraphResponseModel({
    this.dateRange,
    this.wellness,
    this.vitalSigns,
    this.hemoglobin,
    this.risk,
    this.stress,
    this.hRVSDNN,
    this.zoneIndex,
    this.msg,
    this.success,
  });

  VitalGraphResponseModel.fromJson(Map<String, dynamic> json) {
    dateRange = json['dateRange'];
    wellness =
        json['Wellness'] != null
            ? new Wellness.fromJson(json['Wellness'])
            : null;
    vitalSigns =
        json['Vital Signs'] != null
            ? new Wellness.fromJson(json['Vital Signs'])
            : null;
    hemoglobin =
        json['Hemoglobin'] != null
            ? new Wellness.fromJson(json['Hemoglobin'])
            : null;
    risk = json['Risk'] != null ? new Wellness.fromJson(json['Risk']) : null;
    stress =
        json['Stress'] != null ? new Wellness.fromJson(json['Stress']) : null;
    hRVSDNN =
        json['HRV SDNN'] != null
            ? new Wellness.fromJson(json['HRV SDNN'])
            : null;
    zoneIndex =
        json['Zone Index'] != null
            ? new Wellness.fromJson(json['Zone Index'])
            : null;
    msg = json['msg'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dateRange'] = this.dateRange;
    if (this.wellness != null) {
      data['Wellness'] = this.wellness!.toJson();
    }
    if (this.vitalSigns != null) {
      data['Vital Signs'] = this.vitalSigns!.toJson();
    }
    if (this.hemoglobin != null) {
      data['Hemoglobin'] = this.hemoglobin!.toJson();
    }
    if (this.risk != null) {
      data['Risk'] = this.risk!.toJson();
    }
    if (this.stress != null) {
      data['Stress'] = this.stress!.toJson();
    }
    if (this.hRVSDNN != null) {
      data['HRV SDNN'] = this.hRVSDNN!.toJson();
    }
    if (this.zoneIndex != null) {
      data['Zone Index'] = this.zoneIndex!.toJson();
    }
    data['msg'] = this.msg;
    data['success'] = this.success;
    return data;
  }
}

class Wellness {
  List<String>? vitalType;
  List<VitalTypeDetails>? vitalTypeDetails;
  Wellness({this.vitalType, this.vitalTypeDetails});
  Wellness.fromJson(Map<String, dynamic> json) {
    vitalType = json['vitalType'].cast<String>();
    if (json['vitalTypeDetails'] != null) {
      vitalTypeDetails = <VitalTypeDetails>[];
      json['vitalTypeDetails'].forEach((v) {
        vitalTypeDetails!.add(new VitalTypeDetails.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vitalType'] = this.vitalType;
    if (this.vitalTypeDetails != null) {
      data['vitalTypeDetails'] =
          this.vitalTypeDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VitalTypeDetails {
  List<String>? xValues;
  List<HealthList>? healthList;
  List<String>? yValues;
  VitalTypeDetails({this.xValues, this.healthList, this.yValues});
  VitalTypeDetails.fromJson(Map<String, dynamic> json) {
    xValues = json['xValues'].cast<String>();
    if (json['healthList'] != null) {
      healthList = <HealthList>[];
      json['healthList'].forEach((v) {
        healthList!.add(new HealthList.fromJson(v));
      });
    }
    yValues = json['yValues'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['xValues'] = this.xValues;
    if (this.healthList != null) {
      data['healthList'] = this.healthList!.map((v) => v.toJson()).toList();
    }
    data['yValues'] = this.yValues;
    return data;
  }
}

class HealthList {
  String? value;
  String? scannedDate;

  HealthList({this.value, this.scannedDate});

  HealthList.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    scannedDate = json['scannedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['scannedDate'] = this.scannedDate;
    return data;
  }
}
