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
import androidx.compose.foundation.layout.fillMaxWidth
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
        dynamicMap["HEALTH_SCORE"]?.let {         CenteredContentCard(
            width = 450.0,
            title = "Overall Health Score",

            subtitle = it,

            imageRes = R.drawable.msh
        )}
        Row(horizontalArrangement = Arrangement.SpaceBetween) {
            Column {
                dynamicMap["AGE"]?.let {
                    CenteredContentCard(
                        title = "Facial Skin Age",
                        isWidget = true,
                        borderColor = Color(0xFF0072BC).copy(alpha = 0.2f),
                        drawArcColor = Color(0xFF0072BC),
                        value = it.toDouble(),
                        maxProgress = 100f,
                        mass = "years"

                    )
                }
//                dynamicMap["HEALTH_SCORE"]?.let {         CenteredContentCard(
//                    title = "Overall Health Score",
//                    subtitle = it,
//
//                    imageRes = R.drawable.msh
//                )}
                dynamicMap["BR_BPM"]?.let {      TitleWithImageSubtitleCard(
                    title = "Breathing Rate",
                    subtitle = it,
                    mass = "rpm",

                    imageRes = R.drawable.vital_sign
                )}
//                dynamicMap["BMI_CALC"]?.let {
//                    CommonCard(
//                        title = "Body Mass Index(BMI)",
//                        subtitle = it
//                    )
//                }
//                dynamicMap["ABSI"]?.let {  CommonCard(
//                    title = "Body Shape Index",
//                    subtitle = it,
//                ) }

            }
            dynamicMap["HR_BPM"]?.let {  FullImageContentCard(
                title = "Heart Rate",
                centerText = it,
                mass =  "bpm",
                imageRes = R.drawable.heart_rate
            ) }

        }
        dynamicMap["BP_SYSTOLIC"]?.let { systolic ->
            val systolicInt = (dynamicMap["BP_SYSTOLIC"]?.toString()?.toDoubleOrNull())?.toInt()
            val diastolicInt = (dynamicMap["BP_DIASTOLIC"]?.toString()?.toDoubleOrNull())?.toInt()
            if (systolicInt != null && diastolicInt != null) {
                InfoCard(
                    title = "Blood Pressure (Systolic/Diastolic)",
                    subtitle = "$systolicInt/$diastolicInt",
                    mass = "mmHg",
                    imageRes = R.drawable.mask_group
                )
            }

        Row {
            dynamicMap["IHB_COUNT"]?.let { CommonCard(
                title = "Irregular Heartbeat Count",
                subtitle = it,


            )}
            dynamicMap["HBA1C_RISK_PROB"]?.let {CommonCard(
                title = "Hemoglobin A1C Risk",
                subtitle = "$it %"

            )}
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
                dynamicMap["MFBG_RISK_PROB"]?.let { CommonCard(
                    title = "Fasting Blood Glucose Risk",
                    subtitle =  "$it %",


                )}
                dynamicMap["BP_CVD"]?.let {CommonCard(
                    title = "Cardiovascular Risk Level",
                    subtitle =  "$it %",

                )}
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

            dynamicMap["BP_HEART_ATTACK"]?.let {SNRCard(title = "Heart Attack Risk", subtitle =  results.snr.toString(), imageRes = R.drawable.snr,)


                Row {
                    dynamicMap["BP_STROKE"]?.let {
                        CenteredContentCard(
                            title = "Stroke Risk",
                            isWidgetWithText = true,
                            borderColor = Color(0xFFFFFDDF),
                            drawArcColor = Color(0xFFF7D100),
                            value = it.toDouble()  ,
                            maxProgress = 100f,



                        )
                    }

                    dynamicMap["DBT_RISK_PROB"]?.let {
                        CenteredContentCard(
                            title = " Diabetes Risk",
                            borderColor = Color(0xFF0072BC).copy(alpha = .53f),
                            drawArcColor = Color(0xFF0072BC),
                            value = it.toDouble(),
                            isWidgetWithText = true,
                            maxProgress = 5f,
                            mass = "%"

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
            dynamicMap["FLD_RISK_PROB"]?.let {CommonCard(
                title = "Fatty Liver Disease Risk",
                subtitle = it,
                mass = "%"

            )}
            dynamicMap["HDLTC_RISK_PROB"]?.let { CommonCard(
                title = "Hypercholesterolemia Risk",
                subtitle = it,
                mass = "%"

                )}


        }
                    Row {
                        dynamicMap["HPT_RISK_PROB"]?.let {
                            CenteredContentCard(
                                title = "Hypertension Risk",
                                isWidgetWithText = true,
                                borderColor = Color(0xFFFFFDDF),
                                drawArcColor = Color(0xFFF7D100),
                                value = it.toDouble(),
                                maxProgress = 100f,
                                mass = "%"

                            )
                        }

                        dynamicMap["OVERALL_METABOLIC_RISK_PROB"]?.let {
                            CenteredContentCard(
                                title = " Overall Metabolic Health Risk",
                                borderColor = Color(0xFF0072BC).copy(alpha = .53f),
                                drawArcColor = Color(0xFF0072BC),
                                value = it.toDouble(),
                                isWidgetWithText = true,
                                maxProgress = 5f,
                                mass = "%"

                            )
                        }}
                        Row {
                            dynamicMap["TG_RISK_PROB"]?.let {
                                TitleWithImageSubtitleCard(
                                    title = "Hypertriglyceridemia Risk",
                                    subtitle = it,
                                    mass = "%",

                                    imageRes = R.drawable.vital_sign
                                )
                            }
                            dynamicMap["MENTAL_SCORE"]?.let {
                                TitleWithImageSubtitleCard(

                                    title = "Mental Score",
                                    subtitle = it,
                                    imageRes = R.drawable.pws
                                )
                            }}
                            Row {
                                dynamicMap["PHYSICAL_SCORE"]?.let {
                                    TitleWithImageSubtitleCard(

                                        title = "Physical Score",
                                        subtitle = it,
                                        imageRes = R.drawable.pws
                                    )
                                }
                                dynamicMap["PHYSIO_SCORE"]?.let {
                                    TitleWithImageSubtitleCard(
                                        title = "Physiological Score",
                                        subtitle = it,
                                        imageRes = R.drawable.vital_sign
                                    )
                                }
                            }
                            Row {
                                dynamicMap["RISKS_SCORE"]?.let {
                                    CenteredContentCard(
                                        title = "Risk Score",
                                        subtitle = it,
                                        imageRes = R.drawable.msh
                                    )
                                }
                                dynamicMap["VITAL_SCORE"]?.let {
                                    CenteredContentCard(
                                        title = "Vital Signs Score",
                                        subtitle = it,
                                        imageRes = R.drawable.msh
                                    )
                                }
                            }
                            dynamicMap["MSI"]?.let {
                                SNRCard(
                                    title = "Mental Stress Index",
                                    subtitle = results.snr.toString(),
                                    imageRes = R.drawable.snr
                                )}
                                Row {
                                    dynamicMap["BP_RPP"]?.let {
                                        CenteredContentCard(
                                            title = "Cardiac Workload",
                                            subtitle = it,
                                            imageRes = R.drawable.heart_risk_level,
                                            mass = "dB"
                                        )
                                    }
                                    dynamicMap["BP_TAU"]?.let {
                                        CenteredContentCard(
                                            title = "Vascular Capacity",
                                            subtitle = it,
                                            mass = "seconds",
                                            imageRes = R.drawable.heart_risk_level
                                        )
                                    }

                                }
                dynamicMap["HRV_SDNN"]?.let {
                    val formatted = (it as? Number)?.toDouble()?.let { num ->
                        String.format("%.1f", num)
                    } ?: it.toString()

                    InfoCard(
                        title = "Heart Rate Variability",
                        subtitle = formatted,
                        mass = "ms",
                        imageRes = R.drawable.mask_group
                    )
                }

                                Row {
                                    dynamicMap["AGE"]?.let {
                                        CenteredContentCard(
                                            title = "Facial Skin Age",
                                            isWidget = true,
                                            borderColor = Color(0xFF0072BC).copy(alpha = 0.2f),
                                            drawArcColor = Color(0xFF0072BC),
                                            value = it.toDouble(),
                                            maxProgress = 100f,
                                            mass = "years"

                                        )
                                    }

                                    dynamicMap["SNR"]?.let {
                                        CommonCard(
                                            title = "Signal-to-Noise Ratio",
                                            subtitle = it,
                                            mass = "g/dl",

                                            )
                                    }


                                }}}}}}

