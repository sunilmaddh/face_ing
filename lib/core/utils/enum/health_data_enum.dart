enum HealthDataEnum {
  wellnessScore(
    id: 1,
    name: "Wellness Score",
    description:
        "The Wellness Score is a prediction risk score that is used to predict a person's cardiovascular risk for the next 5 to 10 years.",
    unit: "unitless",
  ),
  breathingRate(
    id: 2,
    name: "Breathing Rate",
    description: "The number of breaths you take per minute.",
    unit: "rpm",
  ),
  pulseRate(
    id: 3,
    name: "Pulse Rate (Heart Rate)",
    description: "The number of times your heart beats per minute.",
    unit: "bpm",
  ),
  prq(
    id: 4,
    name: "PRQ",
    description:
        "The Pulse-Respiration Quotient (PRQ) is a measure of the ratio of a person’s pulse rate (measured in beats per minute) to their respiratory rate (measured in breaths per minute).",
    unit: "unitless",
  ),
  bloodPressureSystolic(
    id: 5,
    name: "Blood Pressure Systolic",
    description:
        "The pressure of blood is exerted on the walls of the arteries, which carry blood from the heart to other parts of the body.",
    unit: "mmHg",
  ),
  bloodPressureDiastolic(
    id: 6,
    name: "Blood Pressure Diastolic",
    description:
        "The pressure of blood is exerted on the walls of the arteries, which carry blood from the heart to other parts of the body.",
    unit: "mmHg",
  ),
  oxygenSaturation(
    id: 7,
    name: "Oxygen Saturation",
    description:
        "Oxygen Saturation, or SpO2, is a measure of how much oxygen the red blood cells are carrying from the lungs to the rest of the body.",
    unit: "%",
  ),
  hemoglobin(
    id: 8,
    name: "Hemoglobin",
    description:
        "Hemoglobin is a protein in a person’s red blood cells that carries oxygen to the human body's organs and tissues and transports carbon dioxide from your organs and tissues back to your lungs.",
    unit: "g/dL",
  ),
  hemoglobinA1C(
    id: 9,
    name: "Hemoglobin A1C",
    description:
        "Hemoglobin A1C (or HbA1c) represents the average blood glucose (sugar) level for the last two to three months.",
    unit: "%",
  ),
  ascvdRisk(
    id: 10,
    name: "ASCVD Risk",
    description:
        "ASCVD (Atherosclerotic Cardiovascular Disease) Risk estimates the likelihood of experiencing an atherosclerotic cardiovascular event within 10 years.",
    unit: "%",
  ),
  heartAge(
    id: 11,
    name: "Heart Age",
    description:
        "The Framingham Heart Age estimates the biological age of the heart based on risk factors and comparing it to an ideal healthy profile.",
    unit: "years",
  ),
  highBloodPressureRisk(
    id: 12,
    name: "High Blood Pressure Risk",
    description:
        "The High Blood Pressure Risk result indicates whether your blood pressure exceeds preset systolic/diastolic values.",
    unit: "unitless",
  ),
  highHbA1cRisk(
    id: 13,
    name: "High HbA1c Risk",
    description:
        "The High Hemoglobin A1c Risk (HbA1c) result indicates whether your Hemoglobin A1c level exceeds a preset threshold.",
    unit: "unitless",
  ),
  highFastingGlucoseRisk(
    id: 14,
    name: "High Fasting Glucose Risk",
    description:
        "The High Fasting Glucose Risk result indicates whether your glucose level exceeds a preset threshold after at least 8 hours of fasting.",
    unit: "unitless",
  ),
  highTotalCholesterolRisk(
    id: 15,
    name: "High Total Cholesterol Risk",
    description:
        "The High Total Cholesterol Risk result indicates whether your total cholesterol level exceeds a preset threshold.",
    unit: "unitless",
  ),
  lowHemoglobinRisk(
    id: 16,
    name: "Low Hemoglobin Risk",
    description:
        "The Low Hemoglobin Risk result indicates whether your hemoglobin level is below a preset threshold.",
    unit: "unitless",
  ),
  stressLevel(
    id: 17,
    name: "Stress Level",
    description: "The body's reaction to a challenge or demand.",
    unit: "unitless",
  ),
  stressIndex(
    id: 18,
    name: "Stress Index",
    description: "Stress is the body's reaction to a challenge or demand.",
    unit: "unitless",
  ),
  normalizedStressIndex(
    id: 19,
    name: "Normalized Stress Index",
    description:
        "The Normalized Stress Level is calculated from the Stress Index and scaled to a range of 0 to 100.",
    unit: "%",
  ),
  hrvSdnn(
    id: 20,
    name: "HRV SDNN",
    description:
        "SDNN is a calculated parameter of Heart Rate Variability (HRV) that represents the standard deviation of normal-to-normal R-R-intervals.",
    unit: "ms",
  ),
  meanRRi(
    id: 21,
    name: "Mean RRi",
    description:
        "Mean RRi is the average time between the RR intervals (RRi) in milliseconds.",
    unit: "ms",
  ),
  rmssd(
    id: 22,
    name: "RMSSD",
    description:
        "An important measure of the Heart Rate Variability. RMSSD is the root mean square of successive RR interval differences.",
    unit: "ms",
  ),
  recoveryAbility(
    id: 23,
    name: "Recovery Ability (PNS Zone)",
    description:
        "The Recovery Ability that is also known as “rest and digest'' response refers to the body’s ability to recover, accumulate energy, and regulate bodily functions after stressful occurrences.",
    unit: "unitless",
  ),
  pnsIndex(
    id: 24,
    name: "PNS Index",
    description:
        "The PNS Index calculation is based on the following three parameters: Mean RRi, RMSSD, and SD1, and is used to indicate the body’s Recovery Ability zones.",
    unit: "unitless",
  ),
  stressResponse(
    id: 25,
    name: "Stress Response (SNS Zone)",
    description:
        "The Stress Response, which is also known as “fight or flight” response, refers to a physiological reaction to imminent danger that occurs when we are scared, anxious, stressed, attacked, or threatened.",
    unit: "unitless",
  ),
  snsIndex(
    id: 26,
    name: "SNS Index",
    description:
        "The SNS index is calculated based on the following three parameters: Heart Rate, Baevsky’s stress index, SD2, and is used to set the stress response zone.",
    unit: "unitless",
  ),
  sd1(
    id: 27,
    name: "SD1",
    description:
        "SD1 is a poincaré plot standard deviation perpendicular to the line of identity.",
    unit: "ms",
  ),
  sd2(
    id: 28,
    name: "SD2",
    description:
        "SD2 is a poincaré plot standard deviation along the line of identity.",
    unit: "ms",
  ),
  lfHf(
    id: 29,
    name: "LF/HF",
    description:
        "LF and HF stand for Low-Frequency and High-Frequency bands, which represent the Sympathetic and Parasympathetic activity, respectively.",
    unit: "unitless",
  ),
  rriData(
    id: 30,
    name: "RRi Data",
    description:
        "The RR interval is the time between the \"R\" peaks of successive heartbeats, in milliseconds.",
    unit: "ms",
  );

  const HealthDataEnum({
    required this.id,
    required this.name,
    required this.unit,
    required this.description,
  });

  final int id;
  final String name;
  final String unit;
  final String description;
}
