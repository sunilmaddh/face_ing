/*
 *              Copyright (c) 2016-2023, Nuralogix Corp.
 *                      All Rights reserved
 *
 *      THIS SOFTWARE IS LICENSED BY AND IS THE CONFIDENTIAL AND
 *      PROPRIETARY PROPERTY OF NURALOGIX CORP. IT IS
 *      PROTECTED UNDER THE COPYRIGHT LAWS OF THE USA, CANADA
 *      AND OTHER FOREIGN COUNTRIES. THIS SOFTWARE OR ANY
 *      PART THEREOF, SHALL NOT, WITHOUT THE PRIOR WRITTEN CONSENT
 *      OF NURALOGIX CORP, BE USED, COPIED, DISCLOSED,
 *      DECOMPILED, DISASSEMBLED, MODIFIED OR OTHERWISE TRANSFERRED
 *      EXCEPT IN ACCORDANCE WITH THE TERMS AND CONDITIONS OF A
 *      NURALOGIX CORP SOFTWARE LICENSE AGREEMENT.
 */

package com.example.ntt_data.utils

internal const val KEY_DEVICE_TOKEN = "ai.nuralogix.anurasdk.sample.deviceToken"
internal const val KEY_DEVICE_REFRESH_TOKEN = "ai.nuralogix.anurasdk.sample.deviceRefreshToken"
internal const val KEY_STUDY_HASH = "ai.nuralogix.anurasdk.sample.studyHash"
internal const val KEY_DFX_EXTRACTION_LIBRARY_STUDY_CONFIG = "ai.nuralogix.anurasdk.sample.studyFile"
internal const val KEY_MEASUREMENT_RESULTS = "ai.nuralogix.anurasdk.sample.MeasurementResults"
internal  const val general_health_des="Wellness Score is a measure of the subject's overall health."
//    "The Wellness Score is a prediction risk score that is used to predict a person's cardiovascular risk for the next 5 to 10 years. "
internal  const val BREATHIN_RATW_DIS="Breathing Rate (Respiration Rate) corresponds to the number of times the user inhales and exhales, expressed as a rate per minute."
internal const val HEART_RATE="Face.ing estimate of the subject's Pulse Rate. It is based on analyzing facial blood-flow data (TOI)."
internal const val BLOOD_PRESSURE="The pressure of blood is exerted on the walls of the arteries, which carry blood from the heart to other parts of the body. "
internal const val BLOOD_PRESSURE_SY_DIS="Face.ing estimate of the subject's Systolic Blood Pressure. It is based on analyzing facial blood-flow data (TOI)."
internal  const val BLOOD_PRESSURE_DI_DIS="Face.ing estimate of the subject's Diastolic Blood Pressure. It is based on analyzing facial blood-flow data (TOI)."
internal  const val  IRREGULAR_HEART_DIS="Face.ing estimate of the number of Irregular Heartbeats detected for the subject in 30 seconds. It is based on analyzing facial blood-flow data (TOI)."
internal const val HEMOGLOBIN_A1_DIS="Hemoglobin A1C Risk corresponds to the percentage of people with the subjects's risk profile who had their HbA1c levels above 5.7% when tested, indicating an elevated risk of prediabetes."
internal const val FASTING_GLUCOSE_RISK_DIS="Fasting Blood Glucose Risk corresponds to the percentage of people with the subjects's risk profile."
internal const val CARD_DISEA_RISK_DIS="Cardiovascular Disease Risk is subject's likelihood of experiencing their first heart attack or stroke within the next 10 years, expressed as a percentage."
internal  const val HEART_ATTACK_RISK_DIS="" +
        "Heart Attack Risk is subject's likelihood of experiencing their first heart attack within the next 10 years, expressed as a percentage."
