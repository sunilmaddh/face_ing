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
                .padding(16.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            dynamicMap["HEALTH_SCORE"]?.let {
                val formatted = formatMixedValue(it)
                // Log original and formatted values
                Log.d("HealthScoreDebug", "Original value: $it")
                Log.d("HealthScoreDebug", "Formatted value: $formatted")
                IndoCommonCard(
                    vitalValue = formatted,
                    vitalName = "Wellness Index",
                    vitalDescription = general_health_des,
                    vitalHeading = GENERAL_WELLNESS_SCORE,
                    vitalCondition = "AVG 40 – 69",
                    vitalStatus = if(formatted<4.toString())"Low" else if(formatted> 6.toString())"High" else "Medium"

                )
            }
//            Row(horizontalArrangement = Arrangement.SpaceBetween) {

                dynamicMap["BR_BPM"]?.let {
                    val formatted = formatMixedValue(it)

                    // Remove non-numeric characters except dot
                    val numericPart = formatted.replace(Regex("[^0-9.]"), "")
                    val value = numericPart.toDoubleOrNull() ?: 0.0

                    IndoCommonCard(
                        vitalName = "Breathing Rate",
                        vitalValue = formatted, // still shows "20.0 rpm"
                        vitalmass = "rpm",
                        vitalDescription = BREATHIN_RATW_DIS,
                        vitalHeading = BREATHING_RATE,
                        vitalCondition = "AVG 12 – 20",
                        vitalStatus = when {
                            value < 12 -> "Low"
                            value > 20 -> "High"
                            else -> "Medium"
                        }
                    )
                }

            dynamicMap["HR_BPM"]?.let {
                val formatted = formatMixedValue(it)
                println("Formatted HR_BPM: $formatted")

                val numericString = formatted.toString().replace(Regex("[^\\d.]"), "")
                val heartRate = numericString.toDoubleOrNull() ?: 0.0
                println("Parsed heartRate: $heartRate")

                val vitalStatus = when {
                    heartRate < 60 -> "Low"
                    heartRate > 100 -> "High"
                    else -> "Medium"
                }

                IndoCommonCard(
                    vitalName = "Heart Rate",
                    vitalValue = formatted,
                    vitalmass = "bpm",
                    vitalDescription = HEART_RATE,
                    vitalHeading = PULSE_RATE,
                    vitalCondition = "AVG 60 – 100",
                    vitalStatus = vitalStatus
                )
            }






//            }
            dynamicMap["BP_SYSTOLIC"]?.let { systolic ->
                val systolicInt = dynamicMap["BP_SYSTOLIC"]?.toString()?.toDoubleOrNull()?.toInt()
                val diastolicInt = dynamicMap["BP_DIASTOLIC"]?.toString()?.toDoubleOrNull()?.toInt()

                if (systolicInt != null && diastolicInt != null) {
                    val vitalStatus = when {
                        systolicInt < 90 || diastolicInt < 60 -> "Low"
                        systolicInt > 120 || diastolicInt > 80 -> "High"
                        else -> "Medium"
                    }

                    IndoCommonCard(
                        vitalName = "Blood Pressure",
                        vitalValue = "$systolicInt/$diastolicInt",
                        vitalmass = "mmHg",
                        vitalHeading = BLOOD_PRESSURE_head,
                        vitalDescription = BLOOD_PRESSURE,
                        vitalCondition = "AVG 90 – 120 / 60 – 80",
                        vitalStatus = vitalStatus
                    )
                }



//                Row {
                dynamicMap["IHB_COUNT"]?.let {
                    val formatted = formatMixedValue(it)
                    val ihbCount = formatted.toString().toIntOrNull() ?: 0

                    val vitalStatus = when (ihbCount) {
                        0 -> "Low"
                        1, 2 -> "Medium"
                        3, 4 -> "High"
                        else -> "High" // optionally handle unexpected high values
                    }

                    IndoCommonCard(
                        vitalName = "Irregular Heartbeat Count",
                        vitalValue = formatted,
                        vitalDescription = IRREGULAR_HEART_DIS,
                        vitalHeading = IRREGULAR_HEARTBEAT_COUNT,
                        vitalCondition = "AVG 1 – 2",
                        vitalStatus = vitalStatus
                    )
                }

                dynamicMap["HBA1C_RISK_PROB"]?.let {
                    val formatted = formatMixedValue(it)
                    val riskProb = formatted.toString().toDoubleOrNull() ?: 0.0

                    val vitalStatus = when {
                        riskProb <= 30 -> "Low"
                        riskProb <= 70 -> "Medium"
                        else -> "High"
                    }

                    IndoCommonCard(
                        vitalName = "Hemoglobin A1C Risk",
                        vitalValue = formatted,
                        vitalmass = "%",
                        vitalDescription = HEMOGLOBIN_A1_DIS,
                        vitalHeading = HEMOGLOBIN_A1C_RISK,
                        vitalCondition = "AVG 31 – 70",
                        vitalStatus = vitalStatus
                    )
                }

//            dynamicMap["HRV_SDNN"]?.let { CommonCard(
//                title = "Heart Rate Variability",
//                subtitle = it,
//                mass = "ms"
//
//            )}
//            dynamicMap["BP_RPP"]?.let {CommonCard(
//                title = "Rate Pressure Product (RPP)",
//                subtitle = it,
//            )}


//                }
//                Row {
                dynamicMap["MFBG_RISK_PROB"]?.let {
                    val formatted = formatMixedValue(it)
                    val riskProb = formatted.toString().toDoubleOrNull() ?: 0.0

                    val vitalStatus = when {
                        riskProb <= 30 -> "Low"
                        riskProb <= 70 -> "Medium"
                        else -> "High"
                    }

                    IndoCommonCard(
                        vitalName = "Fasting Blood Glucose Risk",
                        vitalValue = formatted,
                        vitalmass = "%",
                        vitalDescription = FASTING_GLUCOSE_RISK_DIS,
                        vitalHeading = FASTING_BLOOD_GLUCOSE_RISK,
                        vitalCondition = "AVG 31 – 70",
                        vitalStatus = vitalStatus
                    )
                }

                dynamicMap["BP_CVD"]?.let {
                    val formatted = formatMixedValue(it)
                    val riskValue = formatted.toString().toDoubleOrNull() ?: 0.0

                    val vitalStatus = when {
                        riskValue <= 30 -> "Low"
                        riskValue <= 70 -> "Medium"
                        else -> "High"
                    }

                    IndoCommonCard(
                        vitalName = "Cardiovascular Risk Level",
                        vitalValue = formatted,
                        vitalmass = "%",
                        vitalDescription = CARDIAC_DIS,
                        vitalHeading = CARDIOVASCULAR_DISEASE_RISK,
                        vitalCondition = "AVG 31 – 70",
                        vitalStatus = vitalStatus
                    )
                }

//            dynamicMap["HRV_SDNN"]?.let { CommonCard(
//                title = "Heart Rate Variability",
//                subtitle = it,
//                mass = "ms"
//
//            )}
//            dynamicMap["BP_RPP"]?.let {CommonCard(
//                title = "Rate Pressure Product (RPP)",
//                subtitle = it,
//            )}


//                }

                dynamicMap["BP_HEART_ATTACK"]?.let {
                    val formatted = formatMixedValue(it)
                    val riskValue = formatted.toString().toDoubleOrNull() ?: 0.0

                    val vitalStatus = when {
                        riskValue <= 30 -> "Low"
                        riskValue <= 70 -> "Medium"
                        else -> "High"
                    }

                    IndoCommonCard(
                        vitalName = "Heart Attack Risk",
                        vitalValue = formatted,
                        vitalmass = "%",
                        vitalDescription = HEART_ATTACK_RISK_DIS,
                        vitalHeading = HEART_ATTACK_RISK,
                        vitalCondition = "AVG 31 – 70",
                        vitalStatus = vitalStatus
                    )




//                    Row {
                    dynamicMap["BP_STROKE"]?.let {
                        val formatted = formatMixedValue(it)
                        val strokeRisk = formatted.toString().toDoubleOrNull() ?: 0.0

                        val vitalStatus = when {
                            strokeRisk <= 30 -> "Low"
                            strokeRisk <= 70 -> "Medium"
                            else -> "High"
                        }

                        IndoCommonCard(
                            vitalName = "Stroke Risk",
                            vitalValue = formatted,
                            vitalmass = "%",
                            vitalDescription = STROKE_RISK_DIS,
                            vitalHeading = STROKE_RISK,
                            vitalCondition = "AVG 31 – 70",
                            vitalStatus = vitalStatus
                        )
                    }


                    dynamicMap["DBT_RISK_PROB"]?.let {
                            val formatted = formatMixedValue(it)
                            IndoCommonCard(
                                vitalName = " Diabetes Risk",
                                vitalValue = formatted,
                                vitalDescription = TYPE_DIAB_RISK_DIS,
                                vitalHeading = TYPE_2_DIABETES_RISK,
                                vitalmass = "%",
                                vitalCondition = "AVG 31 – 70",
                                vitalStatus = if(formatted< 31.toString())"Low" else if(formatted> 70.toString())"High" else "Medium"




                            )
                        }
//                    }


//        dynamicMap["BP_SYSTOLIC"]?.let {InfoCard(
//            title = "Blood Pressure (Systolic/Diastolic)",
//            subtitle = "${it.toIntOrNull()}/${dynamicMap["BP_DIASTOLIC"]?.toIntOrNull()}",
//            mass = "mmHg",
//            imageRes = R.drawable.mask_group
//        )}


//                    Row {
                    // Fatty Liver Disease Risk
                    dynamicMap["FLD_RISK_PROB"]?.let {
                        val formatted = formatMixedValue(it)
                        val riskValue = formatted.toString().toDoubleOrNull() ?: 0.0

                        val vitalStatus = when {
                            riskValue <= 30 -> "Low"
                            riskValue <= 70 -> "Medium"
                            else -> "High"
                        }

                        IndoCommonCard(
                            vitalName = "Fatty Liver Disease Risk",
                            vitalValue = formatted,
                            vitalmass = "%",
                            vitalDescription = FATTY_LIV_DIA_RISK_DIS,
                            vitalHeading = FATTY_LIVER_DISEASE_RISK,
                            vitalCondition = "AVG 31 – 70",
                            vitalStatus = vitalStatus
                        )
                    }

// Hypercholesterolemia Risk
                    dynamicMap["HDLTC_RISK_PROB"]?.let {
                        val formatted = formatMixedValue(it)
                        val riskValue = formatted.toString().toDoubleOrNull() ?: 0.0

                        val vitalStatus = when {
                            riskValue <= 30 -> "Low"
                            riskValue <= 70 -> "Medium"
                            else -> "High"
                        }

                        IndoCommonCard(
                            vitalName = "Hypercholesterolemia Risk",
                            vitalValue = formatted,
                            vitalmass = "%",
                            vitalDescription = HYPERCHOLE_EMIA_RISK_DIS,
                            vitalHeading = HYPERCHOLESTEROLEMIA_RISK,
                            vitalCondition = "AVG 31 – 70",
                            vitalStatus = vitalStatus
                        )
                    }



//                    }
//                    Row {
                    dynamicMap["HPT_RISK_PROB"]?.let {
                        val formatted = formatMixedValue(it)
                        val value = formatted.toString().toDoubleOrNull() ?: 0.0

                        val vitalStatus = when {
                            value <= 30 -> "Low"
                            value <= 70 -> "Medium"
                            else -> "High"
                        }

                        IndoCommonCard(
                            vitalName = "Hypertension Risk",
                            vitalValue = formatted,
                            vitalmass = "%",
                            vitalDescription = HYPERTENTION_RISK_DIS,
                            vitalHeading = HYPERTENSION_RISK,
                            vitalCondition = "AVG 31 – 70",
                            vitalStatus = vitalStatus
                        )
                    }


                    dynamicMap["OVERALL_METABOLIC_RISK_PROB"]?.let {
                        val formatted = formatMixedValue(it)
                        val value = formatted.toString().toDoubleOrNull() ?: 0.0

                        val vitalStatus = when {
                            value <= 30 -> "Low"
                            value <= 70 -> "Medium"
                            else -> "High"
                        }

                        IndoCommonCard(
                            vitalName = "Overall Metabolic Health Risk",
                            vitalValue = formatted,
                            vitalmass = "%",
                            vitalDescription = OVERALL_METABOLIC_HEALTH_RISK_DIS,
                            vitalHeading = METABOLIC_HEALTH_RISK,
                            vitalCondition = "AVG 31 – 70",
                            vitalStatus = vitalStatus
                        )
                    }

//                    }
//                    Row {
                    dynamicMap["TG_RISK_PROB"]?.let {
                        val formatted = formatMixedValue(it)
                        val value = formatted.toString().toDoubleOrNull() ?: 0.0

                        val vitalStatus = when {
                            value <= 30 -> "Low"
                            value <= 70 -> "Medium"
                            else -> "High"
                        }

                        IndoCommonCard(
                            vitalName = "Hypertriglyceridemia Risk",
                            vitalValue = formatted,
                            vitalmass = "%",
                            vitalDescription = HYPERTRIGLY_EMIA_RISK_DIS,
                            vitalHeading = HYPERTRIGLYCERIDEMIA_RISK,
                            vitalCondition = "AVG 31 – 70",
                            vitalStatus = vitalStatus
                        )
                    }

                    dynamicMap["MENTAL_SCORE"]?.let {
                        val formatted = formatMixedValue(it)
                        val numericValue = formatted.toIntOrNull() ?: 0 // safely convert to Int

                        IndoCommonCard(
                            vitalName = "Mental Score",
                            vitalValue = formatted,
                            vitalDescription = MENTAL_SCORE_DIS,
                            vitalHeading = MENTAL_SCORE,
                            vitalCondition = "AVG 3",
                            vitalStatus = when (numericValue) {
                                1, 2 -> "Low"
                                3 -> "Medium"
                                4, 5 -> "High"
                                else -> "Unknown"
                            }
                        )
                    }

//                    }
//                    Row {
                    dynamicMap["PHYSICAL_SCORE"]?.let {
                        val formatted = formatMixedValue(it)
                        val numericValue = formatted.toIntOrNull() ?: 0 // Safely parse to Int

                        IndoCommonCard(
                            vitalName = "Physical Score",
                            vitalValue = formatted,
                            vitalDescription = PHYSICAL_SCORE_DIS,
                            vitalHeading = PHYSICAL_SCORE,
                            vitalCondition = "AVG 3",
                            vitalStatus = when (numericValue) {
                                1, 2 -> "Low"
                                3 -> "Medium"
                                4, 5 -> "High"
                                else -> "Unknown"
                            }
                        )
                    }

                    dynamicMap["PHYSIO_SCORE"]?.let {
                        val formatted = formatMixedValue(it)
                        val numericValue = formatted.toIntOrNull() ?: 0 // safely convert to Int

                        IndoCommonCard(
                            vitalName = "Physiological Score",
                            vitalValue = formatted,
                            vitalDescription = PHYSIOLOGICAL_SCORE_DIS,
                            vitalHeading = PHYSIOLOGICAL_SCORE,
                            vitalCondition = "AVG 3",
                            vitalStatus = when (numericValue) {
                                1, 2 -> "Low"
                                3 -> "Medium"
                                4, 5 -> "High"
                                else -> "Unknown"
                            }
                        )
                    }

//                    }
//                    Row {
                    dynamicMap["RISKS_SCORE"]?.let {
                        val formatted = formatMixedValue(it)
                        val numericValue = formatted.toIntOrNull() ?: 0

                        IndoCommonCard(
                            vitalName = "Risk Score",
                            vitalValue = formatted,
                            vitalDescription = RISK_SCORE_DIS,
                            vitalHeading = RISKS_SCORE,
                            vitalCondition = "AVG 3",
                            vitalStatus = when (numericValue) {
                                1, 2 -> "Low"
                                3 -> "Medium"
                                4, 5 -> "High"
                                else -> "Unknown"
                            }
                        )
                    }

                    dynamicMap["VITAL_SCORE"]?.let {
                        val formatted = formatMixedValue(it)
                        val numericValue = formatted.toIntOrNull() ?: 0

                        IndoCommonCard(
                            vitalName = "Vital Signs Score",
                            vitalValue = formatted,
                            vitalDescription = VITAL_SCORE_DIS,
                            vitalHeading = VITALS_SCORE,
                            vitalCondition = "AVG 3",
                            vitalStatus = when (numericValue) {
                                1, 2 -> "Low"
                                3 -> "Medium"
                                4, 5 -> "High"
                                else -> "Unknown"
                            }
                        )
                    }

//                    }
                    dynamicMap["MSI"]?.let {
                        val formatted = formatMixedValue(it)
                        val numericValue = formatted.toIntOrNull() ?: 0

                        IndoCommonCard(
                            vitalName = "Mental Stress Index",
                            vitalValue = formatted,
                            vitalDescription = MENNTAL_STRESS_DIS,
                            vitalHeading = MENTAL_SCORE,
                            vitalCondition = "AVG 3",
                            vitalStatus = when (numericValue) {
                                1, 2 -> "Low"
                                3 -> "Medium"
                                4, 5 -> "High"
                                else -> "Unknown"
                            }
                        )
                    }

//                    Row {
                        dynamicMap["BP_RPP"]?.let {
                            val formatted = formatMixedValue(it)
                            IndoCommonCard(
                                vitalName = "Cardiac Workload",
                                vitalValue = formatted,


                                vitalmass = "dB",
                                vitalDescription = CARDIAC_DIS,
                                vitalHeading = CARDIAC_WORKLOAD,
                                vitalCondition = "AVG 3.8– 4.1",
                                vitalStatus = if(formatted< 3.8.toString())"Low" else if(formatted> 4.1.toString())"High" else "Medium"


                            )
                        }
                        dynamicMap["BP_TAU"]?.let {
                            val formatted = formatMixedValue(it)
                            IndoCommonCard(
                                vitalName = "Vascular Capacity",
                                vitalValue = formatted,
                                vitalmass = "seconds",

                                vitalDescription = VASCULAR_CAPACITY_DIS,
                                vitalHeading = VASCULAR_CAPACITY,
                                vitalCondition = "AVG 1 – 2.5",
                                        vitalStatus = if(formatted< 1.toString())"Low" else if(formatted> 2.5.toString())"High" else "Medium"

                            )
                        }
//                    }
                    dynamicMap["HRV_SDNN"]?.let {
                        val formatted = formatMixedValue(it)
                        IndoCommonCard(
                            vitalName = "Heart Rate Variability",
                            vitalValue = formatted,
                            vitalmass = "ms",
                            vitalDescription = HEART_RATE_VARIABILITY_DIS,
                            vitalHeading = HEART_RATE_VARIABILITY,
                            vitalCondition = "AVG 20 – 50",
                            vitalStatus = if(formatted< 20.toString())"Low" else if(formatted> 50.toString())"High" else "Medium"
                        )
                    }

//                    Row(
//                        horizontalArrangement =Arrangement.Start ,
//                        ) {
                        dynamicMap["AGE"]?.let {
                            val formatted = formatMixedValue(it)
                            IndoCommonCard(
                                vitalName = "Facial Skin Age",
                                vitalValue = formatted,
                                vitalmass = "years",
                                vitalDescription = FACIAL_SKIN_AGE_DIS,
                                vitalHeading = FACIAL_SKIN_AGE, vitalCondition = "AVG 20 – 50",
                                vitalStatus = if(formatted< 20.toString())"Low" else if(formatted> 50.toString())"High" else "Medium"
                            )
                        }
                    dynamicMap["SNR"]?.let {
                        val formatted = formatMixedValue(it)
                        val numericValue = formatted.toDoubleOrNull() ?: 0.0

                        IndoCommonCard(
                            vitalName = "Signal-to-Noise Ratio",
                            vitalValue = formatted,
                            vitalmass = "dB",
                            vitalDescription = S_N_R_Description,
                            vitalHeading = S_N_R,
                            vitalCondition = "AVG -10 to 20",
                            vitalStatus = when {
                                numericValue < -10 -> "Low"
                                numericValue > 20 -> "High"
                                else -> "Medium"
                            }
                        )
                    }



//                    }
                }
            }
        }
    }




}

