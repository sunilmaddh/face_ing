package com.example.ntt_data.ui

import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@Composable
fun FullImageContentCard(
    title: String,
    centerText: String,
    imageRes: Int,
    mass:String="",
    modifier: Modifier = Modifier
) {
    Card(
        shape = RoundedCornerShape(16.dp),
//        elevation = CardDefaults.cardElevation(defaultElevation = 2.dp),
        modifier = modifier
            .width(170.dp).height(190.dp)
            .padding(8.dp)
    ) {
        Column(
            horizontalAlignment = Alignment.CenterHorizontally,
            modifier = Modifier
                .fillMaxWidth()
                .background(Color.White)

        ) {
            // Top Title
            Text(
                text = title,
                style = MaterialTheme.typography.titleMedium,
                fontSize = 16.sp,
                fontWeight = FontWeight.W600,
                textAlign = TextAlign.Center,
                modifier = Modifier
                    .padding(8.dp)
            )
            Spacer(modifier = Modifier.height(28.dp))
            // Center Image (full width)
            Box {
                Image(
                    painter = painterResource(id = imageRes),
                    contentDescription = null,
                    contentScale = ContentScale.Crop,

                    modifier = Modifier
                        .fillMaxWidth().align(alignment = Alignment.BottomCenter).height(330.dp)

                )
                Column(
                    horizontalAlignment = Alignment.CenterHorizontally,
                    modifier = Modifier
                    .padding(16.dp).align(alignment = Alignment.BottomCenter)) {  Text(
                    text = centerText,
                    style = MaterialTheme.typography.bodyMedium,
                    color = Color(0xff0072BC),
                    textAlign = TextAlign.Center,
                    fontWeight = FontWeight.W700,
                    fontSize = 24.sp,

                )

                    Text(
                        text = mass,
                        style = MaterialTheme.typography.bodyMedium,
                        color = Color.Black,
                        fontWeight = FontWeight.W400,
                        textAlign = TextAlign.Center,
                        fontSize = 14.sp,


                    ) }

            }


            // Bottom text

        }
    }
}
