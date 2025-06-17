package com.example.ntt_data.ui

import CenteredContentCard
import CommonCard
import InfoCard
import SNRCard
import TitleWithImageSubtitleCard
import ai.nuralogix.anurasdk.core.result.MeasurementResults
import android.util.Log
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.Constraints
import androidx.compose.ui.unit.dp
import com.example.ntt_data.R
import com.example.ntt_data.measurement.AnuraExampleMeasurementActivity.Companion.TAG
import com.example.ntt_data.utils.BLOOD_PRESSURE
import com.example.ntt_data.utils.BLOOD_PRESSURE_DIASTOLIC
import com.example.ntt_data.utils.BLOOD_PRESSURE_DI_DIS
import com.example.ntt_data.utils.BLOOD_PRESSURE_SYSTOLIC
import com.example.ntt_data.utils.BLOOD_PRESSURE_SY_DIS
import com.example.ntt_data.utils.TYPE_DIAB_RISK_DIS
import com.example.ntt_data.utils.TYPE_2_DIABETES_RISK
import com.example.ntt_data.utils.BLOOD_PRESSURE_head
import com.example.ntt_data.utils.BREATHING_RATE
import com.example.ntt_data.utils.BREATHIN_RATW_DIS
import com.example.ntt_data.utils.CARDIAC_DIS
import com.example.ntt_data.utils.CARDIAC_WORKLOAD
import com.example.ntt_data.utils.CARDIOVASCULAR_DISEASE_RISK
import com.example.ntt_data.utils.CARD_DISEA_RISK_DIS
import com.example.ntt_data.utils.FACIAL_SKIN_AGE
import com.example.ntt_data.utils.FACIAL_SKIN_AGE_DIS
import com.example.ntt_data.utils.FASTING_BLOOD_GLUCOSE_RISK
import com.example.ntt_data.utils.FASTING_GLUCOSE_RISK_DIS
import com.example.ntt_data.utils.FATTY_LIVER_DISEASE_RISK
import com.example.ntt_data.utils.FATTY_LIV_DIA_RISK_DIS
import com.example.ntt_data.utils.GENERAL_WELLNESS_SCORE
import com.example.ntt_data.utils.HEART_ATTACK_RISK
import com.example.ntt_data.utils.HEART_ATTACK_RISK_DIS
import com.example.ntt_data.utils.S_N_R
import com.example.ntt_data.utils.S_N_R_Description
import com.example.ntt_data.utils.HEART_RATE
import com.example.ntt_data.utils.HEART_RATE_VARIABILITY
import com.example.ntt_data.utils.HEART_RATE_VARIABILITY_DIS
import com.example.ntt_data.utils.HEMOGLOBIN_A1C_RISK
import com.example.ntt_data.utils.HEMOGLOBIN_A1_DIS
import com.example.ntt_data.utils.HYPERCHOLESTEROLEMIA_RISK
import com.example.ntt_data.utils.HYPERCHOLE_EMIA_RISK_DIS
import com.example.ntt_data.utils.HYPERTENSION_RISK
import com.example.ntt_data.utils.HYPERTENTION_RISK_DIS
import com.example.ntt_data.utils.HYPERTRIGLYCERIDEMIA_RISK
import com.example.ntt_data.utils.HYPERTRIGLY_EMIA_RISK_DIS
import com.example.ntt_data.utils.HealthStatusEvaluator
import com.example.ntt_data.utils.IRREGULAR_HEARTBEAT_COUNT
import com.example.ntt_data.utils.IRREGULAR_HEART_DIS
import com.example.ntt_data.utils.MENNTAL_STRESS_DIS
import com.example.ntt_data.utils.MENTAL_SCORE
import com.example.ntt_data.utils.MENTAL_SCORE_DIS
import com.example.ntt_data.utils.METABOLIC_HEALTH_RISK
import com.example.ntt_data.utils.OVERALL_METABOLIC_HEALTH_RISK_DIS
import com.example.ntt_data.utils.PHYSICAL_SCORE
import com.example.ntt_data.utils.PHYSICAL_SCORE_DIS
import com.example.ntt_data.utils.PHYSIOLOGICAL_SCORE
import com.example.ntt_data.utils.PHYSIOLOGICAL_SCORE_DIS
import com.example.ntt_data.utils.PULSE_RATE
import com.example.ntt_data.utils.RISKS_SCORE
import com.example.ntt_data.utils.RISK_SCORE_DIS
import com.example.ntt_data.utils.STROKE_RISK
import com.example.ntt_data.utils.STROKE_RISK_DIS
import com.example.ntt_data.utils.VASCULAR_CAPACITY
import com.example.ntt_data.utils.VASCULAR_CAPACITY_DIS
import com.example.ntt_data.utils.VITALS_SCORE
import com.example.ntt_data.utils.VITAL_SCORE_DIS
import com.example.ntt_data.utils.general_health_des

