package com.face.face.ui

import ai.nuralogix.anurasdk.core.result.MeasurementResults
import android.util.Log
import androidx.compose.foundation.layout.Column
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
import androidx.compose.ui.unit.dp
import com.face.face.measurement.FaceAnuraMeasurementActivity.Companion.TAG
import com.face.face.utils.BLOOD_PRESSURE_DIASTOLIC
import com.face.face.utils.BLOOD_PRESSURE_DI_DIS
import com.face.face.utils.BLOOD_PRESSURE_SYSTOLIC
import com.face.face.utils.BLOOD_PRESSURE_SY_DIS
import com.face.face.utils.BREATHING_RATE
import com.face.face.utils.BREATHIN_RATW_DIS
import com.face.face.utils.CARDIAC_DIS
import com.face.face.utils.CARDIAC_WORKLOAD
import com.face.face.utils.FACIAL_SKIN_AGE
import com.face.face.utils.FACIAL_SKIN_AGE_DIS
import com.face.face.utils.FASTING_BLOOD_GLUCOSE_RISK
import com.face.face.utils.FASTING_GLUCOSE_RISK_DIS
import com.face.face.utils.HEART_RATE
import com.face.face.utils.HEART_RATE_VARIABILITY
import com.face.face.utils.HEART_RATE_VARIABILITY_DIS
import com.face.face.utils.HEMOGLOBIN_A1C_RISK
import com.face.face.utils.HEMOGLOBIN_A1_DIS
import com.face.face.utils.HealthStatusEvaluator
import com.face.face.utils.IRREGULAR_HEARTBEAT_COUNT
import com.face.face.utils.IRREGULAR_HEART_DIS
import com.face.face.utils.MENNTAL_STRESS_DIS
import com.face.face.utils.MENTAL_SCORE
import com.face.face.utils.PULSE_RATE
import com.face.face.utils.S_N_R
import com.face.face.utils.S_N_R_Description
import com.face.face.utils.VASCULAR_CAPACITY
import com.face.face.utils.VASCULAR_CAPACITY_DIS


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
                    vitalStatus = HealthStatusEvaluator.elevateBreathingStatus(value)
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
                    isBreathing = true,
                    vitalmass = "bpm",
                    vitalDescription = HEART_RATE,
                    vitalHeading = PULSE_RATE,
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
                    vitalStatus = HealthStatusEvaluator.evaluateHoemoglobinA1CRiskStatus(riskProb)
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
                    vitalStatus = HealthStatusEvaluator.evaluateHeartRateVariabilityStatus(formatted)
                )
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
                    vitalHeading = FACIAL_SKIN_AGE,
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
                IndoCommonCard(
                    vitalName = "Signal-to-Noise Ratio",
                    vitalValue = formatted,
                    vitalmass = "dB",
                    vitalDescription = S_N_R_Description,
                    vitalHeading = S_N_R,


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
                val numericValue = formatted.toDoubleOrNull() ?: 0.0

                IndoCommonCard(
                    vitalName = "Mental Stress Index",
                    vitalValue = formatted,
                    vitalDescription = MENNTAL_STRESS_DIS,
                    vitalHeading = MENTAL_SCORE,

                    isLowGood = true,
                    vitalStatus = HealthStatusEvaluator.evaluateMentalStressIndexStatus1(
                        numericValue
                    )
                )
            }


        }}
}