import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.LinearProgressIndicator
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp

@Composable
fun RowPair(
    label1: String,
    label2: String,
    value1: String,
    value2: String,
    middleLabel: String = "",
    isAge: Boolean = false,
    isGauge: Boolean = false
) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(vertical = 8.dp),
        horizontalArrangement = Arrangement.SpaceBetween
    ) {
        Column(modifier = Modifier.weight(1f)) {
            Text(text = label1, style = MaterialTheme.typography.bodySmall)
            Text(text = value1, fontWeight = FontWeight.Bold)
        }
        Spacer(modifier = Modifier.width(16.dp))
        Column(modifier = Modifier.weight(1f)) {
            Text(text = label2, style = MaterialTheme.typography.bodySmall)
            if (isAge) {
                CircularProgressWithText(value2.toInt())
            } else if (isGauge) {
                GaugeProgress(value2.toFloat())
            } else {
                Text(text = value2, fontWeight = FontWeight.Bold)
            }
        }
    }
}

@Composable
fun TextSection(title: String, value: String, icons: List<Color> = emptyList(), isHalfGauge: Boolean = false) {
    Column(modifier = Modifier.padding(vertical = 8.dp)) {
        Text(text = title, style = MaterialTheme.typography.bodySmall)
        if (icons.isNotEmpty()) {
            Row {
                icons.forEach {
                    Box(
                        modifier = Modifier
                            .size(16.dp)
                            .background(it, shape = CircleShape)
                            .padding(4.dp)
                    )
                    Spacer(modifier = Modifier.width(4.dp))
                }
            }
        } else if (isHalfGauge) {
            HalfGauge()
        } else {
            Text(text = value, fontWeight = FontWeight.Bold)
        }
    }
}

@Composable
fun CircularProgressWithText(percent: Int) {
    Box(
        contentAlignment = Alignment.Center,
        modifier = Modifier.size(48.dp)
    ) {
        CircularProgressIndicator(
            progress = percent / 100f,
            strokeWidth = 4.dp,
            color = if (percent < 40) Color.Red else if (percent < 70) Color.Yellow else Color.Green
        )
    }
}

@Composable
fun GaugeProgress(value: Float) {
    // Placeholder — can be replaced with a custom gauge arc
    LinearProgressIndicator(
        progress = value / 100,
        modifier = Modifier
            .fillMaxWidth()
            .height(8.dp)
            .clip(RoundedCornerShape(4.dp)),
        color = Color.Green
    )
}

@Composable
fun HalfGauge() {
    // Placeholder arc or image showing half-circle meter
    Canvas(modifier = Modifier.size(60.dp)) {
        drawArc(
            color = Color(0xFFFFA726),
            startAngle = 180f,
            sweepAngle = 180f,
            useCenter = false,
            style = Stroke(width = 12f)
        )
    }
}
