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

package com.example.ntt_data.measurement

import com.example.ntt_data.BuildConfig
import com.example.ntt_data.utils.SharedPreferencesHelper


import ai.nuralogix.anurasdk.core.entity.MeasurementQuestionnaire
import ai.nuralogix.anurasdk.error.AnuraError
import ai.nuralogix.anurasdk.utils.AnuLogUtil
import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Bundle
import android.util.Log
import android.widget.Toast
import androidx.activity.result.contract.ActivityResultContracts
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import androidx.core.widget.addTextChangedListener
import androidx.lifecycle.lifecycleScope
import com.example.ntt_data.databinding.ActivityMainBinding
import com.example.ntt_data.viewmodel.ExampleStartViewModel
import com.google.android.material.dialog.MaterialAlertDialogBuilder
import kotlinx.coroutines.launch
import kotlin.system.exitProcess

/**
 * This is an example starting activity that prepares for launching [AnuraExampleMeasurementActivity]
 * It initializes the DeepAffex Cloud API client, and requests camera permissions.
 *
 * This activity shows a user profile questionnaire, and the answers will be passed to
 * [AnuraExampleMeasurementActivity] and included in the measurement. For more information on
 * measurement questionnaires, refer to:
 *
 * https://docs.deepaffex.ai/guide/demographics.html
 *
 */
class ExampleStartActivity : AppCompatActivity() {
    companion object {
        const val TAG = "AnuraExampleStartActivity"

        /**
         * Your application is responsible for collecting user profile information.
         * For more information on which DeepAffex Points need this information,
         * please refer to:
         *
         * https://docs.deepaffex.ai/points/introduction.html
         *
         * The [MeasurementQuestionnaire] is recommended to assist with the
         * the validation of the user information and prevent common errors when
         * starting a measurement.
         */
        var measurementQuestionnaire = MeasurementQuestionnaire()

        /**
         * Partner ID can hold a unique-per-user identifier, or any other value which could be used
         * to link your application's end users with their measurements taken on DeepAffex Cloud.
         * This is because your application's end users are considered anonymous users on DeepAffex
         * Cloud.
         *
         * For more information on Partner ID, refer to:
         *
         * https://docs.deepaffex.ai/guide/cloud/4_users.html#anonymous-measurements
         */
        var PARTNER_ID = ""
    }

    private val binding by lazy { ActivityMainBinding.inflate(layoutInflater) }

    private val exampleStartViewModel: ExampleStartViewModel
            by viewModels { ExampleStartViewModel.Factory }

    private var userProfileHeight = ""
    private var userProfileWeight = ""
    private var userProfileAge = ""
    private var userProfileSexAtBirth = ""

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        initialize()
        setupUserProfileInputUI()

