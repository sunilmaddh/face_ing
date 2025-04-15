package com.example.ntt_data.ui

import ai.nuralogix.anurasdk.core.result.MeasurementResults
import androidx.compose.foundation.Image
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ArrowBack
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import com.example.ntt_data.R

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun HealthResultScreen(
    measurementResults: MeasurementResults?,
    onBackPressed: () -> Unit
) {
    val tabs = listOf("All", "Vital", "Tab 3", "Tab 4")

    val contents = listOf<@Composable () -> Unit>(

        {
         HealthDataList(results = measurementResults!!)

        },
        {
                        HealthGridFormAllResult(
                results = measurementResults!!
            )
        },
        {
            Text("Tab 3 Content", modifier = Modifier.fillMaxSize())
        },
        {
            Text("Tab 4 Content", modifier = Modifier.fillMaxSize())
        }
    )

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Measurement Results", textAlign = TextAlign.Center) },
                navigationIcon = {


                    Image(
                        painter = painterResource(R.drawable.back_botton),
                        contentDescription = null,
                        modifier = Modifier.clickable(onClick = onBackPressed).width(
                            40.dp
                        ).height(40.dp) )

//                    IconButton(onClick = onBackPressed) {
//                        Icon(
//                            imageVector = Icons.Default.ArrowBack,
//                            contentDescription = "Back"
//                        )
//                    }
                }
            )
        }
    ) { innerPadding ->
//        && !measurementResults?.isSNRGood
     if (measurementResults != null && measurementResults.isSNRGood ) {
            // 👇 Proper padding to avoid being hidden by the top app bar
            Box(modifier = Modifier
                .fillMaxSize()
                .padding(innerPadding)) {
                CustomTabBar(
                    tabTitles = tabs,
                    tabContents = contents
                )
            }
        } else {
            Box(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(innerPadding),
                contentAlignment = Alignment.Center
            ) {
                Text(
                    text = "Measurement Cancelled\n\nSNR: ${measurementResults?.snr}",
                    textAlign = TextAlign.Center,
                    style = MaterialTheme.typography.bodyLarge
                )
            }
        }
    }
}