//        dynamicMap["MENTAL_SCORE"]?.let {   SelectableCardRow(3)}


//                                Row {
//                                    dynamicMap["IHB_COUNT"]?.let {
//                                        CenteredContentCard(
//                                            title = "Hemoglobin Level",
//                                            subtitle = it,
//                                            mass = "g/dl",
//                                            imageRes = R.drawable.blood
//                                        )
//                                    }
//
//                                    dynamicMap["AGE"]?.let {
//                                        CenteredContentCard(
//                                            title = "Age",
//                                            isWidget = true,
//                                            borderColor = Color(0xFF0072BC).copy(alpha = 0.2f),
//                                            drawArcColor = Color(0xFF0072BC),
//                                            value = it.toDouble(),
//                                            maxProgress = 100f
//
//                                        )
//                                    }
//
//                                }
//
//                                Row {
//                                    dynamicMap["HEALTH_SCORE"]?.let {
//                                        CenteredContentCard(
//                                            title = "Overall Health Score",
//                                            isWidgetWithText = true,
//                                            borderColor = Color(0xFFFFFDDF),
//                                            drawArcColor = Color(0xFFF7D100),
//                                            value = it.toDouble(),
//                                            maxProgress = 100f
//
//                                        )
//                                    }
//
//                                    dynamicMap["MENTAL_SCORE"]?.let {
//                                        CenteredContentCard(
//                                            title = "Mental Wellness Score",
//                                            borderColor = Color(0xFF0072BC).copy(alpha = .53f),
//                                            drawArcColor = Color(0xFF0072BC),
//                                            value = it.toDouble(),
//                                            isWidgetWithText = true,
//                                            maxProgress = 5f
//
//                                        )
//                                    }
//
//
//                                }
//                                Row {
//                                    dynamicMap["VITAL_SCORE"]?.let {
//                                        TitleWithImageSubtitleCard(
//                                            title = "Vital Signs Score",
//                                            subtitle = it,
//                                            imageRes = R.drawable.vital_sign
//                                        )
//                                    }
//                                    dynamicMap["PHYSICAL_SCORE"]?.let {
//                                        TitleWithImageSubtitleCard(
//
//                                            title = "Physical Wellness Score",
//                                            subtitle = it,
//                                            imageRes = R.drawable.pws
//                                        )
//                                    }
//
//
//                                }
//                                Row {
//                                    dynamicMap["BP_HEART_ATTACK"]?.let {
//                                        CenteredContentCard(
//                                            title = "Heart Attack Risk Level",
//                                            subtitle = it,
//                                            imageRes = R.drawable.heart_risk_level
//                                        )
//                                    }
//                                    dynamicMap["MSI"]?.let {
//                                        CenteredContentCard(
//                                            title = "Metabolic Health Score (MSI)",
//                                            subtitle = it,
//                                            imageRes = R.drawable.msh
//                                        )
//                                    }
//
//                                }
//                                dynamicMap["BP_STROKE"]?.let {
//                                    InfoCard(
//                                        title = "Stroke Risk Level",
//                                        subtitle = it,
//                                        imageRes = R.drawable.mask_group
//                                    )
//                                }
//
//                                Row {
//                                    dynamicMap["BP_CVD"]?.let {
//                                        CommonCard(
//                                            title = "Cardiovascular Risk Level",
//                                            subtitle = it
//                                        )
//                                    }
//                                    dynamicMap["RISKS_SCORE"]?.let {
//                                        CommonCard(
//                                            title = "Overall Risk Score",
//                                            subtitle = it,
//                                        )
//                                    }
//
//                                }
//                                dynamicMap["SNR"]?.let {
//                                    SNRCard(
//                                        title = "Signal Quality(SNR)",
//                                        subtitle = results.snr.toString(),
//                                        imageRes = R.drawable.snr
//                                    )
//                                }
//
//                            }
//                        }
//
//                    }
