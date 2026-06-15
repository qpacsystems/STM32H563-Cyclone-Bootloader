pipeline
{
    agent any
    options
    {
        timeout(time: 90, unit: 'MINUTES')
        disableConcurrentBuilds(abortPrevious: true)
        buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '2'))
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
                archiveArtifacts artifacts: 'cppcheck.xml', allowEmptyArchive: true
                discoverGitReferenceBuild(referenceJob: 'STM32H563_CYCLONE_BOOTLOADER_DEVELOP/develop')
                withChecks('CppCheck') {
                    recordIssues(
                        tools: [cppCheck(pattern: 'cppcheck.xml')],
                        qualityGates: [[threshold: 1, type: 'NEW', unstable: false]]
                    )
                }
            }
        }
        stage('Complexity Analysis')
        {
            steps
            {
                bat 'lizard src --warnings_only --sort "cyclomatic_complexity" -C=10 --length=50 -H > lizard_report.html'
                bat 'lizard src --warnings_only --sort "cyclomatic_complexity" -C=10 --length=50 -X > lizard_report.xml'
                archiveArtifacts artifacts: 'lizard_report.html', allowEmptyArchive: true
                archiveArtifacts artifacts: 'lizard_report.xml', allowEmptyArchive: true
                publishHTML(target: [
                    keepAll: true,
                    reportDir: '.',
                    includes: 'lizard_report.html',
                    reportFiles: 'lizard_report.html',
                    reportName: 'Lizard Complexity',
                    useWrapperFileDirectly: true
                ])
                script {
                    def title = 'Report available on Jenkins'
                    try {
                        def xml = readFile('lizard_report.xml')
                        def start = xml.indexOf('<measure type="Function">')
                        def end = xml.indexOf('</measure>', start)
                        if (start >= 0 && end > start) {
                            def section = xml.substring(start, end)
                            def warningCount = section.split('<item ').length - 1
                            title = "${warningCount} functions over CCN 10 / length 50"
                        }
                    } catch (Exception ignored) { }
                    publishChecks name: 'Complexity', title: title,
                        summary: 'Lizard cyclomatic complexity / function length warnings.',
                        detailsURL: "${env.BUILD_URL}Lizard_20Complexity/"
                }
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
}/* pipeline */
