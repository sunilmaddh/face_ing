package com.example.ntt_data.ui

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.layout.size
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp

@Composable
fun SeamlessCircularProgressIndicator(
    progress: Float,
    modifier: Modifier = Modifier,
    size: Dp = 100.dp,
    strokeWidth: Dp = 8.dp
) {
    val clampedProgress = progress.coerceIn(0f, 1f)
    val borderColor = when {
        clampedProgress < 0.4f -> Color.Red
        clampedProgress < 0.7f -> Color.Yellow
        else -> Color.Green
    }

    Canvas(modifier = modifier.size(size)) {
        val diameter = size.toPx()
        val sweep = 360 * clampedProgress
        val stroke = Stroke(width = strokeWidth.toPx(), cap = StrokeCap.Butt)

        // Draw the track (remaining background circle)
        drawArc(
            color = Color.LightGray,
            startAngle = 0f,
            sweepAngle = 360f,
            useCenter = false,
            style = stroke
        )

        // Draw the progress arc without gap
        drawArc(
            color = borderColor,
            startAngle = -90f,
            sweepAngle = sweep,
            useCenter = false,
            style = stroke
        )
    }
}