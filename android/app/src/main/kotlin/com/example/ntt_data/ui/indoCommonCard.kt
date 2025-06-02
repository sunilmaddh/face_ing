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
) {
    val imageRes = when (vitalStatus) {
        "High" -> R.drawable.high
        "medium" -> R.drawable.medium
        else -> R.drawable.low
    }
    val colors = when (vitalStatus) {
        "High" -> Color(0xFF1BC76D)
        "medium" -> Color(0xFFEEC000)
        else -> Color(0xFFFA704E)
    }
    val status = when (vitalStatus) {
        "High" -> "High"
        "medium" -> "Medium"
        else -> "Low"
    }

    var isExpanded by remember { mutableStateOf(false) }

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
                    .height(182.dp)
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
                            .padding(15.dp)
                            .fillMaxSize()
                    ) {
                        Image(
                            painter = painterResource(id = imageRes),
                            contentDescription = null,
                            contentScale = ContentScale.Crop,
                            modifier = Modifier.size(37.dp)
                        )
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
                        .height(180.dp)
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

                            Image(
                                painter = painterResource(id = R.drawable.info),
                                contentDescription = null,
                                contentScale = ContentScale.Crop,
                                modifier = Modifier
                                    .size(20.dp)

                            )
                        }
                       }
                }
            }
            Box(
                modifier = Modifier
                    .height(2.dp)

                    .fillMaxWidth()
                    .background(color = Color(0xffD9D9D9))
            )
            Box (modifier = Modifier.padding(10.dp).align(alignment = Alignment.End)){
                Image(
                    painter = painterResource(id = R.drawable.info),
                    contentDescription = null,
                    contentScale = ContentScale.Crop,
                    modifier = Modifier
                        .size(20.dp)

                        .clickable {
                            isExpanded = !isExpanded
                        }
                )
            }
//            Box(
//                modifier = Modifier
//                    .height(2.dp)
//
//                    .fillMaxWidth()
//                    .background(color = Color(0xffD9D9D9))
//            )
//
//         if(isExpanded)   Box(modifier = Modifier
//             .height(100.dp)
//            ) {
//                Column(modifier = Modifier.height(100.dp)) {
//                    val values = if (isExpanded) "Less" else "More"
//                    Row(
//                        modifier = Modifier.fillMaxWidth(),
//                        horizontalArrangement = Arrangement.SpaceBetween,
//                        verticalAlignment = Alignment.CenterVertically
//                    ) {
//
//
//                        Text(
//                            text = "Blood Pressure Systolic",
//                            fontSize = 14.sp,
//                            fontWeight = FontWeight.W400,
//                            color = colors,
//                            style = MaterialTheme.typography.titleMedium
//                        )
//                        Text(
//                            text = "Your Blood Pressure Systolic Index is Mild",
//                            fontSize = 14.sp,
//                            fontWeight = FontWeight.W400,
//                            color = colors,
//                            style = MaterialTheme.typography.titleMedium
//                        )
//                        Image(
//                            painter = painterResource(id = imageRes),
//                            contentDescription = null,
//                            contentScale = ContentScale.Crop,
//                            modifier = Modifier
//                                .size(20.dp)
//                                .clickable {
//                                    isExpanded = !isExpanded
//                                }
//                        )
//
//                    }
//                    Box(
//                        modifier = Modifier
//                            .height(2.dp)
//
//                            .fillMaxWidth()
//                            .background(color = Color(0xffD9D9D9))
//                    )
//                    Row(
//                        modifier = Modifier.fillMaxWidth(),
//                        horizontalArrangement = Arrangement.SpaceBetween,
//                        verticalAlignment = Alignment.CenterVertically
//                    ) {
//                        Text(
//                            text = "60mmHg",
//                            fontSize = 14.sp,
//                            fontWeight = FontWeight.W400,
//                            color = colors,
//                            style = MaterialTheme.typography.titleMedium
//                        )
//
//                        Image(
//                            painter = painterResource(id = R.drawable.info),
//                            contentDescription = null,
//                            contentScale = ContentScale.Crop,
//                            modifier = Modifier
//                                .size(20.dp)
//                                .clickable {
//                                    isExpanded = !isExpanded
//                                }
//                        )
//
//                    }
//                }
//            }
//
            }
        }
    }