fun formatMixedValue(value: Any?): String {
    return when (value) {
        null -> "N/A"
        is Int -> String.format("%.1f", value.toDouble())
        is Float -> String.format("%.1f", value)
        is Double -> String.format("%.1f", value)
        is String -> {
            value.toDoubleOrNull()?.let {
                String.format("%.1f", it)
            } ?: value
        }
        else -> value.toString()
    }
}
@Composable
fun HealthDataList(results: MeasurementResults, modifier: Modifier = Modifier) {
    val scrollState = rememberScrollState()
    val sortedSignalIDs = remember(results) { results.allResults.keys.sorted() }
    val dynamicMap = mutableMapOf<String, String>()
    for (res in sortedSignalIDs) {
        val siggResult = results.result(res)
        dynamicMap[res] = siggResult.toString();
        Log.d(TAG, "sortedSignalIDs: $res")
        Log.d(TAG, "dynamicMap: $dynamicMap")
        Log.d(TAG, "sortedSignalIDs: $siggResult")
    }
    Card(
        colors = CardDefaults.cardColors(
            containerColor = Color(0xFFF7FAFD), // Light cyan background
            contentColor = Color.Black          // Text and icon color
        ),
    ) {
        Column(
            modifier = modifier
                .fillMaxSize()
                .verticalScroll(scrollState)
                .padding(1.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            dynamicMap["HEALTH_SCORE"]?.let {
                val formatted = formatMixedValue(it).toDoubleOrNull()?:0.0
                Log.d("HealthScoreDebug", "Original value: $it")
                Log.d("HealthScoreDebug", "Formatted value: $formatted")
                IndoCommonCard(
                    vitalValue = formatted.toString(),
                    vitalName = "General Wellness Score",
                    vitalDescription = general_health_des,
                    vitalHeading = GENERAL_WELLNESS_SCORE,
                    vitalStatus = HealthStatusEvaluator.evaluateWellnessScoreStatus(formatted)
                )
            }

                dynamicMap["BR_BPM"]?.let {
                    val formatted = formatMixedValue(it)
                    val numericPart = formatted.replace(Regex("[^0-9.]"), "")
                    val value = numericPart.toDoubleOrNull() ?: 0.0
                    IndoCommonCard(
                        vitalName = "Breathing Rate",
                        vitalValue = formatted,
                        vitalmass = "rpm",
                        vitalDescription = BREATHIN_RATW_DIS,
                        vitalHeading = BREATHING_RATE,
                        isBreathing = true,
                        vitalCondition = "AVG 12 – 25",
                        vitalStatus =HealthStatusEvaluator.elevateBreathingStatus(value)
                    )
                }

            dynamicMap["HR_BPM"]?.let {
                val formatted = formatMixedValue(it)
                println("Formatted HR_BPM: $formatted")

                val numericString = formatted.toString().replace(Regex("[^\\d.]"), "")
                val heartRate = numericString.toDoubleOrNull() ?: 0.0
                println("Parsed heartRate: $heartRate")
                IndoCommonCard(
                    vitalName = "Heart Rate",
                    vitalValue = formatted,
                    vitalmass = "bpm",
                    vitalDescription = HEART_RATE,
                    vitalHeading = PULSE_RATE,
                    isBreathing = true,
                    vitalCondition = "AVG 60 – 100",
                    vitalStatus = HealthStatusEvaluator.evaluatePulseStatus(heartRate)
                )
            }
            dynamicMap["BP_SYSTOLIC"]?.let { systolic ->
                val systolicInt = dynamicMap["BP_SYSTOLIC"]?.toString()?.toDoubleOrNull()?:0.0
                    IndoCommonCard(
                        vitalName = "Blood Systolic",
                        vitalValue = formatMixedValue(systolicInt),
                        vitalmass = "mmHg",
                        vitalHeading = BLOOD_PRESSURE_SYSTOLIC,
                        vitalDescription = BLOOD_PRESSURE_SY_DIS,
                        isBlood = true,
                        vitalCondition = "AVG 100 – 139",
                        vitalStatus = HealthStatusEvaluator.evaluateSystolicStatus(systolicInt)
                    )
                }
                dynamicMap["BP_DIASTOLIC"]?.let { systolic ->
                    val diastolicInt = dynamicMap["BP_DIASTOLIC"]?.toString()?.toDoubleOrNull()?:0.0
                        IndoCommonCard(
                            vitalName = "Blood Diastolic",
                            vitalValue = formatMixedValue(diastolicInt),
                            vitalmass = "mmHg",
                            vitalHeading = BLOOD_PRESSURE_DIASTOLIC,
                            vitalDescription = BLOOD_PRESSURE_DI_DIS,
                            vitalCondition = "AVG 60 – 89",
                            isBlood = true,
                            isLowGood = true,
                            vitalStatus = HealthStatusEvaluator.evaluateDiastolicStatus(diastolicInt)
                        )
                    }
                dynamicMap["IHB_COUNT"]?.let {
                    val formatted = formatMixedValue(it)
                    IndoCommonCard(
                        vitalName = "Irregular Heartbeat Count",
                        vitalValue = formatted,
                        vitalDescription = IRREGULAR_HEART_DIS,
                        vitalHeading = IRREGULAR_HEARTBEAT_COUNT,
                    )
                }
                dynamicMap["HBA1C_RISK_PROB"]?.let {
                    val formatted = formatMixedValue(it)
                    val riskProb = formatted.toString().toDoubleOrNull() ?: 0.0
                    IndoCommonCard(
                        vitalName = "Hemoglobin A1C Risk",
                        vitalValue = formatted,
                        vitalmass = "%",
                        vitalDescription = HEMOGLOBIN_A1_DIS,
                        vitalHeading = HEMOGLOBIN_A1C_RISK,
                        isLowGood = true,
                        vitalStatus = HealthStatusEvaluator.evaluateHoemoglobinA1CRiskStatus(riskProb)
                    )
                }
                dynamicMap["MFBG_RISK_PROB"]?.let {
                    val formatted = formatMixedValue(it)
                    val riskProb = formatted.toString().toDoubleOrNull() ?: 0.0
                    IndoCommonCard(
                        vitalName = "Fasting Blood Glucose Risk",
                        vitalValue = formatted,
                        vitalmass = "%",
                        vitalDescription = FASTING_GLUCOSE_RISK_DIS,
                        vitalHeading = FASTING_BLOOD_GLUCOSE_RISK,
                        isLowGood = true,
                        vitalStatus =  HealthStatusEvaluator.evaluateHoemoglobinA1CRiskStatus(riskProb)
                    )
                }

                dynamicMap["BP_CVD"]?.let {
                    val formatted = formatMixedValue(it)
                    val riskValue = formatted.toString().toDoubleOrNull() ?: 0.0
                    IndoCommonCard(
                        vitalName = "Cardiovascular Risk Level",
                        vitalValue = formatted,
                        vitalmass = "%",
                        vitalDescription = CARDIAC_DIS,
                        vitalHeading = CARDIOVASCULAR_DISEASE_RISK,
                        isLowGood = true,
                        vitalStatus =  HealthStatusEvaluator.evaluateCardiovascularDiseaseRiskStatus(riskValue)
                    )
                }
                dynamicMap["BP_HEART_ATTACK"]?.let {
                    val formatted = formatMixedValue(it)
                    val riskValue = formatted.toString().toDoubleOrNull() ?: 0.0
                    IndoCommonCard(
                        vitalName = "Heart Attack Risk",
                        vitalValue = formatted,
                        vitalmass = "%",
                        vitalDescription = HEART_ATTACK_RISK_DIS,
                        vitalHeading = HEART_ATTACK_RISK,
                        isLowGood = true,
                        vitalStatus =  HealthStatusEvaluator.evaluate1HeartAttackRiskStatus(riskValue)
                    )
                    dynamicMap["BP_STROKE"]?.let {
                        val formatted = formatMixedValue(it)
                        val strokeRisk = formatted.toString().toDoubleOrNull() ?: 0.0
                        IndoCommonCard(
                            vitalName = "Stroke Risk",
                            vitalValue = formatted,
                            vitalmass = "%",
                            vitalDescription = STROKE_RISK_DIS,
                            vitalHeading = STROKE_RISK,
                            isLowGood = true,
                            vitalStatus =  HealthStatusEvaluator.evaluateStrokeRiskStatus(strokeRisk)
                        )
                    }
                    dynamicMap["DBT_RISK_PROB"]?.let {
                            val formatted = formatMixedValue(it).toDoubleOrNull()?:0.0
                            IndoCommonCard(
                                vitalName = "Diabetes Risk",
                                vitalValue = formatted.toString(),
                                vitalDescription = TYPE_DIAB_RISK_DIS,
                                vitalHeading = TYPE_2_DIABETES_RISK,
                                vitalmass = "%",
                                isLowGood = true,
                                vitalStatus = HealthStatusEvaluator.evaluateHoemoglobinA1CRiskStatus(formatted)



                            )
                        }

                    dynamicMap["FLD_RISK_PROB"]?.let {
                        val formatted = formatMixedValue(it)
                        val riskValue = formatted.toString().toDoubleOrNull() ?: 0.0

                        IndoCommonCard(
                            vitalName = "Fatty Liver Disease Risk",
                            vitalValue = formatted,
                            vitalmass = "%",
                            vitalDescription = FATTY_LIV_DIA_RISK_DIS,
                            vitalHeading = FATTY_LIVER_DISEASE_RISK,
                            isLowGood = true,
                            vitalStatus = HealthStatusEvaluator.evaluateHoemoglobinA1CRiskStatus(riskValue)
                        )
                    }

                    dynamicMap["HDLTC_RISK_PROB"]?.let {
                        val formatted = formatMixedValue(it)
                        val riskValue = formatted.toString().toDoubleOrNull() ?: 0.0
                        IndoCommonCard(
                            vitalName = "Hypercholesterolemia Risk",
                            vitalValue = formatted,
                            vitalmass = "%",
                            vitalDescription = HYPERCHOLE_EMIA_RISK_DIS,
                            vitalHeading = HYPERCHOLESTEROLEMIA_RISK,
                            isLowGood = true,
                            vitalStatus = HealthStatusEvaluator.evaluateHoemoglobinA1CRiskStatus(riskValue)
                        )
                    }
                    dynamicMap["HPT_RISK_PROB"]?.let {
                        val formatted = formatMixedValue(it)
                        val value = formatted.toString().toDoubleOrNull() ?: 0.0
 IndoCommonCard(
                            vitalName = "Hypertension Risk",
                            vitalValue = formatted,
                            vitalmass = "%",
                            vitalDescription = HYPERTENTION_RISK_DIS,
                            isLowGood = true,
                            vitalHeading = HYPERTENSION_RISK,
                            vitalStatus = HealthStatusEvaluator.evaluateHoemoglobinA1CRiskStatus(value)
                        )
                    }


                    dynamicMap["OVERALL_METABOLIC_RISK_PROB"]?.let {
                        val formatted = formatMixedValue(it)
                        val value = formatted.toString().toDoubleOrNull() ?: 0.0
  IndoCommonCard(
                            vitalName = "Overall Metabolic Health Risk",
                            vitalValue = formatted,
                            vitalmass = "%",
                            vitalDescription = OVERALL_METABOLIC_HEALTH_RISK_DIS,
                            vitalHeading = METABOLIC_HEALTH_RISK,
                            isLowGood = true,
                            vitalStatus = HealthStatusEvaluator.evaluateHoemoglobinA1CRiskStatus(value)
                        )
                    }

//                    }
//                    Row {
                    dynamicMap["TG_RISK_PROB"]?.let {
                        val formatted = formatMixedValue(it)
                        val value = formatted.toString().toDoubleOrNull() ?: 0.0

                      IndoCommonCard(
                            vitalName = "Hypertriglyceridemia Risk",
                            vitalValue = formatted,
                            vitalmass = "%",
                            vitalDescription = HYPERTRIGLY_EMIA_RISK_DIS,
                            vitalHeading = HYPERTRIGLYCERIDEMIA_RISK,
                            isLowGood = true,
                            vitalStatus = HealthStatusEvaluator.evaluateHoemoglobinA1CRiskStatus(value)
                        )
                    }

                    dynamicMap["MENTAL_SCORE"]?.let {
                        val formatted = formatMixedValue(it)
                        val numericValue = formatted.toDoubleOrNull() ?: 0.0 // safely convert to Int

                        IndoCommonCard(
                            vitalName = "Mental Score",
                            vitalValue = formatted,
                            vitalDescription = MENTAL_SCORE_DIS,
                            vitalHeading = MENTAL_SCORE,

                            vitalStatus = HealthStatusEvaluator.evaluateMentalStressIndexStatus(numericValue)
                        )
                    }
                    dynamicMap["PHYSICAL_SCORE"]?.let {
                        val formatted = formatMixedValue(it)
                        val numericValue = formatted.toDoubleOrNull() ?: 0.0// Safely parse to Int
                        IndoCommonCard(
                            vitalName = "Physical Score",
                            vitalValue = formatted,
                            vitalDescription = general_health_des,
                            vitalHeading = PHYSICAL_SCORE,
                            vitalStatus =HealthStatusEvaluator.evaluateMentalStressIndexStatus(numericValue)
                        )
                    }

                    dynamicMap["PHYSIO_SCORE"]?.let {
                        val formatted = formatMixedValue(it)
                        val numericValue = formatted.toDoubleOrNull() ?: 0.0 // safely convert to Int

                        IndoCommonCard(
                            vitalName = "Physiological Score",
                            vitalValue = formatted,
                            vitalDescription = general_health_des,
                            vitalHeading = PHYSIOLOGICAL_SCORE,
                            vitalStatus = HealthStatusEvaluator.evaluateMentalStressIndexStatus(numericValue)
                        )
                    }
                    dynamicMap["RISKS_SCORE"]?.let {
                        val formatted = formatMixedValue(it)
                        val numericValue = formatted.toDoubleOrNull() ?: 0.0

                        IndoCommonCard(
                            vitalName = "Risk Score",
                            vitalValue = formatted,
                            vitalDescription = general_health_des,
                            vitalHeading = RISKS_SCORE,
                            vitalStatus = HealthStatusEvaluator.evaluateMentalStressIndexStatus(numericValue)
                        )
                    }

                    dynamicMap["VITAL_SCORE"]?.let {
                        val formatted = formatMixedValue(it)
                        val numericValue = formatted.toDoubleOrNull() ?: 0.0

                        IndoCommonCard(
                            vitalName = "Vital Signs Score",
                            vitalValue = formatted,
                            vitalDescription = general_health_des,
                            vitalHeading = VITALS_SCORE,

                            vitalStatus = HealthStatusEvaluator.evaluateMentalStressIndexStatus(numericValue)
                        )
                    }
                    dynamicMap["MSI"]?.let {
                        val formatted = formatMixedValue(it)
                        val numericValue = formatted.toDoubleOrNull() ?: 0.0

                        IndoCommonCard(
                            vitalName = "Mental Stress Index",
                            vitalValue = formatted,
                            vitalDescription = MENNTAL_STRESS_DIS,
                            vitalHeading = MENTAL_SCORE,

                            isLowGood = true,
                            vitalStatus = HealthStatusEvaluator.evaluateMentalStressIndexStatus1(numericValue)
                        )
                    }
                        dynamicMap["BP_RPP"]?.let {
                            val formatted = formatMixedValue(it).toDoubleOrNull()?:0.0
                            IndoCommonCard(
                                vitalName = "Cardiac Workload",
                                vitalValue = formatted.toString(),
                                vitalmass = "dB",
                                vitalDescription = CARDIAC_DIS,
                                vitalHeading = CARDIAC_WORKLOAD,

                                isLowGood = true,
                                vitalStatus = HealthStatusEvaluator.evaluateMentalStressIndexStatus(formatted)

                            )
                        }
                        dynamicMap["BP_TAU"]?.let {
                            val formatted = formatMixedValue(it).toDoubleOrNull()?:0.0
                            IndoCommonCard(
                                vitalName = "Vascular Capacity",
                                vitalValue = formatted.toString(),
                                vitalmass = "seconds",

                                vitalDescription = VASCULAR_CAPACITY_DIS,
                                vitalHeading = VASCULAR_CAPACITY,
                                        vitalStatus = HealthStatusEvaluator.evaluateVascularCapacityStatus(formatted)
                            )
                        }

                    dynamicMap["HRV_SDNN"]?.let {
                        val formatted = formatMixedValue(it).toDoubleOrNull()?:0.0
                        IndoCommonCard(
                            vitalName = "Heart Rate Variability",
                            vitalValue = formatted.toString(),
                            vitalmass = "ms",
                            vitalDescription = HEART_RATE_VARIABILITY_DIS,
                            vitalHeading = HEART_RATE_VARIABILITY,
                            vitalStatus = HealthStatusEvaluator.evaluateHeartRateVariabilityStatus(formatted))
                    }

                        dynamicMap["AGE"]?.let {
                            val formatted = formatMixedValue(it)
                            IndoCommonCard(
                                vitalName = "Facial Skin Age",
                                vitalValue = formatted,
                                vitalmass = "years",
                                vitalDescription = FACIAL_SKIN_AGE_DIS,
                                vitalHeading = FACIAL_SKIN_AGE,
                            )
                        }
                    dynamicMap["SNR"]?.let {
                        val formatted = formatMixedValue(it)
                        IndoCommonCard(
                            vitalName = "Signal-to-Noise Ratio",
                            vitalValue = formatted,
                            vitalmass = "dB",
                            vitalDescription = S_N_R_Description,
                            vitalHeading = S_N_R,


                        )
                    }




                }
            }
        }
    }






