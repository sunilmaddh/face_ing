import 'package:flutter/material.dart';

class AppConstents {
  static const String
  commonFont = "Manrope",
  login = "Login",
  resetPassword = "Reset Password",
  confirm = "Confirm",
  email = "Email",
  password = "Password",
  confirmPassword = "Confirm Password",
  emailHint = "Please enter email",
  passHint = "Please enter password",
  confPassHint = "Please re-enter password",
  forgotPassword = "Forgot password?",
  donThaveAccoount = "Don’t have account?",
  signUp = "Sigup",
  gilroyBold = "Gilroy-Bold",
  gilroyMedium = "Gilroy-Medium",
  statusCode = "statusCode",
  response = "responseBody",
  upload = "Upload",
  scanId = "Scan Id",
  dateTime = "Date & Time",
  continueBtn = "Continue",
  uploadPhotoHeading = "Upload photo for creating you account",
  name = "Name",
  confidenceLevelDiscription =
      "The confidence level of a vital sign indicates the probability of accuracy of the measurement result for that vital sign. The higher the level, the greater the probability and accuracy of the result. The confidence level takes into consideration all the inputs required to calculate a result, including signal quality, any warnings during the measurement duration, and the specific data required for the vital sign, such as the amount of information needed to measure a result.",
  gender = 'Gender',
  dob = 'Date of Birth',
  weight = "Weight (kg)",
  height = "Height (cm)",
  selectVital = "Select Vital",
  message =
      "This application is not a medical device. Measurement results cannot be used for the diagnosis, treatment or prevention of disease. If you are unsure about your health, please use medical equipment to measure the exact value.",
  congractText = " Congratulation! Your Account created successfully. ",
  congractDis =
      " We are thrilled to extend a warm welcome to all newcomers and returning members alike. ",
  male = "Male",
  female = "Female",
  scanDiscri = "Measurement will start please hold face in the frame",
  notDiscription =
      "Kindly make sure your battery is above 20% and Power Saving Mode is disabled before starting.",
  createAccount = 'Create Account',
  networkErroMessage =
      "We’re having trouble connecting to the server. Please check your internet connection and try again.",
  termMeassaga =
      "Accept to the legal terms by clicking on the check box to be able to provide services";
  static const String breathingRate = 'Breathing Rate';
  static const String pulseRate = 'Pulse Rate (Heart Rate)';
  static const String prq = 'PRQ';
  static const String bloodPressure = 'Blood Pressure';
  static const String bloodPressureSystolic = 'Blood Pressure Systolic';
  static const String bloodPressureDiastolic = 'Blood Pressure Diastolic';
  static const String oxygenSaturation = 'Oxygen Saturation';
  static const String hemoglobin = 'Hemoglobin';
  static const String hemoglobinA1C = 'Hemoglobin A1C';
  static const String ascvdRisk = 'ASCVD Risk';
  static const String heartAge = 'Heart Age';
  static const String highBloodPressureRisk = 'High Blood Pressure Risk';
  static const String highHbA1cRisk = 'High HbA1c Risk';
  static const String highFastingGlucoseRisk = 'High Fasting Glucose Risk';
  static const String highTotalCholesterolRisk = 'High Total Cholesterol Risk';
  static const String lowHemoglobinRisk = 'Low Hemoglobin Risk';
  static const String stressLevel = 'Stress Level';
  static const String stressIndex = 'Stress Index';
  static const String normalizedStressIndex = 'Normalized Stress Index';
  static const String hrvSdnn = 'HRV SDNN';
  static const String meanRRi = 'Mean RRi';
  static const String rmssd = 'RMSSD';
  static const String recoveryAbility = 'Recovery Ability (PNS Zone)';
  static const String pnsIndex = 'PNS Index';
  static const String stressResponse = 'Stress Response (SNS Zone)';
  static const String snsIndex = 'SNS Index';
  static const String sd1 = 'SD1';
  static const String sd2 = 'SD2';
  static const String lfHf = 'LF/HF';
  static const String rriData = 'RRi Data';
  static Size deviceSize = Size(375, 812);
}