internal  const val STROKE_RISK_DIS="Stroke Risk is subject's likelihood of experiencing their first stroke within the next 10 years, expressed as a percentage."
internal const val  TYPE_DIAB_RISK_DIS="Type 2 Diabetes Risk corresponds to the percentage of people with the subject's risk profile who are diagnosed with Type 2 Diabetes by their doctor."
internal const val FATTY_LIV_DIA_RISK_DIS="Fatty Liver Disease Risk corresponds to the percentage of people with the subject's risk profile who are diagnosed with fatty liver disease. "
internal  const val HYPERCHOLE_EMIA_RISK_DIS="Hypercholesterolemia Risk corresponds to the percentage of people with the subjects's risk profile who have abnormally high cholesterol levels."
internal const val HYPERTENTION_RISK_DIS="Hypertension Risk corresponds to the percentage of people with the subject's risk profile who are diagnosed with hypertension (high blood pressure) by their doctor."
internal const val OVERALL_METABOLIC_HEALTH_RISK_DIS="Overall Metabolic Health Risk is the Face.ing estimate of the subject's Overall Metabolic Health Risk."
internal const val HYPERTRIGLY_EMIA_RISK_DIS="Hypertriglyceridemia Risk corresponds to the percentage of people with the subjects's risk profile who have abnormally high triglyceride levels (above 1.7 mmol/L or 150 mg/dL)."
internal const val MENTAL_SCORE_DIS="The Face.ing estimate of the subject's Mental Stress. It is a proprietary score that quantifies the user's mental stress level on a 5-point scale, from relaxed (Level 1) to overloaded (Level 5)."
internal const val PHYSICAL_SCORE_DIS="General Wellness Score is a measure of the subject's overall health."
internal const val PHYSIOLOGICAL_SCORE_DIS="General Wellness Score is a measure of the subject's overall health."
internal const val RISK_SCORE_DIS="General Wellness Score is a measure of the subject's overall health."
internal const val VITAL_SCORE_DIS="General Wellness Score is a measure of the subject's overall health."
internal  const val MENNTAL_STRESS_DIS="MSI is theFace.ing estimate of the subject's Mental Stress."
internal const val CARDIAC_DIS="It is theFace.ing estimate of the subject's Cardiac Workload. It is calculated using the formula: Pulse Rate × Systolic Blood Pressure."
internal const val VASCULAR_CAPACITY_DIS="Vascular Capacity is a measure of the elasticity of subject's blood vessels."
internal const val HEART_RATE_VARIABILITY_DIS="It is theFace.ing estimate of the subject's SDNN, which is a measure of Heart Rate Variability"
internal const val FACIAL_SKIN_AGE_DIS="It is theFace.ing estimate of the subject's age based on the condition of the surface of their face."
internal const val DIABETES_DESCRIPTION="Type 2 Diabetes Risk corresponds to the percentage of people with the subject's risk profile who are diagnosed with Type 2 Diabetes by their doctor."
internal const val S_N_R_Description="Signal-to-Noise Ratio (SNR) measures the clarity of the facial signal captured during scanning. It compares the level of the desired signal (like pulse waveform) to the level of background noise. A higher SNR means better signal quality and more accurate health measurements."
const val GENERAL_WELLNESS_SCORE = "Your Wellness is "
const val BREATHING_RATE = "Your Breathing Rate is"
const val DIABETES_RATE = "Your Type 2 Diabetes Risk is normal"
const val PULSE_RATE = "Your Pulse Rate (Heart Rate) is"
const val BLOOD_PRESSURE_SYSTOLIC = "Your Blood Pressure Systolic is"
const val BLOOD_PRESSURE_head = "Your Blood Pressure is"
const val BLOOD_PRESSURE_DIASTOLIC = "Your Blood Pressure Diastolic is"
const val IRREGULAR_HEARTBEAT_COUNT = "Your Irregular Heartbeat Count is"
const val HEMOGLOBIN_A1C_RISK = "Your Hemoglobin A1C Risk is"
const val FASTING_BLOOD_GLUCOSE_RISK = "Your Fasting Blood Glucose Risk is"
const val CARDIOVASCULAR_DISEASE_RISK = "Your Cardiovascular Disease Risk is"
const val HEART_ATTACK_RISK = "Your Heart Attack Risk is"
const val STROKE_RISK = "Your Stroke Risk is"
const val TYPE_2_DIABETES_RISK = "Your Type 2 Diabetes Risk is"
const val FATTY_LIVER_DISEASE_RISK = "Your Fatty Liver Disease Risk is"
const val HYPERCHOLESTEROLEMIA_RISK = "Your Hypercholesterolemia Risk is"
const val HYPERTENSION_RISK = "Your Hypertension Risk is"
const val METABOLIC_HEALTH_RISK = "Your Overall Metabolic Health Risk is"
const val HYPERTRIGLYCERIDEMIA_RISK = "Your Hypertriglyceridemia Risk is"
const val MENTAL_SCORE = "Your Mental Score is"
const val PHYSICAL_SCORE = "Your Physical Score is"
const val PHYSIOLOGICAL_SCORE = "Your Physiological Score is"
const val RISKS_SCORE = "Your Risks Score is"
const val VITALS_SCORE = "Your Vitals Score is"
const val MENTAL_STRESS_INDEX = "Your Mental Stress Index is"
const val CARDIAC_WORKLOAD = "Your Cardiac Workload is"
const val VASCULAR_CAPACITY = "Your Vascular Capacity is"
const val HEART_RATE_VARIABILITY = "Your Heart Rate Variability is"
const val FACIAL_SKIN_AGE = "Your Facial Skin Age is"
const val S_N_R = "Your Signal-to-Noise Ratio"
