import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("kotlin-parcelize")
    id("dev.flutter.flutter-gradle-plugin")
    id("org.jetbrains.kotlin.plugin.compose") version "2.0.0"// Flutter plugin must be last
}

android {
    buildFeatures {
        compose= true
    }
    namespace = "com.example.ntt_data"
    compileSdk = flutter?.compileSdkVersion ?: 33
    ndkVersion = "27.0.12077973"


    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

//    signingConfigs {
//        create("debug") {
//            keyAlias = "androiddebugkey"
//            keyPassword = "android"
//            storeFile = file("debug.keystore")
//            storePassword = "android"
//        }
//    }
 
    packagingOptions {
          jniLibs {
            useLegacyPackaging = true
        }
        pickFirst("lib/arm64-v8a/libc++_shared.so")
    }

    defaultConfig {
        applicationId = "com.example.ntt_data"
        minSdk = 27
        targetSdk = flutter?.targetSdkVersion ?: 33
        versionCode = flutter?.versionCode ?: 1
        versionName = flutter?.versionName ?: "1.0.0"

        buildFeatures {
            viewBinding = true
            buildConfig = true
        }

        // Load properties from 'server.properties' file safely
        val properties = Properties()
        file("server.properties").takeIf { it.exists() }?.inputStream()?.bufferedReader()?.useLines { lines ->
            properties.load(lines.joinToString("\n").byteInputStream())
        }

        val DFX_REST_URL = properties.getProperty("DFX_REST_URL") ?: ""
        val DFX_WS_URL = properties.getProperty("DFX_WS_URL") ?: ""
        val DFX_LICENSE_KEY = properties.getProperty("DFX_LICENSE_KEY") ?: ""
        val DFX_STUDY_ID = properties.getProperty("DFX_STUDY_ID") ?: ""

        // Pass values as BuildConfig fields
        buildConfigField("String", "DFX_REST_URL", "\"$DFX_REST_URL\"")
        buildConfigField("String", "DFX_WS_URL", "\"$DFX_WS_URL\"")
        buildConfigField("String", "DFX_LICENSE_KEY", "\"$DFX_LICENSE_KEY\"")
        buildConfigField("String", "DFX_STUDY_ID", "\"$DFX_STUDY_ID\"")
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug") // Ensure this exists
        }
    }

    repositories {
        flatDir {
            dirs("libs")
        }
    }

    dependencies {
        // Anura Core SDK
        implementation(files("libs/anura-core-sdk-2.4.8.304.aar"))
        implementation(files("libs/anura-opencv-4.5.1.aar"))
        implementation(files("libs/dfxsdk-4.13.4.aar"))
        implementation(files("libs/dfxextras-0.1.8.aar"))

        // Anura Core SDK Dependencies
        implementation("com.google.mediapipe:solution-core:0.10.15")
        implementation("com.google.mediapipe:facemesh:0.10.15")
        implementation("org.jetbrains.kotlinx:kotlinx-serialization-json:1.1.0")
        implementation("com.google.code.gson:gson:2.9.0")
        implementation("org.java-websocket:Java-WebSocket:1.4.1")
        implementation("org.jetbrains.kotlin:kotlin-stdlib:1.9.0") // Fixed version

        // AndroidX and UI Dependencies
        implementation("androidx.constraintlayout:constraintlayout:2.2.1")
        implementation("androidx.appcompat:appcompat:1.7.0")
        implementation("com.google.android.material:material:1.12.0")
        implementation("androidx.activity:activity-ktx:1.10.1")
        implementation("androidx.fragment:fragment-ktx:1.8.6")
        implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.7.3")
        implementation("androidx.recyclerview:recyclerview:1.4.0")
        implementation("androidx.activity:activity-compose")
        implementation("androidx.compose.material3:material3")
        implementation("androidx.compose.material3:material3-android:1.3.2")
        implementation("androidx.compose.ui:ui")
        implementation("androidx.compose.ui:ui-tooling-preview")
        implementation(platform("androidx.compose:compose-bom:2025.04.00"))
        implementation("androidx.activity:activity-compose")
    }
}
dependencies {
    implementation("androidx.compose.material3:material3-android:1.3.2")
    implementation("androidx.media3:media3-common-ktx:1.6.0")
}
//dependencies {
//    implementation("androidx.compose.runtime:runtime-android:1.7.8")
//    implementation("androidx.compose.material3:material3-android:1.3.2")
//
//}

flutter {
    source = "../.."
}
