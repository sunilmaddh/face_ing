package com.example.ntt_data.ui

import ai.nuralogix.anurasdk.core.result.MeasurementResults
import android.os.Build
import android.os.Bundle
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.material3.MaterialTheme
import com.example.ntt_data.data.repository.MeasurmentRepository
import com.example.ntt_data.globle.GlobalData
import com.example.ntt_data.measurement.AnuraExampleMeasurementActivity.Companion.TAG
import com.example.ntt_data.utils.KEY_MEASUREMENT_RESULTS

class HealthResultActivity : ComponentActivity() {

    val repository = MeasurmentRepository()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val results: MeasurementResults? = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            intent.getParcelableExtra(KEY_MEASUREMENT_RESULTS, MeasurementResults::class.java)
        } else {
            @Suppress("DEPRECATION")
            intent.getParcelableExtra(KEY_MEASUREMENT_RESULTS)
        }
        val dynamicMap = mutableMapOf<String, String>()
        Log.d(TAG, "resultData: $results")
        Log.d(TAG, "resultData ALL: ${results?.allResults}")
        if (results != null) {
            for( resultData in results.allResults ){
                val key=resultData.key
                val value=resultData.value.value
                dynamicMap[key]= value.toString()
                Log.d(TAG, "resultData: $dynamicMap")
            }
          if (GlobalData.scanType.isNotEmpty() && GlobalData.scanType == "guest-user"){
                repository.addGuest(
                    dataMap =dynamicMap ,
                    onSuccess = {
                        Log.d("API", "Guest added successfully")
                    }, onError = {
                        Log.e("API", "Something ent wrong")
                    })
            }else {
              repository.storeHealthData(dataMap = dynamicMap, onSuccess = {

                  Log.d("API", "Health data store successfully")
              }, onError = {
                  Log.e("API", "Something ent wrong")
              })
          }
                setContent {
                    MaterialTheme {
                        HealthResultScreen(
                            measurementResults = results,
                            onBackPressed = { finish() }
                        )
                    }
                }
        }
    }
}
