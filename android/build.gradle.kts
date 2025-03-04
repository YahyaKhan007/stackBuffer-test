allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Set a custom build directory
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    // Set custom build directory for subprojects
    project.layout.buildDirectory.set(newBuildDir.dir(project.name))

    // Optional: Ensure evaluation order if needed
    project.evaluationDependsOn(":app")
}

// Clean task to clear the custom build directory
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
