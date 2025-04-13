package com.example.ntt_data.ui

import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@Composable
fun SelectableCardRow() {
    var selectedIndex by remember { mutableIntStateOf(2) }

    val colors = listOf(
        Color(0xFF0072BC), // Blue
        Color(0xFF51B5F6), // Amber
        Color(0xFFF1E980), // Green
        Color(0xFFEBE268),
        Color(0xFFDAD054)// Red
    )
   Card( shape = RoundedCornerShape(16.dp),
       elevation = CardDefaults.cardElevation(defaultElevation = 8.dp),
       colors = CardDefaults.cardColors(containerColor = Color.White),
       modifier = Modifier
           .fillMaxWidth()
           .height(182.dp)
           .padding(8.dp)) { Column(verticalArrangement = Arrangement.Center,
               horizontalAlignment = Alignment.CenterHorizontally
               ) {
                 Spacer(modifier = Modifier.height(20.dp))
               Text(  text = "Body shape index",
                   color = Color.Black,
                   fontWeight = FontWeight.Bold)
       Spacer(modifier = Modifier.height(10.dp))
       Row(
           modifier = Modifier
               .fillMaxWidth()
               .padding(horizontal = 16.dp),
          horizontalArrangement = Arrangement.Center
       ) {
           colors.forEachIndexed { index, color ->
               val isSelected = index == selectedIndex
               val scale by animateFloatAsState(
                   targetValue = if (isSelected) 1.1f else 1f,
                   label = "scaleAnimation"
               )

               Box(
                   modifier = Modifier
                       .width(if (isSelected) 37.5.dp else 35.5.dp).height(if (isSelected) 38.dp else 36.dp)
                       .padding(4.dp)
                       .aspectRatio(1f)
                       .graphicsLayer {
                           scaleX = scale
                           scaleY = scale
                       }
                       .clip(RoundedCornerShape(2.dp))
                       .background(color)
                       .border(
                           width = if (isSelected) 1.dp else 0.dp,
                           color = if (isSelected) Color.Black else Color.Transparent,
                           shape = RoundedCornerShape(2.dp)
                       )
                       .clickable {
                           selectedIndex = index
                       },
                   contentAlignment = Alignment.Center
               ) {
                   Text(
                       text = "${index + 1}",
                       color = Color.White,
                       fontWeight = FontWeight.Bold
                   )
               }
           }
       }
       Spacer(modifier = Modifier.height(10.dp))
       Column(verticalArrangement = Arrangement.Center,
           horizontalAlignment = Alignment.CenterHorizontally
           ) { Text(
           text = "4",
           color = Color(0xFF0072BC),
           fontWeight = FontWeight.W700,
               fontSize = 24.sp
       )
           Text(
               text = "index",
               color = Color.Black,

           )

       }
   }
   }}



