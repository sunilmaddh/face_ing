package com.example.ntt_data.ui

import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier

@Composable
fun SampleTabScreen() {
    val tabs = listOf("All", "Vital", "Tab 3", "Tab 4")
    val contents = listOf<@Composable () -> Unit>(
        { Text("Content 1", modifier = Modifier.fillMaxSize()) },
        { Text("Content 2", modifier = Modifier.fillMaxSize()) },
        { Text("Content 3", modifier = Modifier.fillMaxSize()) },
        { Text("Content 4", modifier = Modifier.fillMaxSize()) },
    )

    CustomTabBar(tabTitles = tabs, tabContents = contents)
}
