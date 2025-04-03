import java.util.Properties
import java.io.FileInputStream
plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
     id("kotlin-parcelize")
}
android {
    namespace = "com.example.ntt_data"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

   kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.ntt_data"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 25
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

 buildFeatures {
            buildConfig = true
        }


// Declare variables with default empty values
        var DFX_REST_URL: String = ""
        var DFX_WS_URL: String = ""
        var DFX_LICENSE_KEY: String = ""
        var DFX_STUDY_ID: String = ""

        val propertiesFile = file("server.properties")

        if (propertiesFile.exists()) {
            val properties = Properties().apply {
                load(FileInputStream(propertiesFile))
            }

            // Assign values from properties file
            DFX_REST_URL = properties.getProperty("DFX_REST_URL", "")
            DFX_WS_URL = properties.getProperty("DFX_WS_URL", "")
            DFX_LICENSE_KEY = properties.getProperty("DFX_LICENSE_KEY", "")
            DFX_STUDY_ID = properties.getProperty("DFX_STUDY_ID", "")
        }

// Print to verify (Optional)
        println("DFX_REST_URL: $DFX_REST_URL")
        println("DFX_WS_URL: $DFX_WS_URL")
        println("DFX_LICENSE_KEY: $DFX_LICENSE_KEY")
        println("DFX_STUDY_ID: $DFX_STUDY_ID")


        buildConfigField("String", "DFX_REST_URL", "\"$DFX_REST_URL\"")
        buildConfigField("String", "DFX_WS_URL", "\"$DFX_WS_URL\"")
        buildConfigField("String", "DFX_LICENSE_KEY", "\"$DFX_LICENSE_KEY\"")
        buildConfigField("String", "DFX_STUDY_ID", "\"$DFX_STUDY_ID\"")

        ndk {
            abiFilters += "arm64-v8a"
        }
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    repositories {
        flatDir {
            dirs("libs")
        }
    }
    dependencies {

        // Anura Core SDK

//        implementation fileTree(dir: "libs", include: ["*.aar"])
        implementation(files("libs/anura-core-sdk-2.4.8.304.aar"))
        implementation(files("libs/anura-opencv-4.5.1.aar"))
        implementation(files("libs/dfxsdk-4.13.4.aar"))
        implementation(files("libs/dfxextras-0.1.8.aar"))
//        implementation(name:'anura-visag-2.4.0.5264',ext:'aar')

        // Anura Core SDK Dependencies
        implementation("com.google.mediapipe:solution-core: 0.10.15")
        implementation("com.google.mediapipe:facemesh:0.10.15")
        implementation("org.jetbrains.kotlinx:kotlinx-serialization-json:1.1.0")
        implementation("com.google.code.gson:gson:2.9.0")
        implementation("org.java-websocket:Java-WebSocket:1.4.1")
        implementation("org.jetbrains.kotlin:kotlin-stdlib:2.1.20")

        // Anura Sample App Dependencies
        implementation("androidx.constraintlayout:constraintlayout:2.1.4")
        implementation("androidx.appcompat:appcompat:1.6.1")
        implementation("com.google.android.material:material:1.9.0")
        implementation("androidx.activity:activity-ktx:1.7.2")
        implementation("androidx.fragment:fragment-ktx:1.6.0")
        implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.3.9")
        implementation("androidx.recyclerview:recyclerview:1.3.0")
    }
}

flutter {
    source = "../.."
}
