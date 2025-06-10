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
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Card
import androidx.compose.material3.CardColors
import androidx.compose.material3.CardDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import com.example.ntt_data.R
import com.example.ntt_data.measurement.AnuraExampleMeasurementActivity.Companion.TAG
import com.example.ntt_data.utils.BLOOD_PRESSURE
import com.example.ntt_data.utils.BLOOD_PRESSURE_head
import com.example.ntt_data.utils.BREATHING_RATE
import com.example.ntt_data.utils.BREATHIN_RATW_DIS
import com.example.ntt_data.utils.CARDIAC_DIS
import com.example.ntt_data.utils.CARDIAC_WORKLOAD
import com.example.ntt_data.utils.FACIAL_SKIN_AGE
import com.example.ntt_data.utils.FACIAL_SKIN_AGE_DIS
import com.example.ntt_data.utils.FASTING_BLOOD_GLUCOSE_RISK
import com.example.ntt_data.utils.FASTING_GLUCOSE_RISK_DIS
import com.example.ntt_data.utils.HEART_RATE
import com.example.ntt_data.utils.HEART_RATE_VARIABILITY
import com.example.ntt_data.utils.HEART_RATE_VARIABILITY_DIS
import com.example.ntt_data.utils.HEMOGLOBIN_A1C_RISK
import com.example.ntt_data.utils.HEMOGLOBIN_A1_DIS
import com.example.ntt_data.utils.HealthStatusEvaluator
import com.example.ntt_data.utils.IRREGULAR_HEARTBEAT_COUNT
import com.example.ntt_data.utils.IRREGULAR_HEART_DIS
import com.example.ntt_data.utils.MENNTAL_STRESS_DIS
import com.example.ntt_data.utils.MENTAL_SCORE
import com.example.ntt_data.utils.PULSE_RATE
import com.example.ntt_data.utils.S_N_R
import com.example.ntt_data.utils.S_N_R_Description
import com.example.ntt_data.utils.VASCULAR_CAPACITY
import com.example.ntt_data.utils.VASCULAR_CAPACITY_DIS


