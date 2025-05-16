import androidx.compose.foundation.Image
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
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.ntt_data.ui.SeamlessCircularProgressIndicator

@Composable
fun CenteredContentCard(
    title: String,
    subtitle: String="",
    imageRes: Int=0,
    maxProgress: Float = 100f,
    mass:String="",
    width:Double=170.0,
    value:Double=0.0,
    age:Double=0.0,
    borderColor:Color=Color.Transparent,
    drawArcColor:Color=Color.Transparent,
    isWidget:Boolean=false,
    isFullWidth:Boolean=false,
    isWidgetWithText:Boolean=false,
    modifier: Modifier = Modifier
) {
    Card(
        shape = RoundedCornerShape(16.dp),

        colors = CardDefaults.cardColors(containerColor = Color.White),
        modifier = modifier
            .width(width.dp)
            .height(200.dp)
            .padding(8.dp)
    ) {
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(16.dp),
            horizontalAlignment = Alignment.CenterHorizontally,

        ) {
            Text(
                text = title,
                style = MaterialTheme.typography.titleMedium,
                fontWeight = FontWeight.W600,
                fontSize = 16.sp,
                textAlign = TextAlign.Center
            )

            Spacer(modifier = Modifier.height(12.dp))
        if(isWidget){
              SeamlessCircularProgressIndicator(value.toFloat(),maxProgress=maxProgress, borderColor = borderColor, drawArcColor = drawArcColor, age = value)
        }else{
            if(isWidgetWithText){
                Box(Modifier.width(80.dp).height(80.dp)){
                    SeamlessCircularProgressIndicator(value.toFloat(),maxProgress=maxProgress, borderColor = borderColor, drawArcColor = drawArcColor, age = value)

                }
            }else{
                if (isFullWidth){
                    Image(
                        painter = painterResource(id = imageRes),
                        contentDescription = null,
                        modifier = Modifier
                            .height(80.dp)
                            .fillMaxWidth(),
                        contentScale = ContentScale.Fit
                    )
                }else{
                    Image(
                        painter = painterResource(id = imageRes),
                        contentDescription = null,
                        modifier = Modifier
                            .height(45.dp)
                            .fillMaxWidth(),
                        contentScale = ContentScale.Fit
                    )
                }

//                Spacer(modifier = Modifier.height(12.dp))

                Text(
                    text = subtitle,
                    style = MaterialTheme.typography.bodyMedium,
                    color = Color(0xff0072BC),
                    fontWeight = FontWeight.W700,
                    textAlign = TextAlign.Center,
                    fontSize = 24.sp,
                )
                Text(
                    text = mass,
                    style = MaterialTheme.typography.bodyMedium,
                    color = Color.Black,
                    fontWeight = FontWeight.W400,
                    textAlign = TextAlign.Center,
                    fontSize = 14.sp,

                    )
            }


        }



        }
    }
}
