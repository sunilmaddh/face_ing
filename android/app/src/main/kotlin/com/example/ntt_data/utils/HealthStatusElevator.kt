package com.example.ntt_data.utils

object HealthStatusEvaluator {

    // For logic: <12: Low, 12–25: Normal, >25: High
    fun elevateBreathingStatus(value: Double): String {
        return when {
            value < 12 -> "Low"
            value <= 25 -> "Normal"
            else -> "High"
        }
    }

    // For logic: <60: Low, 60–100: Normal, >100: High
    fun evaluatePulseStatus(value: Double): String {
        return when {
            value < 60 -> "Low "
            value <= 100 -> "Normal"
            else -> "High"
        }
    }
    fun evaluateSystolicStatus(value: Double): String {
        return when {
            value < 90 -> "Low"
            value < 120 -> "Optimal"
            value < 130 -> "Medium"
            value < 140 -> "High"
            else -> "Very High"
        }
    }
    fun evaluateDiastolicStatus(value: Double): String {
        return when {
            value <= 60 -> "Low"
            value <= 70 -> "Optimal"
            value <= 80 -> "Medium"
            value < 90 -> "High"
            value>=90->"Very High"
            else -> ""
        }
    }
    fun evaluateWellnessScoreStatus(value: Double): String {
        return when {
            value <20 -> "Very Low"
            value <= 40 -> "Low"
                value <=60-> "Medium"
                value <=80-> "High"
                value <=100-> "Very High"
            else -> ""
        }
    }
    fun evaluateHoemoglobinA1CRiskStatus(value: Double): String {
        return when {
            value < 25 -> "Very Low"
            value < 45 -> "Low"
            value < 55 -> "Medium"
            value < 77.5 -> "High"
            else -> "Very High"
        }
    }
    fun evaluateCardiovascularDiseaseRiskStatus(value: Double): String {
        return when {
            value < 5 -> "Very Low"
            value < 7.25 -> "Low"
            value < 10 -> "Medium"
            value < 20 -> "High"
            else -> "Very High"
        }
    }
    fun evaluate1HeartAttackRiskStatus(value: Double): String {
        return when {
            value < 1.65 -> "Very Low"
            value < 2.39 -> "Low"
            value < 3.30 -> "Medium"
            value < 6.60 -> "High"
            else -> "Very High"
        }
    }
    fun evaluateStrokeRiskStatus(value: Double): String {
        return when {
            value < 3.30 -> "Very Low"
            value < 4.79 -> "Low"
            value < 6.60 -> "Medium"
            value < 13.20 -> "High"
            else -> "Very High"
        }
    }
    fun evaluateMentalStressIndexStatus(value: Double): String {
        return when {
            value <= 1.5 -> "Very Low"
            value <= 2.5 -> "Low"
            value <= 3.5 -> "Medium"
            value <= 4.5 -> "High"
            value>4.5->"Very High"
            else -> ""
        }
    }
    fun evaluateMentalStressIndexStatus1(value: Double): String {
        return when {
            value <2 -> "Very Low"
            value <=3 -> "Low"
            value <=4 -> "Medium"
            value <= 5 -> "High"
            value>=5->"Very High"
            else -> ""
        }
    }
    fun evaluateCardiacWorkloadStatus(value: Double): String {
        return when {
            value < 3.80 -> "Very Low"
            value < 3.90 -> "Low"
            value < 4.08 -> "Medium"
            value < 4.18 -> "High"
            else -> "Very High"
        }
    }
    fun evaluateVascularCapacityStatus(value: Double): String {
        return when {
            value < 0.79 -> "Very Low"
            value < 1.12 -> "Low"
            value < 1.78 -> "Medium"
            value < 2.11 -> "High"
            else -> "Very High"
        }
    }
    fun evaluateHeartRateVariabilityStatus(value: Double): String {
        return when {
            value < 10.8 -> "Very Low"
            value < 16.4 -> "Low"
            value < 35.5 -> "Medium"
            value < 51.5 -> "High"
            else -> "Very High"
        }
    }
}
