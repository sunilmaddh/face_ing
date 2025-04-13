//import androidx.compose.foundation.background
//import androidx.compose.foundation.layout.Column
//import androidx.compose.foundation.layout.Spacer
//import androidx.compose.foundation.layout.fillMaxSize
//import androidx.compose.foundation.layout.height
//import androidx.compose.foundation.layout.padding
//import androidx.compose.foundation.rememberScrollState
//import androidx.compose.foundation.verticalScroll
//import androidx.compose.material3.MaterialTheme
//import androidx.compose.material3.Text
//import androidx.compose.runtime.Composable
//import androidx.compose.ui.Modifier
//import androidx.compose.ui.graphics.Color
//import androidx.compose.ui.text.font.FontWeight
//import androidx.compose.ui.unit.dp
//
//@Composable
//fun HealthDataScreen() {
//    Column(
//        modifier = Modifier
//            .fillMaxSize()
//            .background(Color.White)
//            .verticalScroll(rememberScrollState())
//            .padding(16.dp)
//    ) {
//        Text(
//            text = "Health data",
//            style = MaterialTheme.typography.headlineMedium,
//            fontWeight = FontWeight.Bold,
//            modifier = Modifier.padding(bottom = 16.dp)
//        )
//
//        CardSection("Analyzing Health Data", subtitle = "AI", isChip = true)
//
//        Spacer(modifier = Modifier.height(8.dp))
//        RowPair("Body Mass Index (BMI)", "Heart Rate", "24.1", "💓", "0.2201")
//        RowPair("Body Shape Index", "Rate Pressure Product (RPP)", "0.078", "9000", "HR")
//
//        RowPair("Heart Rate Variability", "Blood Pressure (Sys/Dia)", "45", "118/78")
//
//        RowPair("Waist Circumference", "Abdomen Circumference", "82", "1.18")
//
//        TextSection("Body Composition", value = "4", icons = listOf(Color.Blue, Color.Blue, Color.Yellow, Color.Yellow))
//
//        RowPair("Hemoglobin", "Age", "13.5", "56", isAge = true)
//
//        RowPair("Overall Health Score", "Heart Function Strength", "💪", "🫀")
//
//        RowPair("Vital Signs Score", "Physical Wellness Score", "86", "🔋")
//
//        RowPair("Heart Attack Risk", "Metabolic Health Score", "Low", "78", isGauge = true)
//
//        RowPair("Stroke Risk Level", "Moderate", "🧠", "💧")
//
//        RowPair("Cardiovascular Risk Level", "Overall Risk Score", "Moderate", "40%")
//
//        TextSection("Signal Quality (SNR)", value = "Good (NR: 30 dB)", isHalfGauge = true)
//    }
//}