class WellnessMetricHeading {
  static const String wellnessScore = 'Your Wellness Score is';
  static const String breathingRate = 'Your Breathing Rate is';
  static const String pulseRate = 'Your Pulse Rate (Heart Rate) is';
  static const String prq = 'Your PRQ is';
  static const String bloodPressureSystolic = 'Your Blood Pressure Systolic is';
  static const String bloodPressureDiastolic =
      'Your Blood Pressure Diastolic is';
  static const String oxygenSaturation = 'Your Oxygen Saturation is';
  static const String hemoglobin = 'Your Hemoglobin is';
  static const String hemoglobinA1C = 'Your Hemoglobin A1C is';
  static const String ascvdRisk = 'Your ASCVD Risk is';
  static const String heartAge = 'Your Heart Age is';
  static const String highBloodPressureRisk =
      'Your High Blood Pressure Risk is';
  static const String highHbA1cRisk = 'Your High HbA1c Risk is';
  static const String highFastingGlucoseRisk =
      'Your High Fasting Glucose Risk is';
  static const String highTotalCholesterolRisk =
      'Your High Total Cholesterol Risk is';
  static const String lowHemoglobinRisk = 'Your Low Hemoglobin Risk is';
  static const String stressLevel = 'Your Stress Level is';
  static const String stressIndex = 'Your Stress Index is';
  static const String normalizedStressIndex = 'Your Normalized Stress Index is';
  static const String hrvSdnn = 'Your HRV SDNN is';
  static const String meanRRi = 'Your Mean RRi Rate is';
  static const String rmssd = 'Your RMSSD is';
  static const String recoveryAbility = 'Your Recovery Ability (PNS Zone) is';
  static const String pnsIndex = 'Your PNS Index is';
  static const String stressResponse =
      'Your Stress Response (SNS Zone) Index is';
  static const String snsIndex = 'Your SNS Index is';
  static const String sd1 = 'Your SD1 Index is';
  static const String sd2 = 'Your SD2 Index is';
  static const String lfHf = 'Your LF/HF Index is';
  static const String rriData = 'Your RRi Data Index is';

  static const List<String> all = [
    wellnessScore,
    breathingRate,
    pulseRate,
    prq,
    bloodPressureSystolic,
    bloodPressureDiastolic,
    oxygenSaturation,
    hemoglobin,
    hemoglobinA1C,
    ascvdRisk,
    heartAge,
    highBloodPressureRisk,
    highHbA1cRisk,
    highFastingGlucoseRisk,
    highTotalCholesterolRisk,
    lowHemoglobinRisk,
    stressLevel,
    stressIndex,
    normalizedStressIndex,
    hrvSdnn,
    meanRRi,
    rmssd,
    recoveryAbility,
    pnsIndex,
    stressResponse,
    snsIndex,
    sd1,
    sd2,
    lfHf,
    rriData,
  ];
}

class WellnessMetrics {
  static const String wellnessScore = 'Wellness Score';
  static const String breathingRate = 'Breathing Rate';
  static const String pulseRate = 'Pulse Rate (Heart Rate)';
  static const String prq = 'PRQ';
  static const String bloodPressureSystolic = 'Blood Pressure Systolic';
  static const String bloodPressureDiastolic = 'Blood Pressure Diastolic';
  static const String oxygenSaturation = 'Oxygen Saturation';
  static const String hemoglobin = 'Hemoglobin';
  static const String hemoglobinA1C = 'Hemoglobin A1C';
  static const String ascvdRisk = 'ASCVD Risk';
  static const String heartAge = 'Heart Age';
  static const String highBloodPressureRisk = 'High Blood Pressure Risk';
  static const String highHbA1cRisk = 'High HbA1c Risk';
  static const String highFastingGlucoseRisk = 'High Fasting Glucose Risk';
  static const String highTotalCholesterolRisk = 'High Total Cholesterol Risk';
  static const String lowHemoglobinRisk = 'Low Hemoglobin Risk';
  static const String stressLevel = 'Stress Level';
  static const String stressIndex = 'Stress Index';
  static const String normalizedStressIndex = 'Normalized Stress Index';
  static const String hrvSdnn = 'HRV SDNN';
  static const String meanRRi = 'Mean RRi';
  static const String rmssd = 'RMSSD';
  static const String recoveryAbility = 'Recovery Ability (PNS Zone)';
  static const String pnsIndex = 'PNS Index';
  static const String stressResponse = 'Stress Response (SNS Zone)';
  static const String snsIndex = 'SNS Index';
  static const String sd1 = 'SD1';
  static const String sd2 = 'SD2';
  static const String lfHf = 'LF/HF';
  static const String rriData = 'RRi Data';

  static const List<String> all = [
    wellnessScore,
    breathingRate,
    pulseRate,
    prq,
    bloodPressureSystolic,
    bloodPressureDiastolic,
    oxygenSaturation,
    hemoglobin,
    hemoglobinA1C,
    ascvdRisk,
    heartAge,
    highBloodPressureRisk,
    highHbA1cRisk,
    highFastingGlucoseRisk,
    highTotalCholesterolRisk,
    lowHemoglobinRisk,
    stressLevel,
    stressIndex,
    normalizedStressIndex,
    hrvSdnn,
    meanRRi,
    rmssd,
    recoveryAbility,
    pnsIndex,
    stressResponse,
    snsIndex,
    sd1,
    sd2,
    lfHf,
    rriData,
  ];
}

