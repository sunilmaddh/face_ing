package com.example.ntt_data.ui

import ai.nuralogix.anurasdk.core.result.MeasurementResults
import android.util.Log
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.example.ntt_data.measurement.AnuraExampleMeasurementActivity.Companion.TAG

@Composable
fun HealthGridFormAllResult(
    results: MeasurementResults,
    modifier: Modifier = Modifier
) {
    val sortedSignalIDs = remember(results) { results.allResults.keys.sorted() }
    val dynamicMap = mutableMapOf<String, String>()
      for(res in sortedSignalIDs){

     val siggResult =   results.result(res)
          dynamicMap[res]=siggResult.toString();
          Log.d(TAG, "sortedSignalIDs: $res")
          Log.d(TAG, "dynamicMap: $dynamicMap")
          Log.d(TAG, "sortedSignalIDs: $siggResult")
      }

    Column {
        // Top cards section


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
