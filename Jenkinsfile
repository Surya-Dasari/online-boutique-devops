pipeline {

agent any

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
            sh '''
            echo BUILD_NUMBER=$BUILD_NUMBER
            git rev-parse --short HEAD
            '''
        }
    }

    stage('Build Services') {

        parallel {

            stage('Go Services') {
                steps {
                    sh './scripts/build-go.sh'
                }
            }

            stage('Node Services') {
                steps {
                    sh './scripts/build-node.sh'
                }
            }

            stage('Python Services') {
                steps {
                    sh './scripts/build-python.sh'
                }
            }

            stage('.NET Service') {
                steps {
                    sh './scripts/build-dotnet.sh'
                }
            }

            stage('Java Service') {
                steps {
                    sh './scripts/build-java.sh'
                }
            }

        }

    }

    stage('Validate Artifacts') {
        steps {
            sh 'python3 scripts/validate_artifacts.py'
        }
    }

    stage('Show Artifacts') {
        steps {
            sh '''
            echo "Artifacts:"
            find src -name "*${BUILD_NUMBER}*"
            '''
        }
    }

}


}

