// class GuestRequest{
//     val guestDao: GuestDao = TODO()
//     val anuraDetails: AnuraDetails
//     val binahDetails: () -> Unit
//
// }


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
    var age: Int=0
    var gender: String?=null
    var height: String?=null
    var waistCircum: String?=null
    var bMICalc: String?=null
    var aBSI: String?=null
    var hRBPM: String?=null
    var bPSystolic: String?=null
    var hRVSDNN: String?=null
    var bPRPP: String?=null
    var bPTau: String?=null
    var bPBPM: String?=null
    var tHBCount: String?=null
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
}

class BinahDetails{
    val pulseRate: Int=0
    val respirationRate: String?=null
    val oxygenSaturation: String?=null
    val sdnn: String?=null
    val stressLevel: String?=null
    val rri: String?=null
    val bloodPressure: String?=null
    val stressIndex: String?=null
    val meanRri: String?=null
    val rmssd: String?=null
    val sd1: String?=null
    val sd2: String?=null
    val prq: String?=null
    val pnsIndex: String?=null
    val pnsZone: String?=null
    val snsIndex: String?=null
    val snsZone: String?=null
    val wellnessIndex: String?=null
    val wellnessLevel: String?=null
    val lfhf: String?=null
    val hemoglobin: String?=null
    val hemoglobinA1C: String?=null
    val highHemoglobinA1CRisk: String?=null
    val highBloodPressureRisk: String?=null
    val ascvdRisk: String?=null
    val normalizedStressIndex: String?=null
    val heartAge: String?=null
    val highTotalCholesterolRisk: String?=null
    val highFastingGlucoseRisk: String?=null
    val lowHemoglobinRisk: Int=0
}
