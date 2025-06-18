package com.example.ntt_data.ui

import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Divider
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.SpanStyle
import androidx.compose.ui.text.buildAnnotatedString
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.withStyle
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.ntt_data.R

@Composable
fun IndoCommonCard(
    vitalName: String = "",
    vitalStatus: String = "",
    vitalValue: String = "",
    vitalHeading: String = "",
    vitalDescription: String = "",
    vitalCondition: String = "",
    vitalmass: String = "",
    isBlood:Boolean=false,
    isLowGood:Boolean=false,
    isBreathing:Boolean=false

) {

    val statusLower = vitalStatus
    val imageRes = when (statusLower) {
        "Very Low" ->if(isBreathing)R.drawable.mild_imo else if(isBlood)R.drawable.low_imo   else if (isLowGood) R.drawable.very_high_imo else R.drawable.low_imo
        "Low" ->if (isLowGood) R.drawable.high_imo else R.drawable.normal_imo
        "Normal" -> R.drawable.very_high_imo
        "Medium" -> R.drawable.mild_imo
        "High" ->if(isBreathing)R.drawable.mild_imo else if (isLowGood) R.drawable.normal_imo else R.drawable.high_imo
            "Very High"-> if(isBlood)R.drawable.low_imo   else if(isLowGood) R.drawable.low_imo else R.drawable.very_high_imo
        "Optimal"->R.drawable.very_high_imo
        else -> R.drawable.very_high_imo
    }
    val colors = when (statusLower) {
        "Very Low" ->if(isBlood)Color(0xFFFA704E)   else if(isLowGood)Color(0xFF1BC76D)else Color(0xFFFA704E)
        "Low" -> if(isBreathing)Color(0xFFEEC000) else if(isLowGood)Color(0xFF9ED042)else Color(0xFFED9A33)
        "Normal" -> Color(0xFF1BC76D)
        "Medium" ->Color(0xFFEEC000)
        "Optimal"->Color(0xFF1BC76D)
        "Very High" ->if(isLowGood)Color(0xFFFA704E)else Color(0xFF1BC76D)
        "High" ->if(isBreathing)Color(0xFFEEC000) else if(isBlood)Color(0xFFED9A33) else if(isLowGood)Color(0xFFED9A33)else Color(0xFF9ED042)
        else-> Color(0xFFFFFFFF)

    }
    val status = when (statusLower) {
        "Very Low" -> "Very Low"
        "Low" -> "Low"
        "Normal" -> "Normal"
        "Medium" -> "Medium"
        "High" -> "High"
        "Optimal"->"Optimal"
        "Very High"->"Very High"
        else -> ""
    }

    Card(
        shape = RoundedCornerShape(16.dp),
        colors = CardDefaults.cardColors(containerColor = Color.White),
        modifier = Modifier
            .fillMaxWidth()
            .padding(8.dp)
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .wrapContentHeight()
        ) {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .height(210.dp)
                    .background(Color.White)
            ) {
                Box(
                    modifier = Modifier
                        .width(120.dp)
                        .height(210.dp)

                ) {
                    Column(
                        horizontalAlignment = Alignment.Start,
                        modifier = Modifier
                            .padding(horizontal = 5.dp, vertical = 10.dp)
                            .fillMaxSize()
                    ) {
                     if (vitalStatus.isNotEmpty()){ Image(
                         painter = painterResource(id = imageRes),
                         contentDescription = null,
                         contentScale = ContentScale.Crop,
                         modifier = Modifier.size(37.dp)
                     )}

                        Spacer(Modifier.height(5.dp))
                        Text(
                            text = vitalName,
                            style = MaterialTheme.typography.titleMedium.copy(lineHeight = 15.sp),
                            fontSize = 14.sp,
                            fontWeight = FontWeight.W400,
                            color = Color(0xff575656)
                        )
                        Spacer(Modifier.height(5.dp))
                        Text(
                            text = vitalCondition,
                            style = MaterialTheme.typography.titleMedium.copy(lineHeight = 15.sp),
                            fontSize = 10.sp,
                            fontWeight = FontWeight.W400,
                            color = Color(0xff575656)
                        )
                        Spacer(Modifier.height(10.dp))
                        Text(
                            buildAnnotatedString {
                                withStyle(
                                    style = SpanStyle(
                                        fontSize = 26.sp,
                                        color = Color(0xff4A4949),
                                        fontWeight = FontWeight.W400
                                    )
                                ) {
                                    append(vitalValue)
                                }
                                append(" ")
                                withStyle(
                                    style = SpanStyle(
                                        fontSize = 14.sp,
                                        fontWeight = FontWeight.W400,
                                        color = Color(0xff4A4949)
                                    )
                                ) {
                                    append(vitalmass)
                                }
                            }
                        )
                    }
                }

                Box(
                    modifier = Modifier
                        .width(2.dp)

                        .height(180.dp)
                        .background(color = Color(0xffD9D9D9))
                )

                Box(
                    modifier = Modifier
                        .height(195.dp)
                        .background(color = Color.White)
                ) {
                    Column(
                        horizontalAlignment = Alignment.Start,
                        modifier = Modifier.padding(8.dp)
                    ) {
                        Text(
                            text = "$vitalHeading $status",
                            style = MaterialTheme.typography.titleMedium.copy(lineHeight = 15.sp),
                            fontSize = 16.sp,
                            fontWeight = FontWeight.W400,
                            color = Color(0xff5E5D5D)
                        )
                        Spacer(Modifier.height(10.dp))
                        Text(
                            text = vitalDescription,
                            style = MaterialTheme.typography.titleMedium.copy(lineHeight = 15.sp),
                            fontSize = 12.sp,
                            fontWeight = FontWeight.W400,
                            color = Color(0xff5E5D5D)
                        )

                        Spacer(Modifier.height(20.dp))
                        Row(
                            modifier = Modifier.fillMaxWidth(),
                            horizontalArrangement = Arrangement.SpaceBetween,
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            if(vitalStatus.isNotEmpty())
                            Row(verticalAlignment = Alignment.CenterVertically) {
                                Card(
                                    shape = CircleShape,
                                    colors = CardDefaults.cardColors(containerColor = colors),
                                    modifier = Modifier.size(21.dp)
                                ) {}

                                Spacer(modifier = Modifier.width(10.dp))

                                Text(
                                    text = status,
                                    fontSize = 14.sp,
                                    fontWeight = FontWeight.W400,
                                    color = colors,
                                    style = MaterialTheme.typography.titleMedium
                                )
                            }



                        }
                       }
                }
            }

            }
        }
    }

