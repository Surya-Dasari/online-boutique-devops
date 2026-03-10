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

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Prepare Scripts') {
            steps {
                sh 'chmod +x scripts/*.sh'
            }
        }

        stage('Build Services') {

            failFast true

            parallel {

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
                    steps {
                        dir('src/adservice') {
                            sh 'chmod +x gradlew'
                            sh './gradlew clean build'
                        }
                    }
                }

            }
        }

        stage('Sonar Scan') {

            steps {

                script {

                    def scannerHome = tool 'SonarScanner'

                    withCredentials([string(
                        credentialsId: 'sonar-token',
                        variable: 'SONAR_TOKEN'
                    )]) {

                        sh """
                        ${scannerHome}/bin/sonar-scanner \
                        -Dsonar.projectKey=online-boutique \
                        -Dsonar.sources=. \
                        -Dsonar.host.url=http://localhost:9000 \
                        -Dsonar.exclusions=**/*.java,**/venv/**,**/node_modules/**,**/build/**,**/obj/** \
                        -Dsonar.token=$SONAR_TOKEN
                        """

                    }
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
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
