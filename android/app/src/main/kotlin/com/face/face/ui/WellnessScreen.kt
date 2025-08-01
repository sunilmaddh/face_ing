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
import com.face.face.utils.CARDIAC_DIS
import com.face.face.utils.CARDIOVASCULAR_DISEASE_RISK
import com.face.face.utils.FATTY_LIVER_DISEASE_RISK
import com.face.face.utils.FATTY_LIV_DIA_RISK_DIS
import com.face.face.utils.HEART_ATTACK_RISK
import com.face.face.utils.HEART_ATTACK_RISK_DIS
import com.face.face.utils.HYPERCHOLESTEROLEMIA_RISK
import com.face.face.utils.HYPERCHOLE_EMIA_RISK_DIS
import com.face.face.utils.HYPERTENSION_RISK
import com.face.face.utils.HYPERTENTION_RISK_DIS
import com.face.face.utils.HYPERTRIGLYCERIDEMIA_RISK
import com.face.face.utils.HYPERTRIGLY_EMIA_RISK_DIS
import com.face.face.utils.HealthStatusEvaluator
import com.face.face.utils.MENTAL_SCORE
import com.face.face.utils.MENTAL_SCORE_DIS
import com.face.face.utils.METABOLIC_HEALTH_RISK
import com.face.face.utils.OVERALL_METABOLIC_HEALTH_RISK_DIS
import com.face.face.utils.PHYSICAL_SCORE
import com.face.face.utils.PHYSIOLOGICAL_SCORE
import com.face.face.utils.RISKS_SCORE
import com.face.face.utils.STROKE_RISK
import com.face.face.utils.STROKE_RISK_DIS
import com.face.face.utils.TYPE_2_DIABETES_RISK
import com.face.face.utils.TYPE_DIAB_RISK_DIS
import com.face.face.utils.VITALS_SCORE
import com.face.face.utils.general_health_des


@Composable
fun GeneralRisks(results: MeasurementResults,modifier: Modifier = Modifier) {

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
    ),) {  Column(
        modifier = modifier
            .fillMaxSize()
            .verticalScroll(scrollState)
            .padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {

        dynamicMap["BP_CVD"]?.let {
            val formatted = formatMixedValue(it)
            val riskValue = formatted.toString().toDoubleOrNull() ?: 0.0
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
                    vitalStatus = HealthStatusEvaluator.evaluateCardiovascularDiseaseRiskStatus(
                        riskValue
                    )
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
                    vitalStatus = HealthStatusEvaluator.evaluate1HeartAttackRiskStatus(riskValue)
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
                        vitalStatus = HealthStatusEvaluator.evaluateStrokeRiskStatus(strokeRisk)
                    )
                }}
        } }


}}
@Composable
fun MetabolicRisks(results: MeasurementResults,modifier: Modifier = Modifier) {

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
    ),) {  Column(
        modifier = modifier
            .fillMaxSize()
            .verticalScroll(scrollState)
            .padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {


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

    } }}



@Composable
fun HealthScore(results: MeasurementResults,modifier: Modifier = Modifier) {

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
    ),) {  Column(
        modifier = modifier
            .fillMaxSize()
            .verticalScroll(scrollState)
            .padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
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
                vitalStatus = HealthStatusEvaluator.evaluateMentalStressIndexStatus(numericValue)
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


    } }


}