class WellnessMetricDescriptionsLong {
  static const String wellnessScore =
      'The Wellness Score is a prediction risk score that is used to predict a person\'s cardiovascular risk for the next 5 to 10 years.';
  static const String breathingRate =
      'The number of breaths you take per minute.';
  static const String pulseRate =
      'The number of times your heart beats per minute.';
  static const String prq =
      'The Pulse-Respiration Quotient (PRQ) is a measure of the ratio of a person’s pulse rate (measured in beats per minute) to their respiratory rate (measured in breaths per minute).';
  static const String bpSystolic =
      'The pressure of blood is exerted on the walls of the arteries, which carry blood from the heart to other parts of the body.';
  static const String bpDiastolic =
      'The pressure of blood is exerted on the walls of the arteries, which carry blood from the heart to other parts of the body.';
  static const String oxygenSaturation =
      'Oxygen Saturation, or SpO2, is a measure of how much oxygen the red blood cells are carrying from the lungs to the rest of the body.';
  static const String hemoglobin =
      'Hemoglobin is a protein in a person’s red blood cells that carries oxygen to the human body\'s organs and tissues and transports carbon dioxide from your organs and tissues back to your lungs.';
  static const String hemoglobinA1C =
      'Hemoglobin A1C (or HbA1c) represents the average blood glucose (sugar) level for the last two to three months.';
  static const String ascvdRisk =
      'ASCVD (Atherosclerotic Cardiovascular Disease) Risk estimates the likelihood of experiencing an atherosclerotic cardiovascular event within 10 years.';
  static const String heartAge =
      'The Framingham Heart Age estimates the biological age of the heart based on risk factors and comparing it to an ideal healthy profile.';
  static const String highBloodPressureRisk =
      'The High Blood Pressure Risk result indicates whether your blood pressure exceeds preset systolic/diastolic values.';
  static const String highHbA1cRisk =
      'The High Hemoglobin A1c Risk (HbA1c) result indicates whether your Hemoglobin A1c level exceeds a preset threshold.';
  static const String highFastingGlucoseRisk =
      'The High Fasting Glucose Risk result indicates whether your glucose level exceeds a preset threshold after at least 8 hours of fasting.';
  static const String highTotalCholesterolRisk =
      'The High Total Cholesterol Risk result indicates whether your total cholesterol level exceeds a preset threshold.';
  static const String lowHemoglobinRisk =
      'The Low Hemoglobin Risk result indicates whether your hemoglobin level is below a preset threshold.';
  static const String stressLevel =
      'The body\'s reaction to a challenge or demand.';
  static const String stressIndex =
      'Stress is the body\'s reaction to a challenge or demand.';
  static const String normalizedStressIndex =
      'The Normalized Stress Level is calculated from the Stress Index and scaled to a range of 0 to 100.';
  static const String hrvSDNN =
      'SDNN is a calculated parameter of Heart Rate Variability (HRV) that represents the standard deviation of normal-to-normal R-R-intervals.';
  static const String meanRRi =
      'Mean RRi is the average time between the RR intervals (RRi) in milliseconds.';
  static const String rmssd =
      'An important measure of the Heart Rate Variability. RMSSD is the root mean square of successive RR interval differences.';
  static const String recoveryAbility =
      'The Recovery Ability that is also known as “rest and digest" response refers to the body’s ability to recover, accumulate energy, and regulate bodily functions after stressful occurrences.';
  static const String pnsIndex =
      'The PNS Index calculation is based on the following three parameters: Mean RRi, RMSSD, and SD1, and is used to indicate the body’s Recovery Ability zones.';
  static const String stressResponse =
      'The Stress Response, which is also known as “fight or flight” response, refers to a physiological reaction to imminent danger that occurs when we are scared, anxious, stressed, attacked, or threatened.';
  static const String snsIndex =
      'The SNS index is calculated based on the following three parameters: Heart Rate, Baevsky’s stress index, SD2, and is used to set the stress response zone.';
  static const String sd1 =
      'SD1 is a poincaré plot standard deviation perpendicular to the line of identity.';
  static const String sd2 =
      'SD2 is a poincaré plot standard deviation along the line of identity.';
  static const String lfHf =
      'LF and HF stand for Low-Frequency and High-Frequency bands, which represent the Sympathetic and Parasympathetic activity, respectively.';
  static const String rriData =
      'The RR interval is the time between the "R" peaks of successive heartbeats, in milliseconds.';
}
