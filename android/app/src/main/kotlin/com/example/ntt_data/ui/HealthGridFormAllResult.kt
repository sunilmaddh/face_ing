package com.example.ntt_data.ui

import ai.nuralogix.anurasdk.core.result.MeasurementResults
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp

@Composable
fun HealthGridFormAllResult(
    results: MeasurementResults,
    modifier: Modifier = Modifier
) {
    val sortedSignalIDs = remember(results) { results.allResults.keys.sorted() }

    Column {
        // Top cards section
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(8.dp),
            horizontalArrangement = Arrangement.spacedBy(8.dp) // Optional: adds spacing
        ) {
            Column(
                modifier = Modifier.weight(1f)
            ) {
                ResultCard(
                    signalID = "Heart Rate",
                    result = "72 bpm",
                    modifier = Modifier

                )
                Spacer(modifier = Modifier.height(8.dp))
                ResultCard(
                    signalID = "Blood Pressure",
                    result = "120/80 mmHg"

                )
            }

            ResultCard(
                hieght = 360.0,
                signalID = "Weight",
                result = "70 kg",
                isBackgroundIMage = true,
                isCenterImage = false,
                modifier = Modifier.weight(1f)
            )
        }


        // Grid of dynamic results
        LazyVerticalGrid(
            columns = GridCells.Adaptive(minSize = 160.dp),
            modifier = modifier.fillMaxSize(),
            contentPadding = PaddingValues(8.dp),
            verticalArrangement = Arrangement.spacedBy(8.dp),
            horizontalArrangement = Arrangement.spacedBy(8.dp)
        ) {
            items(sortedSignalIDs) { signalID ->
                val signalResult = results.result(signalID).toString().orEmpty()
                ResultCard(
                    signalID = signalID,
                    result = signalResult
                )
            }
        }
    }
}