@Composable
fun VitalScreen(results: MeasurementResults,modifier: Modifier = Modifier) {

    val scrollState = rememberScrollState()
    val sortedSignalIDs = remember(results) { results.allResults.keys.sorted() }
    val dynamicMap = mutableMapOf<String, String>()
    for(res in sortedSignalIDs){

        val siggResult =   results.result(res)
        dynamicMap[res]=siggResult.toString();
        Log.d(TAG, "sortedSignalIDs: $res")
        Log.d(TAG, "dynamicMap: $dynamicMap")
        Log.d(TAG, "sortedSignalIDs: $siggResult")
    }
    Card(colors = CardDefaults.cardColors(
        containerColor = Color(0xFFF7FAFD), // Light cyan background
        contentColor = Color.Black          // Text and icon color
    ),) {
        Column(
            modifier = modifier
                .fillMaxSize()
                .verticalScroll(scrollState)
                .padding(16.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
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
                    vitalStatus = HealthStatusEvaluator.elevateBreathingStatus(value)
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
                    vitalStatus = HealthStatusEvaluator.evaluatePulseStatus(heartRate)
                )
            }






//            }
            dynamicMap["BP_SYSTOLIC"]?.let { systolic ->
                val systolicInt = dynamicMap["BP_SYSTOLIC"]?.toString()?.toDoubleOrNull()?:0.0
                IndoCommonCard(
                    vitalName = "Blood Systolic",
                    vitalValue = systolicInt.toString(),
                    vitalmass = "mmHg",
                    vitalHeading = BLOOD_PRESSURE_head,
                    vitalDescription = BLOOD_PRESSURE,
                    vitalCondition = "AVG 90 – 120 / 60 – 80",
                    vitalStatus = HealthStatusEvaluator.evaluateSystolicStatus(systolicInt)
                )
            }
            dynamicMap["BP_DIASTOLIC"]?.let { systolic ->
//                    val systolicInt = dynamicMap["BP_SYSTOLIC"]?.toString()?.toDoubleOrNull()?.toInt()
                val diastolicInt = dynamicMap["BP_DIASTOLIC"]?.toString()?.toDoubleOrNull()?:0.0

//                    if (systolicInt != null && diastolicInt != null) {
//                        val vitalStatus = when {
//                            systolicInt < 90 || diastolicInt < 60 -> "Low"
//                            systolicInt > 120 || diastolicInt > 80 -> "High"
//                            else -> "Medium"
//                        }

                IndoCommonCard(
                    vitalName = "Blood Diastolic",
                    vitalValue = diastolicInt.toString(),
                    vitalmass = "mmHg",
                    vitalHeading = BLOOD_PRESSURE_head,
                    vitalDescription = BLOOD_PRESSURE,
                    vitalCondition = "AVG 90 – 120 / 60 – 80",
                    vitalStatus = HealthStatusEvaluator.evaluateDiastolicStatus(diastolicInt)
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

        }



    }}

@Composable
fun BloodBiomarkers(results: MeasurementResults,modifier: Modifier = Modifier) {
    val scrollState = rememberScrollState()
    val sortedSignalIDs = remember(results) { results.allResults.keys.sorted() }
    val dynamicMap = mutableMapOf<String, String>()
    for(res in sortedSignalIDs){

        val siggResult =   results.result(res)
        dynamicMap[res]=siggResult.toString();
        Log.d(TAG, "sortedSignalIDs: $res")
        Log.d(TAG, "dynamicMap: $dynamicMap")
        Log.d(TAG, "sortedSignalIDs: $siggResult")
    }
    Card(colors = CardDefaults.cardColors(
        containerColor = Color(0xFFF7FAFD), // Light cyan background
        contentColor = Color.Black          // Text and icon color
    ),) {
        Column(
            modifier = modifier
                .fillMaxSize()
                .verticalScroll(scrollState)
                .padding(16.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
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
                    isLowGood = true,
                    vitalStatus = HealthStatusEvaluator.evaluateHoemoglobinA1CRiskStatus(riskProb)
                )
            }


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
                    isLowGood = true,
                    vitalCondition = "AVG 31 – 70",
                    vitalStatus =  HealthStatusEvaluator.evaluateHoemoglobinA1CRiskStatus(riskProb)
                )
            }

        }}
}
@Composable
fun Physiological(results: MeasurementResults,modifier: Modifier = Modifier) {
    val scrollState = rememberScrollState()
    val sortedSignalIDs = remember(results) { results.allResults.keys.sorted() }
    val dynamicMap = mutableMapOf<String, String>()
    for(res in sortedSignalIDs){

        val siggResult =   results.result(res)
        dynamicMap[res]=siggResult.toString();
        Log.d(TAG, "sortedSignalIDs: $res")
        Log.d(TAG, "dynamicMap: $dynamicMap")
        Log.d(TAG, "sortedSignalIDs: $siggResult")
    }
    Card(colors = CardDefaults.cardColors(
        containerColor = Color(0xFFF7FAFD), // Light cyan background
        contentColor = Color.Black          // Text and icon color
    ),) {
        Column(
            modifier = modifier
                .fillMaxSize()
                .verticalScroll(scrollState)
                .padding(16.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            dynamicMap["BP_RPP"]?.let {
                val formatted = formatMixedValue(it).toDoubleOrNull()?:0.0
                IndoCommonCard(
                    vitalName = "Cardiac Workload",
                    vitalValue = formatted.toString(),
                    vitalmass = "dB",
                    vitalDescription = CARDIAC_DIS,
                    vitalHeading = CARDIAC_WORKLOAD,
                    vitalCondition = "AVG 3.8– 4.1",
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
                    vitalCondition = "AVG 1 – 2.5",
                    vitalStatus = HealthStatusEvaluator.evaluateVascularCapacityStatus(formatted)
                )
            }
//                    }
            dynamicMap["HRV_SDNN"]?.let {
                val formatted = formatMixedValue(it).toDoubleOrNull()?:0.0
                IndoCommonCard(
                    vitalName = "Heart Rate Variability",
                    vitalValue = formatted.toString(),
                    vitalmass = "ms",
                    vitalDescription = HEART_RATE_VARIABILITY_DIS,
                    vitalHeading = HEART_RATE_VARIABILITY,
                    vitalCondition = "AVG 20 – 50",
                    vitalStatus = HealthStatusEvaluator.evaluateHeartRateVariabilityStatus(formatted))
            }

        }}
}
@Composable
fun Physical(results: MeasurementResults,modifier: Modifier = Modifier) {
    val scrollState = rememberScrollState()
    val sortedSignalIDs = remember(results) { results.allResults.keys.sorted() }
    val dynamicMap = mutableMapOf<String, String>()
    for(res in sortedSignalIDs){

        val siggResult =   results.result(res)
        dynamicMap[res]=siggResult.toString();
        Log.d(TAG, "sortedSignalIDs: $res")
        Log.d(TAG, "dynamicMap: $dynamicMap")
        Log.d(TAG, "sortedSignalIDs: $siggResult")
    }
    Card(colors = CardDefaults.cardColors(
        containerColor = Color(0xFFF7FAFD), // Light cyan background
        contentColor = Color.Black          // Text and icon color
    ),) {
        Column(
            modifier = modifier
                .fillMaxSize()
                .verticalScroll(scrollState)
                .padding(16.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
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
        }}
}
@Composable
fun Metadata(results: MeasurementResults,modifier: Modifier = Modifier) {
    val scrollState = rememberScrollState()
    val sortedSignalIDs = remember(results) { results.allResults.keys.sorted() }
    val dynamicMap = mutableMapOf<String, String>()
    for(res in sortedSignalIDs){

        val siggResult =   results.result(res)
        dynamicMap[res]=siggResult.toString();
        Log.d(TAG, "sortedSignalIDs: $res")
        Log.d(TAG, "dynamicMap: $dynamicMap")
        Log.d(TAG, "sortedSignalIDs: $siggResult")
    }
    Card(colors = CardDefaults.cardColors(
        containerColor = Color(0xFFF7FAFD), // Light cyan background
        contentColor = Color.Black          // Text and icon color
    ),) {
        Column(
            modifier = modifier
                .fillMaxSize()
                .verticalScroll(scrollState)
                .padding(16.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
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
        }}
}
@Composable
fun Mental(results: MeasurementResults,modifier: Modifier = Modifier) {
    val scrollState = rememberScrollState()
    val sortedSignalIDs = remember(results) { results.allResults.keys.sorted() }
    val dynamicMap = mutableMapOf<String, String>()
    for(res in sortedSignalIDs){

        val siggResult =   results.result(res)
        dynamicMap[res]=siggResult.toString();
        Log.d(TAG, "sortedSignalIDs: $res")
        Log.d(TAG, "dynamicMap: $dynamicMap")
        Log.d(TAG, "sortedSignalIDs: $siggResult")
    }
    Card(colors = CardDefaults.cardColors(
        containerColor = Color(0xFFF7FAFD), // Light cyan background
        contentColor = Color.Black          // Text and icon color
    ),) {
        Column(
            modifier = modifier
                .fillMaxSize()
                .verticalScroll(scrollState)
                .padding(16.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            dynamicMap["MSI"]?.let {
                val formatted = formatMixedValue(it)
                val numericValue = formatted.toIntOrNull() ?: 0

                IndoCommonCard(
                    vitalName = "Mental Stress Index",
                    vitalValue = formatted,
                    vitalDescription = MENNTAL_STRESS_DIS,
                    vitalHeading = MENTAL_SCORE,
                    vitalCondition = "AVG 3",
                    isLowGood = true,
                    vitalStatus = when (numericValue) {
                        1 -> "Very Low"
                        2->"Low"
                        3 -> "Medium"
                        4 -> "High"
                        5->"Very High"
                        else -> "Unknown"
                    }
                )
            }


        }}
}