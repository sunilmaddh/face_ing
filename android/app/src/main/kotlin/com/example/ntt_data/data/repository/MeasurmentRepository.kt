package com.example.ntt_data.data.repository


import AnuraDetails
import BinahDetails
import GuestDao
import GuestRequest
import android.util.Log
import com.example.ntt_data.data.remote.RetrofitInstance
import com.example.ntt_data.globle.GlobalData
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
        Log.d("API", "Request failed: ${guest.dob} ${GlobalData.guestName} ")


        val anuraDetails = AnuraDetails().apply {
            age = (dataMap["AGE"] as? Double)?.toInt() ?: 0
            gender = dataMap["GENDER"]?.toString()
            height = dataMap["HEIGHT"]?.toString()
            waistCircum = dataMap["WAIST_CIRCUM"]?.toString()
            bMICalc = dataMap["BMI_CALC"]?.toString()
            aBSI = dataMap["ABSI"]?.toString()
            hRBPM = dataMap["HR_BPM"]?.toString()
            bPSystolic = dataMap["BP_SYSTOLIC"]?.toString()
            hRVSDNN = dataMap["HRV_SDNN"]?.toString()
            bPRPP = dataMap["BP_RPP"]?.toString()
            bPTau = dataMap["BP_TAU"]?.toString()
            bPBPM = dataMap["BP_DIASTOLIC"]?.toString()
            tHBCount = dataMap["IHB_COUNT"]?.toString()
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
        }
        var tokens ="Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMDAwMDAwMDAxYWJjQGdtYWlsLmNvbSIsImlhdCI6MTc0NjcwNzc2MiwiZXhwIjoxNzQ2Nzk0MTYyfQ.7KEhC0SSYIgK0AZzOHUqsZesft8m5NuOHdLJOLXI4jU";
        val token="Bearer" +GlobalData.token
        Log.d("API", "Request failed: ${guest.dob} ${anuraDetails.mentalScore} $token")


        val request = GuestRequest(guestDao = guest, anuraDetails = anuraDetails, binahDetails = BinahDetails())
        apiService.addGuest(token = tokens,request).enqueue(object : Callback<Void> {
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
}