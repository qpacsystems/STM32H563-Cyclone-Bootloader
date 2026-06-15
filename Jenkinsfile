pipeline
{
    agent any
    options
    {
        skipDefaultCheckout()
    }

    stages
    {
        stage('Checkout')
        {
            steps
            {
                cleanWs()
                checkout scm
                script {
                    def versionBase = readFile('version.txt').trim()
                    def commitCount = bat(returnStdout: true, script: '@git rev-list --count HEAD').trim()
                    env.LIB_VERSION = "${versionBase}.${commitCount}"
                    echo "Bootloader version: ${env.LIB_VERSION}"
                }
            }
        }
        stage('Build Bootloader using GCC Toolchain')
        {
            steps
            {
                echo 'Building bootloader with GCC...'
                bat """
                    cmake --preset \"GCC Release Configure\" -S \"%WORKSPACE%\"
                    cmake --build --preset \"GCC Release\"
                """
                echo 'GCC build complete'
            }
        }
        stage('Build Bootloader using IAR Toolchain')
        {
            steps
            {
                echo 'Building bootloader with IAR...'
                bat """
                    cmake --preset \"IAR Release Configure\" -S \"%WORKSPACE%\"
                    cmake --build --preset \"IAR Release\"
                """
                echo 'IAR build complete'
            }
        }
        stage('CPP Check')
        {
            steps
            {
                echo 'Running cppcheck...'
                bat "${env.WORKSPACE}\\tools\\cppcheck.bat"
                publishCppcheck pattern:'cppcheck.xml'
                script {
                    def cppcheckXml = readFile 'cppcheck.xml'
                    def errorTags = cppcheckXml.split('<error')
                    def errorCount = errorTags.length - 1

                    echo "Cppcheck found ${errorCount} issues"

                    if (errorCount > 499) {
                        error("Cppcheck failed: Found ${errorCount} issues, which exceeds the limit of 499")
                    }
                }
            }
        }
        stage('Complexity Analysis')
        {
            steps
            {
                bat 'lizard src --warnings_only --sort "cyclomatic_complexity" -C=10 --length=50 -H > lizard_report.html'
                archiveArtifacts artifacts: 'lizard_report.html', allowEmptyArchive: true
                publishHTML(target: [
                    keepAll: true,
                    reportDir: '.',
                    reportFiles: 'lizard_report.html',
                    reportName: 'Lizard Complexity',
                    useWrapperFileDirectly: true
                ])
            }
        }
        stage('Archive Artifacts')
        {
            steps
            {
                archiveArtifacts artifacts: 'build\\gcc\\release\\bootloader.bin', fingerprint: true
                archiveArtifacts artifacts: 'build\\gcc\\release\\bootloader.hex', fingerprint: true
                archiveArtifacts artifacts: 'build\\iar\\release\\bootloader.bin', allowEmptyArchive: true
                archiveArtifacts artifacts: 'build\\iar\\release\\bootloader.hex', allowEmptyArchive: true
            }
        }
    }/* stages */
    post
    {
        always
        {
            cleanWs()
        }
    }
}/* pipeline */
