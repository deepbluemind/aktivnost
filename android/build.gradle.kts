allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir = File(rootDir, "../../build")
buildDir = newBuildDir

subprojects {
    buildDir = File(newBuildDir, project.name)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
