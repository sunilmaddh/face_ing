/*
 *              Copyright (c) 2016-2023, Nuralogix Corp.
 *                      All Rights reserved
 *
 *      THIS SOFTWARE IS LICENSED BY AND IS THE CONFIDENTIAL AND
 *      PROPRIETARY PROPERTY OF NURALOGIX CORP. IT IS
 *      PROTECTED UNDER THE COPYRIGHT LAWS OF THE USA, CANADA
 *      AND OTHER FOREIGN COUNTRIES. THIS SOFTWARE OR ANY
 *      PART THEREOF, SHALL NOT, WITHOUT THE PRIOR WRITTEN CONSENT
 *      OF NURALOGIX CORP, BE USED, COPIED, DISCLOSED,
 *      DECOMPILED, DISASSEMBLED, MODIFIED OR OTHERWISE TRANSFERRED
 *      EXCEPT IN ACCORDANCE WITH THE TERMS AND CONDITIONS OF A
 *      NURALOGIX CORP SOFTWARE LICENSE AGREEMENT.
 */

package com.face.face.measurement

import ai.nuralogix.anurasdk.core.result.MeasurementResults
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.face.face.R

/**
 * A [RecyclerView] adapter to display results from a [MeasurementResults] instance. This adapter
 * simply sorts the results in alphabetical order based on each result's signal ID. Your application
 * should display the results in an appropriate manner based on the use case.
 *
 * For more information on the results from DeepAffex Cloud and their interpretation, please refer
 * to the DeepAffex Points Reference:
 *
 * https://docs.deepaffex.ai/points/index.html
 */
class FaceResultsAdapter(private val results: MeasurementResults) :
    RecyclerView.Adapter<FaceResultsAdapter.ResultsViewHolder>() {

    /**
     * Sort the results in [MeasurementResults.allResults] in alphabetical order based on each
     * result's signal ID
     */
    private val sortedSignalIDs: List<String> = results.allResults.keys.sorted()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ResultsViewHolder {
        val view = LayoutInflater
            .from(parent.context)
            .inflate(
                R.layout.view_report_card,
                parent,
                false)

        return ResultsViewHolder(view)
    }

    override fun getItemCount(): Int {
        return sortedSignalIDs.size
    }

    override fun onBindViewHolder(holder: ResultsViewHolder, position: Int) {
        val signalID = sortedSignalIDs[position]
        val signalResult = results.result(signalID)
        holder.tvSignalName.text = signalID
        holder.tvSignalResult.text = signalResult.toString()
    }

    inner class ResultsViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        val tvSignalName: TextView = itemView.findViewById(R.id.tv_value)
        val tvSignalResult: TextView = itemView.findViewById(R.id.tv_title)
    }
}