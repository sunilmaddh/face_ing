allprojects {
    repositories {
        google()
        mavenCentral()
        flatDir {
            dirs("libs")
        }
    }
}

ext {
//    sourceCompatibilityVersion = JavaVersion.VERSION_17
//    targetCompatibilityVersion = JavaVersion.VERSION_17

    val kotlinXJsonSerialization = "1.1.0"
    val kotlinxCoroutinesVersion = "1.3.9"
    val websocketVersion = "1.4.1"
    val androidxActivityVersion = "1.7.2"
    val androidxFragmentVersion = "1.6.0"
    val androidxAppCompatVersion = "1.6.1"
    val androidxConstraintlayoutVersion = "2.1.4"
    val androidxRecyclerviewVersion = "1.3.0"
    val gsonVersion = "2.9.0"
    val materialVersion = "1.9.0"
    val mediaPipeVersion = "0.10.15"
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
