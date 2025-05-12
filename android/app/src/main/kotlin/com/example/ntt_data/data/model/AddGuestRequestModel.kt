
class GuestRequest(var guestDao: GuestDao, var anuraDetails: AnuraDetails,binahDetails: BinahDetails )
class GuestDao{
    var userId: String?=null
    var name: String?=null
    var gender: String?=null
    var dob: String?=null
    var weight: String?=null
    var height: String?=null
    var emailId: String?=null
}
class AnuraDetails{
    var age: String?=null
    var hRBPM: String?=null
    var bPSystolic: String?=null
    var hRVSDNN: String?=null
    var bPRPP: String?=null
    var bPTau: String?=null
    var healthScore: String?=null
    var mentalScore: String?=null
    var vitalScore: String?=null
    var physicalScore: String?=null
    var mSI: String?=null
    var bpHeartAttack: String?=null
    var bPStroke: String?=null
    var bPCVD: String?=null
    var risksScore: String?=null
    var sNR: String?=null
    var bRBPM: String?=null
    var bpDiastolic: String?=null
    var iHBCount: String?=null
    var hBA1CRiskProb: String?=null
    var mFBGRiskProb: String?=null
    var dBTRiskProb: String?=null
    var fLDRiskProb: String?=null
    var hDLTCRiskProb: String?=null
    var hPTRiskProb: String?=null
    var overallMetabolicRiskProb: String?=null
    var tGRiskProb: String?=null
    var physioScore: String?=null
}

class BinahDetails{
    var pulseRate: Int=0
    var respirationRate: String?=null
    var oxygenSaturation: String?=null
    var sdnn: String?=null
    var stressLevel: String?=null
    var rri: String?=null
    var bloodPressure: String?=null
    var stressIndex: String?=null
    var meanRri: String?=null
    var rmssd: String?=null
    var sd1: String?=null
    var sd2: String?=null
    var prq: String?=null
    var pnsIndex: String?=null
    var pnsZone: String?=null
    var snsIndex: String?=null
    var snsZone: String?=null
    var wellnessIndex: String?=null
    var wellnessLevel: String?=null
    var lfhf: String?=null
    var hemoglobin: String?=null
    var hemoglobinA1C: String?=null
    var highHemoglobinA1CRisk: String?=null
    var highBloodPressureRisk: String?=null
    var ascvdRisk: String?=null
    var normalizedStressIndex: String?=null
    var heartAge: String?=null
    var highTotalCholesterolRisk: String?=null
    var highFastingGlucoseRisk: String?=null
    var lowHemoglobinRisk: Int=0
}
// class GuestRequest{
//     var guestDao: GuestDao = TODO()
//     var anuraDetails: AnuraDetails
//     var binahDetails: () -> Unit
//
// }


class UserSdkRequest(
    var userId: String? = null,
    var anuraDetails: AnuraUserDetails,
    var binahDetails: BinahUserDetails
)

 class AnuraUserDetails {
    var userEmail: String? = null
    var age: String? = null
    var hRBPM: String? = null
    var bPSystolic: String? = null
    var hRVSDNN: String? = null
    var bPRPP: String? = null
    var bPTau: String? = null
    var healthScore: String? = null
    var mentalScore: String? = null
    var vitalScore: String? = null
    var physicalScore: String? = null
    var mSI: String? = null
    var bpHeartAttack: String? = null
    var bPStroke: String? = null
    var bPCVD: String? = null
    var risksScore: String? = null
    var sNR: String? = null
    var bRBPM: String? = null
    var bpDiastolic: String? = null
    var iHBCount: String? = null
    var hBA1CRiskProb: String? = null
    var mFBGRiskProb: String? = null
    var dBTRiskProb: String? = null
    var fLDRiskProb: String? = null
    var hDLTCRiskProb: String? = null
    var hPTRiskProb: String? = null
    var overallMetabolicRiskProb: String? = null
    var tGRiskProb: String? = null
    var physioScore: String? = null
}
 class BinahUserDetails {
     var pulseRate: String? = null
     var respirationRate: String? = null
     var oxygenSaturation: String? = null
     var sdnn: String? = null
     var stressLevel: String? = null
     var rri: String? = null
     var bloodPressure: String? = null
     var stressIndex: String? = null
     var meanRri: String? = null
     var rmssd: String? = null
     var sd1: String? = null
     var sd2: String? = null
     var prq: String? = null
     var pnsIndex: String? = null
     var pnsZone: String? = null
     var snsIndex: String? = null
     var snsZone: String? = null
     var wellnessIndex: String? = null
     var wellnessLevel: String? = null
     var lfhf: String? = null
     var hemoglobin: String? = null
     var hemoglobinA1C: String? = null
     var highHemoglobinA1CRisk: String? = null
     var highBloodPressureRisk: String? = null
     var ascvdRisk: String? = null
     var normalizedStressIndex: String? = null
     var heartAge: String? = null
     var highTotalCholesterolRisk: String? = null
     var highFastingGlucoseRisk: String? = null
     var lowHemoglobinRisk: String? = null
 }
