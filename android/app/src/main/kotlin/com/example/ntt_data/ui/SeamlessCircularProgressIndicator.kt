package com.example.ntt_data.ui
import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.animation.core.tween
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.size
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@Composable
fun SeamlessCircularProgressIndicator(
    progress: Float,
    maxProgress: Float = 100f,
    age: Double,
    borderColor: Color,
    drawArcColor: Color,
    years:String="",
    modifier: Modifier = Modifier,
    size: Dp = 100.dp,
    baseStrokeWidth: Dp = 8.dp
) {
    val normalizedProgress = (progress / maxProgress).coerceIn(0f, 1f)

    val animatedProgress by animateFloatAsState(
        targetValue = normalizedProgress,
        animationSpec = tween(durationMillis = 800),
        label = "AnimatedProgress"
    )

    val animatedAge by animateFloatAsState(
        targetValue = (normalizedProgress * age).toFloat(),
        animationSpec = tween(durationMillis = 800),
        label = "AnimatedAge"
    )

    val dynamicStrokeWidth = (baseStrokeWidth.value + (animatedProgress * 8)).dp

    Box(
        modifier = modifier.size(size),
        contentAlignment = Alignment.Center
    ) {
        Canvas(modifier = Modifier.fillMaxSize()) {
            val sweep = 360 * animatedProgress

            // Background arc
            drawArc(
                color = borderColor,
                startAngle = 0f,
                sweepAngle = 360f,
                useCenter = false,
                style = Stroke(width = (dynamicStrokeWidth.toPx() - 2), cap = StrokeCap.Butt)
            )

            // Foreground progress arc
            drawArc(
                color =drawArcColor ,
                startAngle = -90f,
                sweepAngle = sweep,
                useCenter = false,
                style = Stroke(width = dynamicStrokeWidth.toPx(), cap = StrokeCap.Butt)
            )
        }

        // Centered animated age text
         Text(
            text = "${age.toInt()}",
            color = Color.Black,
            fontSize = 18.sp
        )



    }
}