        /**
         * Check if the application has been configured with a DeepAffex License Key and Study ID
         */
        if (checkEmbeddedDeepAffexLicenseAndStudyID()) {
            requestCameraAccessPermission()
            lifecycleScope.launch {
                /**
                 * Before launching [AnuraExampleMeasurementActivity], we need to ensure that the
                 * application has a valid DeepAffex Cloud access token. The application also needs
                 * to ensure it has the latest study configuration binary that's required to
                 * initialize DeepAffex Extraction Library
                 */
                exampleStartViewModel.verifyDeepAffexTokenAndStudyFile()
            }
        } else {

            /**
             * If either the DeepAffex License Key or Study ID are not configured, show an error
             * dialog box and exit the app
             */
            showExitAppDialog(
                "Sample App Configuration Error",
                "Your DFX_LICENSE_KEY and DFX_STUDY_ID are not set in server.properties"
            )
        }
    }

    /**
     * Launch [AnuraExampleMeasurementActivity]. This should only be called when the application has
     * validated the DeepAffex Cloud access token it has and downloaded the latest study
     * configuration file
     */
    private fun launchAnuraExampleMeasurementActivity() {
        Log.d(
            TAG,
            "Start AnuraMeasurementActivity with UserInfo: " +
                    measurementQuestionnaire.toString() +
                    "partnerID=$PARTNER_ID"
        )
        startActivity(Intent(this, AnuraExampleMeasurementActivity::class.java))
    }

    /**
     * Initialization code for various aspects of this example activity
     */
    private fun initialize() {
        setContentView(binding.root)
        SharedPreferencesHelper.initialize(application)
        AnuLogUtil.setShowLog(BuildConfig.DEBUG)

        exampleStartViewModel.readyToMeasure.observe(this) { handleTokenVerified(it) }
        exampleStartViewModel.error.observe(this) { handleError(it) }
    }

    /**
     * Setup the user profile questionnaire UI
     */
    private fun setupUserProfileInputUI() {
//        binding.userHeightEt.addTextChangedListener { text ->
//            userProfileHeight = text.toString()
//        }
//        binding.userWeightEt.addTextChangedListener { text ->
//            userProfileWeight = text.toString()
//        }
//        binding.userAgeEt.addTextChangedListener { text ->
//            userProfileAge = text.toString()
//        }
//        binding.userGenderEt.addTextChangedListener { text ->
//            userProfileSexAtBirth = text.toString()
//        }
//        binding.partnerIdEt.addTextChangedListener { text ->
//            PARTNER_ID = text.toString()
//        }
        binding.goMeasuremntBtn.setOnClickListener {
            launchAnuraExampleMeasurementActivity()
//            if (userProfileHeight.isNotBlank()
//                || userProfileWeight.isNotBlank()
//                || userProfileAge.isNotBlank()
//                || userProfileSexAtBirth.isNotBlank()
//            ) {
//                validateInputs(measurementQuestionnaire)
//            } else {
//                launchAnuraExampleMeasurementActivity()
//            }
        }
    }

    /**
     * Use the [MeasurementQuestionnaire] to validate and persist the user
     *  profile information
     */
    private fun validateInputs(
        measurementQuestionnaire: MeasurementQuestionnaire
    ) {
        var invalidInputs = ""

        if (userProfileHeight.isBlank()
            || (userProfileHeight.isNotBlank() && measurementQuestionnaire.setHeightInCm(
                userProfileHeight.toInt()
            ) == AnuraError.Core.INVALID_INPUT)
        ) {
            invalidInputs = invalidInputs.plus("|Height|")
        }
        if (userProfileWeight.isBlank() || (userProfileWeight.isNotBlank() && measurementQuestionnaire.setWeightInKg(
                userProfileWeight.toInt()
            ) == AnuraError.Core.INVALID_INPUT)
        ) {
            invalidInputs = invalidInputs.plus("|Weight|")
        }
        if (userProfileAge.isBlank() || (userProfileAge.isNotBlank() && measurementQuestionnaire.setAge(
                userProfileAge.toInt()
            ) == AnuraError.Core.INVALID_INPUT)
        ) {
            invalidInputs = invalidInputs.plus("|Age|")
        }
        if (measurementQuestionnaire.setSexAssignedAtBirth(
                userProfileSexAtBirth
            ) == AnuraError.Core.INVALID_INPUT
        ) {
            invalidInputs = invalidInputs.plus("|Sex At Birth|")
        }

        if (invalidInputs.isNotBlank()) {
            showInvalidInputErrorToast(invalidInputs)
        } else {
            launchAnuraExampleMeasurementActivity()
        }
    }

    private fun showInvalidInputErrorToast(inputWithError: String) {
        Toast.makeText(this, "Invalid Inputs: $inputWithError", Toast.LENGTH_SHORT).show()
    }

    /**
     * Check if the application has been configured with a DeepAffex License Key or Study ID.
     * This Sample Application includes these parameters as part of the BuildConfig generated by
     * Gradle from server.properties file.
     *
     * Refer to README.md for more information on how to set up this Sample App
     */
    private fun checkEmbeddedDeepAffexLicenseAndStudyID(): Boolean {
        return !(BuildConfig.DFX_LICENSE_KEY.isEmpty() || BuildConfig.DFX_STUDY_ID.isEmpty())
    }

    /**
     * Activates the "Start Measurement" button when the DeepAffex cloud access token and s
     */
    private fun handleTokenVerified(isTokenVerified: Boolean) {
        binding.goMeasuremntBtn.isEnabled = isTokenVerified
    }

    /**
     * Generic method to handle errors. Your application is responsible for gracefully handling
     * errors and explaining what's happening to your end users
     */
    private fun handleError(errorMsg: String?) {
        Toast.makeText(this, "Error:$errorMsg", Toast.LENGTH_SHORT).show()
    }

    /**
     * Request camera access permission from the Android System. Your application is responsible
     * for asking your end users for permission to use the camera, and to explain how and why the
     * camera is used.
     */
    private fun requestCameraAccessPermission() {
        if (ContextCompat.checkSelfPermission(
                this,
                Manifest.permission.CAMERA
            ) == PackageManager.PERMISSION_GRANTED
        ) {
            // Permission already granted
            return
        }
        registerForActivityResult(ActivityResultContracts.RequestPermission()) {
            runOnUiThread {
                Toast.makeText(
                    this@ExampleStartActivity,
                    "Camera Permission ${if (it) "Granted" else "Denied"}!",
                    Toast.LENGTH_SHORT
                ).show()
            }
        }.run { launch(Manifest.permission.CAMERA) }
    }

    /**
     * Shows an error dialog box if your application is not correctly configured. Your application's
     * end users should never see this.
     */
    private fun showExitAppDialog(title: String, msg: String) {
        MaterialAlertDialogBuilder(this)
            .setTitle(title)
            .setMessage(msg)
            .setNegativeButton("Exit")
            { _, _ -> exitProcess(0) }
            .setCancelable(false)
            .show()
    }
}
