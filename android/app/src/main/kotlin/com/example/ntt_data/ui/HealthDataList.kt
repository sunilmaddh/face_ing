package com.example.ntt_data.ui

import CenteredContentCard
import CommonCard
import InfoCard
import SNRCard
import TitleWithImageSubtitleCard
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.example.ntt_data.R


@Composable
fun HealthDataList(modifier: Modifier = Modifier) {
    val scrollState = rememberScrollState()

    Column(
        modifier = modifier
            .fillMaxSize()
            .verticalScroll(scrollState)
            .padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Row(horizontalArrangement = Arrangement.SpaceBetween) {
            Column {
                CommonCard(
                    title = "Body Mass Index(BMI)",
                    subtitle = "1111"
                )
                CommonCard(
                    title = "Body Shape Index",
                    subtitle = "0.078",
                )
            }

            FullImageContentCard(
                title = "Heart Rate",
                centerText = "0.222",
                imageRes = R.drawable.heart_rate
            )
        }

        Row {
            CommonCard(
                title = "Heart Rate Variability",
                subtitle = "45",
                mass = "ms"

            )
            CommonCard(
                title = "Rate Pressure Product (RPP)",
                subtitle = "900",
            )
        }

        InfoCard(
            title = "Blood Pressure (Systolic/Diastolic)",
            subtitle = "118/78",
            mass = "mmHg",
            imageRes = R.drawable.mask_group
        )

        Row {
            CommonCard(
                title = "  Waist Circumference",
                subtitle = "82",
                mass = "cm"

            )
            CommonCard(
                title = "Arterial Compliance",
                subtitle = "1.78",

            )
        }
        SelectableCardRow()

        Row {         CenteredContentCard(
       title = "Hemoglobin Level",
       subtitle = ".3.45",
            mass = "g/dl",


       imageRes = R.drawable.blood
   )
       CenteredContentCard(
           title = "Age",
           isWidget = true,
           imageRes = R.drawable.blood
       )
   }

        Row {
            CenteredContentCard(
                title = "Overall Health Score",
                isWidgetWithText = true,
                imageRes = R.drawable.blood
            )
            CenteredContentCard(
                title = "Physical Wellness Score",
                isWidgetWithText = true,
                imageRes = R.drawable.blood
            )
        }
        Row {
            TitleWithImageSubtitleCard(
                title = "Vital Signs Score",
                subtitle = "86",
                imageRes = R.drawable.vital_sign
            )
            TitleWithImageSubtitleCard(
                title = "Physical Wellness Score",
                subtitle = "78",
                imageRes = R.drawable.vital_sign
            )
        }
        Row {   CenteredContentCard(
            title = "Overall Health Score",
            subtitle = "Low",
            imageRes = R.drawable.heart_risk_level
        )
            CenteredContentCard(
                title = "Physical Wellness Score",
                subtitle = "78",
                imageRes = R.drawable.msh
            ) }
        InfoCard(
            title = "Stroke Risk Level",
            subtitle = "Moderate",
            imageRes = R.drawable.mask_group
        )
        Row {   CommonCard(
            title = "Cardiovascular Risk Level",
            subtitle = "Moderate"
        )
            CommonCard(
                title = "Overall Risk Score",
                subtitle = "45%d",
            ) }
        SNRCard(title = "Signal Quality(SNR)", subtitle = "Good (NR: 30 dB)", imageRes = R.drawable.heart_rate)

    }
}
