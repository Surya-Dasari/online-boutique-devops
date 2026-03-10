pipeline {

agent any

options {
        timeout(time: 30, unit: 'MINUTES')
        disableConcurrentBuilds()
        timestamps()
}
        
environment {
    NEXUS_URL = "http://localhost:8081/repository/ci-artifacts"
}

stages {

    stage('Checkout Code') {
        steps {
            checkout scm
        }
    }

    stage('Prepare Scripts') {
        steps {
            sh 'chmod +x scripts/*.sh'
        }
    }

    stage('Debug Info') {
        steps {
            sh 'echo Build Number: $BUILD_NUMBER'
            sh 'git rev-parse --short HEAD'
        }
    }

    stage('Build Services') {

        parallel failFast: true {

            stage('Build Go') {
                steps { sh './scripts/build-go.sh' }
            }

            stage('Build Node') {
                steps { sh './scripts/build-node.sh' }
            }

            stage('Build Python') {
                steps { sh './scripts/build-python.sh' }
            }

            stage('Build DotNet') {
                steps { sh './scripts/build-dotnet.sh' }
            }

            stage('Build Java') {
                steps { sh './scripts/build-java.sh' }
            }

        }

    }

    stage('SonarQube Scan') {
        steps {
          withCredentials([string(
            credentialsId: 'sonar-token',
            variable: 'SONAR_TOKEN'
          )]) {
              sh './scripts/sonarqube-scan.sh'
          }

    stage('Validate Artifacts') {
        steps {
            sh 'python3 scripts/validate_artifacts.py'
        }
    }

    stage('Upload Artifacts to Nexus') {

        steps {

            withCredentials([usernamePassword(
                credentialsId: 'nexus-creds-latest',
                usernameVariable: 'NEXUS_USER',
                passwordVariable: 'NEXUS_PASS'
            )]) {

                sh './scripts/upload-to-nexus.sh'
            }

        }

    }

    stage('Cleanup Old Nexus Artifacts') {

        steps {

            withCredentials([usernamePassword(
                credentialsId: 'nexus-creds-latest',
                usernameVariable: 'NEXUS_USER',
                passwordVariable: 'NEXUS_PASS'
            )]) {

                sh 'python3 scripts/cleanup-nexus.py'
            }

        }

    }

    stage('Build Container Images') {
        steps {
            sh './scripts/build-images.sh'
        }
    }

    stage('Push Images to Quay') {

        steps {

            withCredentials([usernamePassword(
                credentialsId: 'quay-robot-creds',
                usernameVariable: 'QUAY_USER',
                passwordVariable: 'QUAY_PASS'
            )]) {

                sh './scripts/push-images.sh'
            }

        }

    }

}

post {

    always {
        cleanWs()
    }

}

}

