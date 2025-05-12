package com.example.ntt_data.data.remote
import GuestRequest
import UserSdkRequest
import retrofit2.Call
import retrofit2.http.Body
import retrofit2.http.Header
import retrofit2.http.POST


interface ApiService {

    @POST("/addGuest")
    fun addGuest(
        @Header("Authorization") token:String,
        @Body request: GuestRequest?): Call<Void>

    @POST("/userSDKData")
    fun storeHealthData(
        @Header("Authorization") token: String,
        @Body request: UserSdkRequest?):Call<Void>

}
