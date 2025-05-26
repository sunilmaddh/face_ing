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
import androidx.compose.ui.unit.dp
import com.example.ntt_data.R
import com.example.ntt_data.measurement.AnuraExampleMeasurementActivity.Companion.TAG

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
                CenteredContentCard(
                    width = 450.0,
                    title = "General Health Score",

                    isFullWidth = true,

                    subtitle = formatted,

                    imageRes = R.drawable.over_health
                )
            }
            Row(horizontalArrangement = Arrangement.SpaceBetween) {

                dynamicMap["BR_BPM"]?.let {
                    val formatted = formatMixedValue(it)
                    TitleWithImageSubtitleCard(
                        title = "Breathing Rate",
                        subtitle = formatted,
                        mass = "rpm",

                        imageRes = R.drawable.vital_sign
                    )
                }
                dynamicMap["HR_BPM"]?.let {
                    val formatted = formatMixedValue(it)
                    FullImageContentCard(
                        title = "Heart Rate",
                        centerText = formatted,
                        mass = "bpm",
                        imageRes = R.drawable.heart_rate
                    )
                }

            }
            dynamicMap["BP_SYSTOLIC"]?.let { systolic ->
                val systolicInt = (dynamicMap["BP_SYSTOLIC"]?.toString()?.toDoubleOrNull())?.toInt()
                val diastolicInt =
                    (dynamicMap["BP_DIASTOLIC"]?.toString()?.toDoubleOrNull())?.toInt()
                if (systolicInt != null && diastolicInt != null) {
                    InfoCard(
                        title = "Blood Pressure",
                        subtitle = "$systolicInt/$diastolicInt",
                        mass = "mmHg",
                        imageRes = R.drawable.mask_group
                    )
                }

                Row {
                    dynamicMap["IHB_COUNT"]?.let {
                        val formatted = formatMixedValue(it)
                        CommonCard(
                            title = "Irregular Heartbeat Count",
                            subtitle = formatted,



                            )
                    }
                    dynamicMap["HBA1C_RISK_PROB"]?.let {
                        val formatted = formatMixedValue(it)
                        CommonCard(
                            title = "Hemoglobin A1C Risk",
                            subtitle =formatted,
                            perMass = "%"
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


                }
                Row {
                    dynamicMap["MFBG_RISK_PROB"]?.let {
                        val formatted = formatMixedValue(it)
                        CommonCard(
                            title = "Fasting Blood Glucose Risk",
                            subtitle = formatted ,
                            perMass = "%"


                            )
                    }
                    dynamicMap["BP_CVD"]?.let {
                        val formatted = formatMixedValue(it)
                        CommonCard(
                            title = "Cardiovascular Risk Level",
                            subtitle = formatted,
                            perMass = "%"

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


                }

                dynamicMap["BP_HEART_ATTACK"]?.let {
                    val formatted = formatMixedValue(it)
                    SNRCard(
                        title = "Heart Attack Risk",
                        subtitle = formatted,
                        imageRes = R.drawable.snr,
                        perMass = "%"
                    )


                    Row {
                        dynamicMap["BP_STROKE"]?.let {
//                            val formatted = formatMixedValue(it)
                            CenteredContentCard(
                                title = "Stroke Risk",
                                isWidgetWithText = true,
                                borderColor = Color(0xFFFFFDDF),
                                drawArcColor = Color(0xFFF7D100),
                                value = it.toDouble(),
                                maxProgress = 100f,
                                perMass = "%"


                                )
                        }

                        dynamicMap["DBT_RISK_PROB"]?.let {
                            val formatted = formatMixedValue(it)
                            CenteredContentCard(
                                title = " Diabetes Risk",
                                borderColor = Color(0xFF0072BC).copy(alpha = .53f),
                                drawArcColor = Color(0xFF0072BC),
                                value = formatted.toDouble(),
                                isWidgetWithText = true,
                                maxProgress = 5f,
                                perMass = "%"


                            )
                        }
                    }


//        dynamicMap["BP_SYSTOLIC"]?.let {InfoCard(
//            title = "Blood Pressure (Systolic/Diastolic)",
//            subtitle = "${it.toIntOrNull()}/${dynamicMap["BP_DIASTOLIC"]?.toIntOrNull()}",
//            mass = "mmHg",
//            imageRes = R.drawable.mask_group
//        )}


                    Row {
                        dynamicMap["FLD_RISK_PROB"]?.let {
                            val formatted = formatMixedValue(it)
                            CommonCard(
                                title = "Fatty Liver Disease Risk",
                                subtitle =  formatted,
                                perMass = "%"


                            )
                        }
                        dynamicMap["HDLTC_RISK_PROB"]?.let {
                            val formatted = formatMixedValue(it)
                            CommonCard(
                                title = "Hypercholesterolemia Risk",
                                subtitle = formatted,
                                perMass = "%"

                            )
                        }


                    }
                    Row {
                        dynamicMap["HPT_RISK_PROB"]?.let {
                            val formatted = formatMixedValue(it)
                            CenteredContentCard(
                                title = "Hypertension Risk",
                                isWidgetWithText = true,
                                borderColor = Color(0xFFFFFDDF),
                                drawArcColor = Color(0xFFF7D100),
                                value = formatted.toDouble(),
                                maxProgress = 100f,
                                perMass = "%"

                            )
                        }

                        dynamicMap["OVERALL_METABOLIC_RISK_PROB"]?.let {
                            val formatted = formatMixedValue(it)
                            CenteredContentCard(
                                title = " Overall Metabolic Health Risk",
                                borderColor = Color(0xFF0072BC).copy(alpha = .53f),
                                drawArcColor = Color(0xFF0072BC),
                                value =formatted.toDouble(),
                                isWidgetWithText = true,
                                maxProgress = 5f,
                                perMass = "%"


                            )
                        }
                    }
                    Row {
                        dynamicMap["TG_RISK_PROB"]?.let {
                            val formatted = formatMixedValue(it)
                            TitleWithImageSubtitleCard(
                                title = "Hypertriglyceridemia Risk",
                                subtitle = formatted,
                                perMass = "%",


                                imageRes = R.drawable.vital_sign
                            )
                        }
                        dynamicMap["MENTAL_SCORE"]?.let {
                            val formatted = formatMixedValue(it)
                            TitleWithImageSubtitleCard(

                                title = "Mental Score",
                                subtitle = formatted,
                                imageRes = R.drawable.pws
                            )
                        }
                    }
                    Row {
                        dynamicMap["PHYSICAL_SCORE"]?.let {
                            val formatted = formatMixedValue(it)
                            TitleWithImageSubtitleCard(

                                title = "Physical Score",
                                subtitle = formatted,
                                imageRes = R.drawable.pws
                            )
                        }
                        dynamicMap["PHYSIO_SCORE"]?.let {
                            val formatted = formatMixedValue(it)
                            TitleWithImageSubtitleCard(
                                title = "Physiological Score",
                                subtitle = formatted,
                                imageRes = R.drawable.vital_sign
                            )
                        }
                    }
                    Row {
                        dynamicMap["RISKS_SCORE"]?.let {
                            val formatted = formatMixedValue(it)
                            TitleWithImageSubtitleCard(
                                title = "Risk Score",
                                subtitle = formatted,
                                imageRes = R.drawable.risk_score
                            )
                        }
                        dynamicMap["VITAL_SCORE"]?.let {
                            val formatted = formatMixedValue(it)
                            TitleWithImageSubtitleCard(
                                title = "Vital Signs Score",
                                subtitle = formatted,
                                imageRes = R.drawable.risk_score
                            )
                        }
                    }
                    dynamicMap["MSI"]?.let {
                        val formatted = formatMixedValue(it)
                        SNRCard(
                            title = "Mental Stress Index",
                            subtitle = formatted,
                            imageRes = R.drawable.snr
                        )
                    }
                    Row {
                        dynamicMap["BP_RPP"]?.let {
                            val formatted = formatMixedValue(it)
                            CenteredContentCard(
                                title = "Cardiac Workload",
                                subtitle = formatted,
                                imageRes = R.drawable.heart_risk_level,
                                mass = "dB"
                            )
                        }
                        dynamicMap["BP_TAU"]?.let {
                            val formatted = formatMixedValue(it)
                            CenteredContentCard(
                                title = "Vascular Capacity",
                                subtitle = formatted,
                                mass = "seconds",
                                imageRes = R.drawable.vascular
                            )
                        }

                    }
                    dynamicMap["HRV_SDNN"]?.let {
                        val formatted = formatMixedValue(it)

                        InfoCard(
                            title = "Heart Rate Variability",
                            subtitle = formatted,
                            mass = "ms",
                            imageRes = R.drawable.mask_group
                        )
                    }

                    Row(
                        horizontalArrangement =Arrangement.Start ,
                        ) {
                        dynamicMap["AGE"]?.let {
                            val formatted = formatMixedValue(it)
                            CenteredContentCard(
                                title = "Facial Skin Age",
                                isWidget = true,
                                borderColor = Color(0xFF0072BC).copy(alpha = 0.2f),
                                drawArcColor = Color(0xFF0072BC),
                                value = formatted.toDouble(),
                                maxProgress = 100f,
                                mass = "years"

                            )
                        }
                        dynamicMap["SNR"]?.let {
                            val formatted = formatMixedValue(it)
                            CommonCard(
                                title = "Signal-to-Noise Ratio",
                                subtitle = formatted,
                                mass = "dB",

                                )
                        }


                    }
                }
            }
        }
    }




}

