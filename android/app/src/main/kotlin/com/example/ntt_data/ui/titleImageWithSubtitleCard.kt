import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.LineHeightStyle
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@Composable
fun TitleWithImageSubtitleCard(
    title: String,
    subtitle: String,
    imageRes: Int,
    mass: String = "",
    perMass: String = "",
    modifier: Modifier = Modifier
) {
    Card(
        shape = RoundedCornerShape(16.dp),
        colors = CardDefaults.cardColors(containerColor = Color.White),
        modifier = modifier
            .width(170.dp)
            .height(190.dp)
            .padding(8.dp)
    ) {
        Column(
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.SpaceBetween,
            modifier = Modifier.fillMaxSize()
        ) {
            // Title
            Text(
                text = title,
                style = MaterialTheme.typography.titleMedium,
                fontSize = 16.sp,
                fontWeight = FontWeight.W700,
                textAlign = TextAlign.Center,
                modifier = Modifier.padding(8.dp)
            )

            // Subtitle over background image
            Box(
                modifier = Modifier
                    .width(137.dp)
                    .height(80.dp)
                    .padding(bottom = 10.dp),
                contentAlignment = Alignment.Center // Ensures the content (Column) is centered over the image
            ) {
                // Custom-sized image
                Image(
                    painter = painterResource(id = imageRes),
                    contentDescription = null,
//                    contentScale = ContentScale.Crop,
                    modifier = Modifier
                        .width(95.dp) // 👈 custom width
                        .height(80.dp) // 👈 custom height
                        .align(Alignment.Center).padding(bottom = 20.dp) // optional for layout clarity
                )

                // Centered overlay text
                Column(
                    horizontalAlignment = Alignment.CenterHorizontally,
                    modifier = Modifier
                        .align(Alignment.Center)
                        .padding(15.dp)
                ) {
                    Row(

                        verticalAlignment = Alignment.CenterVertically) {
                        Text(
                            text = subtitle,
                            style = MaterialTheme.typography.bodyMedium,
                            color = Color(0xff0072BC),
                            fontWeight = FontWeight.W700,
                            textAlign = TextAlign.Center,
                            fontSize = 24.sp,
                        )
                        Text(
                            text = perMass,
                            style = MaterialTheme.typography.bodyMedium,
                            color = Color(0xff0072BC),
                            fontWeight = FontWeight.W700,
                            textAlign = TextAlign.Center,
                            fontSize = 24.sp,
                        )
                    }
                    Text(
                        text = mass,
                        style = MaterialTheme.typography.bodyMedium,
                        color = Color.Black,
                        fontWeight = FontWeight.W400,
                        textAlign = TextAlign.Center,
                        fontSize = 14.sp,
                        modifier = Modifier.padding(top = 4.dp)
                    )
                }
            }

        }
    }
}
