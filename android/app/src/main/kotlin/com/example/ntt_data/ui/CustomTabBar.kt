package com.example.ntt_data.ui

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.pager.HorizontalPager
import androidx.compose.foundation.pager.rememberPagerState
import androidx.compose.material3.*
import androidx.compose.material3.TabRowDefaults.tabIndicatorOffset
import androidx.compose.runtime.*
import androidx.compose.ui.*
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
        TabRow(
            selectedTabIndex = pagerState.currentPage,
            containerColor = AppColors.tabBackgroundColor,
            contentColor = AppColors.btnText,
            indicator = { tabPositions ->
                Box(
                    Modifier
                        .tabIndicatorOffset(tabPositions[pagerState.currentPage])
                        .padding(horizontal = 5.dp)
                        .fillMaxHeight()
                        .background(AppColors.primary, shape = RoundedCornerShape(24.dp))
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
                    selectedContentColor =Color.White,
                    unselectedContentColor = Color.Gray,
                    modifier = Modifier.padding(vertical = 5.dp, horizontal = 5.dp)
                ) {
                    Text(
                        text = title,
                        fontSize = 16.sp,
                        fontWeight = FontWeight.W400,

//                        fontFamily = FontFamily(Font(R.font.gilroy_medium))
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
