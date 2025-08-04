package com.face.face.data.repository


import AnuraDetails
import AnuraUserDetails
import BinahDetails
import BinahUserDetails
import GuestDao
import GuestRequest
import UserSdkRequest
import android.util.Log
import com.face.face.data.remote.RetrofitInstance
import com.face.face.globle.GlobalData
import retrofit2.Call
import retrofit2.Response
import retrofit2.Callback

class MeasurmentRepository {
    private val apiService = RetrofitInstance.api
    fun addGuest(
        dataMap: Map<String, Any>,
        onSuccess: () -> Unit,
        onError: (String) -> Unit
    ) {
        val guest = GuestDao().apply {
            userId = GlobalData.userId
            name =GlobalData.guestName
            gender = GlobalData.gender
            dob = GlobalData.dob
            weight = GlobalData.weight
            height = GlobalData.guestHeight
            emailId = GlobalData.emailId
        }
        Log.d("API", "Request failed: ${guest.dob} ${GlobalData.guestName} ${GlobalData.userId} ")


        val anuraDetails = AnuraDetails().apply {
            // Assign if available
            Log.d("API", "Request failed: ${dataMap["AGE"]}")

            age = (dataMap["AGE"]?.toString())
            hRBPM = dataMap["HR_BPM"]?.toString()
            bPSystolic = dataMap["BP_SYSTOLIC"]?.toString()
            hRVSDNN = dataMap["HRV_SDNN"]?.toString()
            bPRPP = dataMap["BP_RPP"]?.toString()
            bPTau = dataMap["BP_TAU"]?.toString()
            healthScore = dataMap["HEALTH_SCORE"]?.toString()
            mentalScore = dataMap["MENTAL_SCORE"]?.toString()
            vitalScore = dataMap["VITAL_SCORE"]?.toString()
            physicalScore = dataMap["PHYSICAL_SCORE"]?.toString()
            mSI = dataMap["MSI"]?.toString()
            bpHeartAttack = dataMap["BP_HEART_ATTACK"]?.toString()
            bPStroke = dataMap["BP_STROKE"]?.toString()
            bPCVD = dataMap["BP_CVD"]?.toString()
            risksScore = dataMap["RISKS_SCORE"]?.toString()
            sNR = dataMap["SNR"]?.toString()
            bRBPM = dataMap["BR_BPM"]?.toString()
            bpDiastolic = dataMap["BP_DIASTOLIC"]?.toString()
            iHBCount = dataMap["IHB_COUNT"]?.toString()
            hBA1CRiskProb = dataMap["HBA1C_RISK_PROB"]?.toString()
            mFBGRiskProb = dataMap["MFBG_RISK_PROB"]?.toString()
            dBTRiskProb = dataMap["DBT_RISK_PROB"]?.toString()
            fLDRiskProb = dataMap["FLD_RISK_PROB"]?.toString()
            hDLTCRiskProb = dataMap["HDLTC_RISK_PROB"]?.toString()
            hPTRiskProb = dataMap["HPT_RISK_PROB"]?.toString()
            overallMetabolicRiskProb = dataMap["OVERALL_METABOLIC_RISK_PROB"]?.toString()
            tGRiskProb = dataMap["TG_RISK_PROB"]?.toString()
            physioScore = dataMap["PHYSIO_SCORE"]?.toString()
        }
        val token="Bearer " +GlobalData.token
        Log.d("API", "Request failed: ${guest.dob} ${anuraDetails.age} $token")
        val request = GuestRequest(guestDao = guest, anuraDetails = anuraDetails, binahDetails = BinahDetails())
        apiService.addGuest(token = token,request).enqueue(object : Callback<Void> {
            override fun onResponse(call: Call<Void>, response: Response<Void>) {
                if (response.isSuccessful) {
                    onSuccess()
                } else {
                    onError("Failed with code: ${response.code()}")
                    Log.d("API", "${response.code()}")
                }
            }
            override fun onFailure(call: Call<Void>, t: Throwable) {
                onError("Request failed: ${t.localizedMessage ?: "Unknown error"}")
                Log.d("API", "Request failed: ${t.localizedMessage ?: "Unknown error"}")
            }
        })

    }

    fun  storeHealthData(
        dataMap: Map<String, Any>,
        onSuccess: () -> Unit,
        onError: (String) -> Unit
    ){

        Log.d("API", "Request failed:   ${GlobalData.userId} ")
        val anuraDetails = AnuraUserDetails().apply {
            Log.d("API", "Sunul failed: ${dataMap["AGE"]}")
            age = (dataMap["AGE"]?.toString())
            hRBPM = dataMap["HR_BPM"]?.toString()
            bPSystolic = dataMap["BP_SYSTOLIC"]?.toString()
            hRVSDNN = dataMap["HRV_SDNN"]?.toString()
            bPRPP = dataMap["BP_RPP"]?.toString()
            bPTau = dataMap["BP_TAU"]?.toString()
            healthScore = dataMap["HEALTH_SCORE"]?.toString()
            mentalScore = dataMap["MENTAL_SCORE"]?.toString()
            vitalScore = dataMap["VITAL_SCORE"]?.toString()
            physicalScore = dataMap["PHYSICAL_SCORE"]?.toString()
            mSI = dataMap["MSI"]?.toString()
            bpHeartAttack = dataMap["BP_HEART_ATTACK"]?.toString()
            bPStroke = dataMap["BP_STROKE"]?.toString()
            bPCVD = dataMap["BP_CVD"]?.toString()
            risksScore = dataMap["RISKS_SCORE"]?.toString()
            sNR = dataMap["SNR"]?.toString()
            bRBPM = dataMap["BR_BPM"]?.toString()
            bpDiastolic = dataMap["BP_DIASTOLIC"]?.toString()
            iHBCount = dataMap["IHB_COUNT"]?.toString()
            hBA1CRiskProb = dataMap["HBA1C_RISK_PROB"]?.toString()
            mFBGRiskProb = dataMap["MFBG_RISK_PROB"]?.toString()
            dBTRiskProb = dataMap["DBT_RISK_PROB"]?.toString()
            fLDRiskProb = dataMap["FLD_RISK_PROB"]?.toString()
            hDLTCRiskProb = dataMap["HDLTC_RISK_PROB"]?.toString()
            hPTRiskProb = dataMap["HPT_RISK_PROB"]?.toString()
            overallMetabolicRiskProb = dataMap["OVERALL_METABOLIC_RISK_PROB"]?.toString()
            tGRiskProb = dataMap["TG_RISK_PROB"]?.toString()
            physioScore = dataMap["PHYSIO_SCORE"]?.toString()
        }
        val token="Bearer " +GlobalData.token
        Log.d("API", "Request failed:  ${anuraDetails.age} $token")
        val request = UserSdkRequest( userId = GlobalData.userId, anuraDetails = anuraDetails, binahDetails = BinahUserDetails())
        apiService.storeHealthData(token = token,request).enqueue(object : Callback<Void> {
            override fun onResponse(call: Call<Void>, response: Response<Void>) {
                if (response.isSuccessful) {
                    onSuccess()
                } else {
                    onError("Failed with code: ${response.code()}")
                    Log.d("API", "${response.code()}")
                    Log.d("API", response.message())
                }
            }

            override fun onFailure(call: Call<Void>, t: Throwable) {
                onError("Request failed: ${t.localizedMessage ?: "Unknown error"}")
                Log.d("API", "Request failed: ${t.localizedMessage ?: "Unknown error"}")
            }
        })


    }
}