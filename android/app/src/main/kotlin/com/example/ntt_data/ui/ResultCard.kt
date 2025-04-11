package com.example.ntt_data.ui

import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.ntt_data.R

@Composable
fun ResultCard(
    signalID: String,
    result: String,
    mass: String = "",
    isBackgroundIMage: Boolean = false,
    isCenterImage: Boolean = false,
    modifier: Modifier = Modifier,
    hieght: Double=180.0 // ✅ Added this line
) {
    Card(
        modifier = modifier // ✅ Use external modifier
            .height(hieght.dp)   // Optional: keep this if you want fixed width
            .padding(8.dp),
        shape = RoundedCornerShape(18.dp),
        elevation = CardDefaults.cardElevation(4.dp),
        colors = CardDefaults.cardColors(containerColor = Color.White)
    ) {
        Column(
            modifier = Modifier
                .padding(start = 20.dp, end = 20.dp, top = 26.dp, bottom = 26.dp),
            verticalArrangement = Arrangement.Center,
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Text(
                text = signalID,
                color = Color(0xFF0066CC),
                fontSize = 24.sp,
                maxLines = 2,
                textAlign = TextAlign.Center,
                fontWeight = FontWeight.Bold
            )

            Spacer(modifier = Modifier.height(20.dp))

            // Box for background or center image + result text
            Box(
                modifier = Modifier.fillMaxWidth(),
                contentAlignment = Alignment.Center
            ) {
                Column(
                    verticalArrangement = Arrangement.Center,
                    horizontalAlignment = Alignment.CenterHorizontally
                ) {
                    if (isBackgroundIMage || isCenterImage) {
                        if (isBackgroundIMage) {
                            Image(
                                modifier = Modifier.heightIn(200.dp),
                                painter = painterResource(id = R.drawable.heart_rate),
                                contentDescription = null
                            )
                        }
                        if (isCenterImage) {
                            Image(
                                painter = painterResource(id = R.drawable.heart_rate),
                                contentDescription = null
                            )
                        }
                    }

                    Text(
                        text = result,
                        fontSize = 16.sp,
                        color = Color.Black,
                        fontWeight = FontWeight.Bold,
                        maxLines = 2,
                        textAlign = TextAlign.Center,
                        modifier = Modifier.padding(8.dp)
                    )
                }
            }

            if (mass.isNotEmpty()) {
                Text(
                    text = mass,
                    fontSize = 14.sp,
                    color = Color.Black
                )
            }
        }
    }
}
