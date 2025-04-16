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


@Composable
fun HealthDataList(results: MeasurementResults, modifier: Modifier = Modifier) {
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
        Row(horizontalArrangement = Arrangement.SpaceBetween) {
            Column {
                dynamicMap["BMI_CALC"]?.let {
                    CommonCard(
                        title = "Body Mass Index(BMI)",
                        subtitle = it
                    )
                }
                dynamicMap["ABSI"]?.let {  CommonCard(
                    title = "Body Shape Index",
                    subtitle = it,
                ) }

            }
            dynamicMap["HR_BPM"]?.let {  FullImageContentCard(
                title = "Heart Rate",
                centerText = it,
                mass =  "bpm",
                imageRes = R.drawable.heart_rate
            ) }

        }

        Row {
            dynamicMap["HRV_SDNN"]?.let { CommonCard(
                title = "Heart Rate Variability",
                subtitle = it,
                mass = "ms"

            )}
            dynamicMap["BP_RPP"]?.let {CommonCard(
                title = "Rate Pressure Product (RPP)",
                subtitle = it,
            )}


        }
        dynamicMap["BP_SYSTOLIC"]?.let {InfoCard(
            title = "Blood Pressure (Systolic/Diastolic)",
            subtitle = "${it}/${dynamicMap["BP_DIASTOLIC"]}",
            mass = "mmHg",
            imageRes = R.drawable.mask_group
        )}


        Row {
            dynamicMap["WAIST_CIRCUM"]?.let {CommonCard(
                title = "  Waist Circumference",
                subtitle = it,
                mass = "cm"

            )}
            dynamicMap["BP_TAU"]?.let { CommonCard(
                title = "Arterial Compliance",
                subtitle = it,

                )}


        }
//        dynamicMap["MENTAL_SCORE"]?.let {   SelectableCardRow(3)}



        Row {
            dynamicMap["IHB_COUNT"]?.let {    CenteredContentCard(
                title = "Hemoglobin Level",
                subtitle = it,
                mass = "g/dl",
                imageRes = R.drawable.blood
            )}

            dynamicMap["AGE"]?.let {     CenteredContentCard(
                title = "Age",
                isWidget = true,
                borderColor = Color(0xFF0072BC).copy(alpha = 0.2f),
                drawArcColor = Color(0xFF0072BC),
                value = it.toDouble(),
                maxProgress = 100f

                )}

        }

        Row {
            dynamicMap["HEALTH_SCORE"]?.let {      CenteredContentCard(
                title = "Overall Health Score",
                isWidgetWithText = true,
                borderColor = Color(0xFFFFFDDF),
                drawArcColor = Color(0xFFF7D100),
                value = it.toDouble(),
                maxProgress = 100f

                )}

            dynamicMap["MENTAL_SCORE"]?.let {      CenteredContentCard(
                title = "Mental Wellness Score",
                borderColor = Color(0xFF0072BC).copy(alpha = .53f),
                drawArcColor = Color(0xFF0072BC),
                value = it.toDouble(),
                isWidgetWithText = true,
                maxProgress = 5f

                )}


        }
        Row {
            dynamicMap["VITAL_SCORE"]?.let {      TitleWithImageSubtitleCard(
                title = "Vital Signs Score",
                subtitle = it,
                imageRes = R.drawable.vital_sign
            )}
            dynamicMap["PHYSICAL_SCORE"]?.let {      TitleWithImageSubtitleCard(

                title = "Physical Wellness Score",
                subtitle = it,
                imageRes = R.drawable.pws
            )}


        }
        Row {
            dynamicMap["BP_HEART_ATTACK"]?.let {        CenteredContentCard(
                title = "Heart Attack Risk Level",
                subtitle =it,
                imageRes = R.drawable.heart_risk_level
            )}
            dynamicMap["MSI"]?.let {         CenteredContentCard(
                title = "Metabolic Health Score (MSI)",
                subtitle = it,
                imageRes = R.drawable.msh
            )}

        }
        dynamicMap["BP_STROKE"]?.let {         InfoCard(
            title = "Stroke Risk Level",
            subtitle = it,
            imageRes = R.drawable.mask_group
        )}

        Row {
            dynamicMap["BP_CVD"]?.let {          CommonCard(
                title = "Cardiovascular Risk Level",
                subtitle = it
            )}
            dynamicMap["RISKS_SCORE"]?.let {          CommonCard(
                title = "Overall Risk Score",
                subtitle = it,
            )}

        }
        dynamicMap["SNR"]?.let {SNRCard(title = "Signal Quality(SNR)", subtitle =  results.snr.toString(), imageRes = R.drawable.snr)
        }

    } }

}
