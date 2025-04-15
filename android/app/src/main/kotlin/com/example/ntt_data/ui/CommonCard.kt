import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
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
fun CommonCard(
    title: String,
    subtitle: String,
    mass:String="",
    modifier: Modifier = Modifier
) {
    Card(
        shape = RoundedCornerShape(16.dp),
//        elevation = CardDefaults.cardElevation(defaultElevation = 2.dp),
        colors = CardDefaults.cardColors(containerColor = Color.White),
        modifier = modifier
            .width(170.dp)
            .height(165.dp)
            .padding(8.dp)
    ) {
        Column(
//            horizontalAlignment = Alignment.CenterHorizontally,
//            verticalArrangement = Arrangement.spacedBy(space = 3.dp,),

            verticalArrangement = Arrangement.SpaceBetween,

            modifier = Modifier.fillMaxSize().padding(8.dp)
        ) {
            // Title
            Text(
                text = title,
                style = MaterialTheme.typography.titleMedium,
                fontSize = 16.sp,
                fontWeight = FontWeight.W600,

            )
            Spacer(modifier = Modifier.height(20.dp))


                Text(
                    text = subtitle,
                    style = MaterialTheme.typography.bodyMedium,
                    color = Color(0xff0072BC),
                    fontWeight = FontWeight.W700,
                    textAlign = TextAlign.End,
                    fontSize = 24.sp,

                    )
                Text(
                    text = mass,
                    style = MaterialTheme.typography.bodyMedium,
                    color = Color.Black,
                    fontWeight = FontWeight.W700,
                    fontSize = 14.sp,

                    )



            // Subtitle with background image
//            Box(
//                modifier = Modifier
//                    .fillMaxWidth()
//                    .height(100.dp)
//                    .align(Alignment.CenterHorizontally).padding(12.dp)
//            ) {
//                Image(
//                    painter = painterResource(id = imageRes),
//                    contentDescription = null,
//                    contentScale = ContentScale.Crop,
//                    modifier = Modifier.matchParentSize()
//                )
//
//                Text(
//                    text = subtitle,
//                    style = MaterialTheme.typography.bodyMedium,
//                    color = Color(0xff0072BC),
//                    fontWeight = FontWeight.W700,
//                    fontSize = 24.sp,
//                    modifier = Modifier
//                        .align(Alignment.Center)
//                        .padding(8.dp)
//                )
//            }
        }
    }
}
