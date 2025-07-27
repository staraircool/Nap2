plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.gms.google-services")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.napcoin_app"
    compileSdk = 34 // replace with flutter.compileSdkVersion if you're managing it globally
    ndkVersion = "27.0.12077973" // explicitly fix NDK version

    defaultConfig {
        applicationId = "com.example.napcoin_app"
        minSdk = 24 // replace with flutter.minSdkVersion if used
        targetSdk = 34 // replace with flutter.targetSdkVersion if used
        versionCode = 1 // replace with flutter.versionCode if used
        versionName = "1.0" // replace with flutter.versionName if used
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
            signingConfig = signingConfigs.getByName("debug") // change to release config later
        }
    }
}

dependencies {
    implementation(platform("com.google.firebase:firebase-bom:33.1.1"))
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-auth")
    implementation("com.google.firebase:firebase-firestore")
}

flutter {
    source = "../.."
}
