package com.face.face.measurement

import com.face.face.utils.KEY_MEASUREMENT_RESULTS
import ai.nuralogix.anurasdk.core.result.MeasurementResults
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.Window
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.face.face.R
import com.google.android.material.appbar.MaterialToolbar

/**
 * An example activity to display measurement results from a [MeasurementResults] instance that was
 * passed from [FaceAnuraMeasurementActivity].
 *
 * The results in this example are displayed in a simple list ordered alphabetically by signal ID.
 * Your application should display the results in an appropriate manner based on the use case.
 *
 * For more information on the results from DeepAffex Cloud and their interpretation, please refer
 * to the DeepAffex Points Reference:
 *
 * https://docs.deepaffex.ai/points/index.html
 */
class FaceResultsActivity : AppCompatActivity() {

    private val TAG = FaceResultsActivity::class.simpleName

    override fun onCreate(savedInstanceState: Bundle?) {
        /**
         * Setup View
         */
        super.onCreate(savedInstanceState)
        Log.d(TAG, "onCreate")
        supportRequestWindowFeature(Window.FEATURE_NO_TITLE)
        setContentView(R.layout.activity_results)
        val topAppBar = findViewById<MaterialToolbar>(R.id.topAppBar)
        topAppBar.setNavigationIcon(R.drawable.baseline_arrow_back_24)
        topAppBar.setNavigationOnClickListener {
            finish()
        }

        /**
         * Retrieve the extras parcelable [MeasurementResults]
         */
        val results = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            intent.extras?.getParcelable(KEY_MEASUREMENT_RESULTS, MeasurementResults::class.java)
        } else {
            intent.extras?.getParcelable(KEY_MEASUREMENT_RESULTS)
        }

        setupResultsView(results)
    }

    /**
     * Sets up the recycleView to display the results as a list
     */
    private fun setupResultsView(measurementResults: MeasurementResults?) {
        val rvResults = findViewById<RecyclerView>(R.id.rv_results)
//        val tvTitle = findViewById<TextView>(R.id.tv_title)

        /**
         * Make sure that the results are valid before displaying them
         */
        if (measurementResults != null && measurementResults.isSNRGood) {
            rvResults.layoutManager = GridLayoutManager(this@FaceResultsActivity,2)
            rvResults.adapter = FaceResultsAdapter(measurementResults)
            rvResults.addItemDecoration(
                DividerItemDecoration(
                    this@FaceResultsActivity,
                    DividerItemDecoration.VERTICAL
                )
            )

            /**
             * Show the Measurement ID in the title
             */
//            tvTitle.text = measurementResults.measurementID
        } else {
            /**
             * If results are not available, show a "Measurement Cancelled" message
             */
//            tvTitle.text = resources.getString(R.string.MEASUREMENT_CANCELED)
//                .plus("\n MeasurementID: ${measurementResults?.measurementID}")
//                .plus("\n SNR: ${measurementResults?.snr}")
        }
    }
}