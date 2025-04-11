package com.example.ntt_data.ui

import ai.nuralogix.anurasdk.core.result.MeasurementResults
import android.os.Build
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.material3.MaterialTheme
import com.example.ntt_data.utils.KEY_MEASUREMENT_RESULTS

class HealthResultActivity : ComponentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val results: MeasurementResults? = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            intent.getParcelableExtra(KEY_MEASUREMENT_RESULTS, MeasurementResults::class.java)
        } else {
            @Suppress("DEPRECATION")
            intent.getParcelableExtra(KEY_MEASUREMENT_RESULTS)
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
