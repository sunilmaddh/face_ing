package com.face.face.ui

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.pager.HorizontalPager
import androidx.compose.foundation.pager.rememberPagerState
import androidx.compose.material3.*
import androidx.compose.material3.TabRowDefaults.tabIndicatorOffset
import androidx.compose.runtime.*
import androidx.compose.ui.*
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.*
import androidx.compose.ui.unit.*
import kotlinx.coroutines.launch

@Composable
fun CustomTabBar(
    tabTitles: List<String>,
    tabContents: List<@Composable () -> Unit>,
) {
    val pagerState = rememberPagerState(pageCount = { tabTitles.size })
    val coroutineScope = rememberCoroutineScope()

    Column(
        modifier = Modifier
            .padding(start = 15.dp, end = 15.dp, top = 10.dp)
            .fillMaxSize()
    ) {
        Surface(modifier = Modifier.padding(4.dp).clip(RoundedCornerShape(24.dp)).background(Color.Gray), tonalElevation = 4.dp) {
            ScrollableTabRow(
                edgePadding = 0.dp,
                selectedTabIndex = pagerState.currentPage,
                containerColor = Color.Transparent,

                contentColor = AppColors.btnText,
                indicator = { tabPositions ->
                    Box(
                        Modifier
                            .tabIndicatorOffset(tabPositions[pagerState.currentPage])
                            .padding(horizontal = 1.dp)
                            .fillMaxHeight()
                            .background(Color.Transparent).height(36.dp)
                    )
                },
                divider = {}
            ) {
                tabTitles.forEachIndexed { index, title ->
                    Tab(
                        selected = pagerState.currentPage == index,
                        onClick = {
                            coroutineScope.launch {
                                pagerState.animateScrollToPage(index)
                            }
                        },
                        modifier = Modifier.padding(top = 4.dp, bottom = 4.dp, start = 2.dp, end = 2.dp).clip(RoundedCornerShape(24.dp)).background(if (pagerState.currentPage==index)Color(0xFF0072BC) else Color.Transparent),
                        selectedContentColor =Color.White,
                        unselectedContentColor = Color.Gray,
                        text = {
                            Text(
                                text = title,
                                fontSize = 12.sp,
                                fontWeight = FontWeight.W700,
                                maxLines = 1

//                        fontFamily = FontFamily(Font(R.font.gilroy_medium))
                            )
                        }
//                        modifier = Modifier.padding(vertical = 5.dp, horizontal = 5.dp)
                    )
                }
            }
        }


        Spacer(modifier = Modifier.height(10.dp))

        HorizontalPager(
            state = pagerState,
            modifier = Modifier.fillMaxSize()
        ) { page ->
            tabContents[page].invoke()
        }
    }
}
